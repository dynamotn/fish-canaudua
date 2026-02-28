function __canaudua_setup -a fish_bind_mode
    # Inherit variables from last process while async
    set -g fish_bind_mode $fish_bind_mode

    set -g canaudua_last_pipestatus (string split ' ' $canaudua_last_pipestatus)

    for setting in items glyph color command glob other
        printf 'set -U canaudua_%s\n' (command cat ~/.config/fish/functions/setting/$setting) | source
    end

    set -l left_prompt (__canaudua_side_prompt left)
    set -l right_prompt (__canaudua_side_prompt right)
    set -l left_transient_prompt (__canaudua_side_prompt left_transient)
    set -l right_transient_prompt (__canaudua_side_prompt right_transient)

    # @fish-lsp-disable 2003
    if test "$canaudua_prompt_lines" = 2
        set -l character_prompt (__canaudua_character_prompt)
        # Store 3 elements: left_line1, right_line1, char_line2
        # fish_prompt will align right_line1 to the right on line 1
        set -U canaudua_left_prompt_$canaudua_pid $left_prompt $right_prompt $character_prompt' '
        set -U canaudua_right_prompt_$canaudua_pid ''
    else
        set -U canaudua_left_prompt_$canaudua_pid $left_prompt' '
        set -U canaudua_right_prompt_$canaudua_pid $right_prompt
    end
    set -U canaudua_left_transient_prompt_$canaudua_pid $left_transient_prompt' '
    set -U canaudua_right_transient_prompt_$canaudua_pid $right_transient_prompt
end
