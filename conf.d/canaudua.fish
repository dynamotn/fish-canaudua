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

# Migration: earlier versions cached glob lookups in per-directory universal
# variables (canaudua_glob_<path>_<type>) that were never removed, so
# ~/.config/fish/fish_variables grew without bound over time. Glob checks are
# no longer cached this way, so purge any leftovers created by older versions
# of this plugin.
set -l _canaudua_stale_glob_vars (set -n | string match -r '^canaudua_glob_.*')
if set -q _canaudua_stale_glob_vars[1]
    for var in $_canaudua_stale_glob_vars
        set -e $var
    end
end

# The async prompt renderer stores its output in universal variables scoped
# to the shell's PID (canaudua_{left,right}_{,transient_}prompt_<pid>), same
# as tide does. They are normally removed by __canaudua_exit on a clean
# `fish_exit`, but that handler never runs if the shell dies abnormally
# (killed, crashed, terminal force-closed, power loss, etc.), so entries for
# dead PIDs can accumulate in fish_variables forever. Sweep them on every new
# shell startup, keeping only vars whose PID still maps to a live process.
for var in (set -n | string match -r '^canaudua_(?:left|right)_(?:transient_)?prompt_[0-9]+$')
    string match -qr '_(?<pid>[0-9]+)$' -- $var
    kill -0 $pid 2>/dev/null; or set -e $var
end
