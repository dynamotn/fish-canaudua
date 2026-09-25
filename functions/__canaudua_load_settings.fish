function __canaudua_load_settings
    # Defaults live in functions/setting/* and are published as universal
    # variables so they can be tweaked live, without restarting the shell.
    #
    # Applying them is deliberately *not* done per prompt: every `set -U`
    # rewrites ~/.config/fish/fish_variables through a temporary
    # `fish_variables<random>` file, and with 160+ settings written by
    # concurrent background prompt renderers those temporaries piled up in
    # ~/.config/fish by the hundreds. Instead the defaults are compared
    # against a fingerprint of the setting files and only rewritten when the
    # plugin itself ships different ones, which also means a user's own
    # `set -U canaudua_*` override now survives the next prompt.
    set -l setting_dir ~/.config/fish/functions/setting
    set -l settings (command cat $setting_dir/items $setting_dir/glyph \
        $setting_dir/color $setting_dir/command $setting_dir/glob \
        $setting_dir/other)

    set -l fingerprint (string join \n -- $settings)
    test "$fingerprint" = "$canaudua_settings_fingerprint"; and return

    printf 'set -U canaudua_%s\n' $settings | source
    set -U canaudua_settings_fingerprint $fingerprint
end
