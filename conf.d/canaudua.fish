function __canaudua_uninstall -e canaudua_uninstall
    bind --user | string replace --filter --regex -- "bind (.+)( '?__canaudua.*)" 'bind -e $1' | source
    set -n | string replace -fr '(^canaudua.*)' 'set -e $1' | source
    functions -e (functions -a | string match -er '^__canaudua_')
    source (functions --details fish_prompt)
end

function __canaudua_install -e canaudua_install
    __canaudua_binding
    __canaudua_uninstall
end

function __canaudua_binding
    bind ' ' __canaudua_show_on_command
    bind -M insert ' ' __canaudua_show_on_command
    if __canaudua_semver_compare $FISH_VERSION 4.2.0
        set -g fish_transient_prompt 1
    else
        bind \r __canaudua_enter_transient
        bind -M insert \r __canaudua_enter_transient
        bind \n __canaudua_enter_transient
        bind -M insert \n __canaudua_enter_transient
    end
end

__canaudua_binding

# Publish the default settings as universal variables. Interactive shells only:
# the background prompt renderer (`fish -c __canaudua_setup`) reads the very
# same universal variables, so making it re-apply them would only add writes to
# ~/.config/fish/fish_variables on every single prompt.
status is-interactive; and __canaudua_load_settings

# fish writes ~/.config/fish/fish_variables atomically: it fills a
# `fish_variables<10 random chars>` temporary next to it and renames it into
# place. fish_prompt kills the previous background renderer on every new
# prompt, and a renderer killed between those two steps leaves its temporary
# behind forever -- which is how ~/.config/fish filled up with hundreds of
# them. Writing a single universal variable per render makes that window tiny,
# but not zero, so also sweep whatever did slip through. The pattern cannot
# match `fish_variables` itself, and the age cut-off keeps a temporary that a
# live fish is writing right now out of reach.
status is-interactive; and command find $__fish_config_dir \
    -maxdepth 1 \
    -type f \
    -name 'fish_variables??????????' \
    -mmin +5 \
    -delete 2>/dev/null

# The sweeps below erase universal variables, which is itself a write to
# ~/.config/fish/fish_variables, so keep them out of the background renderer.
if status is-interactive
    # Migration: earlier versions cached glob lookups in per-directory universal
    # variables (canaudua_glob_<path>_<type>) that were never removed, so
    # ~/.config/fish/fish_variables grew without bound over time. Glob checks are
    # no longer cached this way, so purge any leftovers created by older versions
    # of this plugin.
    for var in (set -n | string match -r '^canaudua_glob_.*')
        set -e $var
    end

    # The async prompt renderer stores its output in a universal variable scoped to
    # the shell's PID (canaudua_prompt_<pid>). It is normally removed by
    # __canaudua_exit on a clean `fish_exit`, but that handler never runs if the
    # shell dies abnormally (killed, crashed, terminal force-closed, power loss,
    # etc.), so entries for dead PIDs can accumulate in fish_variables forever.
    # Sweep them on every new shell startup, keeping only vars whose PID still maps
    # to a live process. The canaudua_{left,right}_{,transient_}prompt_<pid> names
    # are the pre-consolidation layout and are always stale.
    for var in (set -n | string match -r '^canaudua_(?:left_|right_)?(?:transient_)?prompt_[0-9]+$')
        string match -qr '_(?<pid>[0-9]+)$' -- $var
        if string match -q 'canaudua_prompt_*' -- $var
            kill -0 $pid 2>/dev/null; or set -e $var
        else
            set -e $var
        end
    end
end
