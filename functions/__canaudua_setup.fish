function __canaudua_setup -a fish_bind_mode
    # Inherit variables from last process while async
    set -g fish_bind_mode $fish_bind_mode

    string split ' ' $canaudua_last_pipestatus | read -g canaudua_last_pipestatus

    for setting in items glyph color command glob
        printf 'set -g canaudua_%s\n' (command cat ~/.config/fish/functions/setting/$setting) | source
    end

    __canaudua_side_prompt left | read -l left_prompt
    __canaudua_side_prompt right | read -l right_prompt
    __canaudua_side_prompt left_transient | read -l left_transient_prompt
    __canaudua_side_prompt right_transient | read -l right_transient_prompt
    set -g canaudua_left_prompt_$canaudua_pid $left_prompt' '
    set -g canaudua_right_prompt_$canaudua_pid $right_prompt
    set -g canaudua_left_transient_prompt_$canaudua_pid $left_transient_prompt' '
    set -g canaudua_right_transient_prompt_$canaudua_pid $right_transient_prompt
end
