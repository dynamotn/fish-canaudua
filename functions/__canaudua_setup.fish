function __canaudua_setup -a fish_bind_mode
    # Inherit variables from last process while async
    set -g fish_bind_mode $fish_bind_mode

    set -g canaudua_last_pipestatus (string split ' ' $canaudua_last_pipestatus)

    set -l left_prompt (__canaudua_side_prompt left)
    set -l right_prompt (__canaudua_side_prompt right)
    set -l left_transient_prompt (__canaudua_side_prompt left_transient)
    set -l right_transient_prompt (__canaudua_side_prompt right_transient)

    # Publish the rendered prompt as a single universal variable. Each `set -U`
    # rewrites ~/.config/fish/fish_variables through a temporary
    # `fish_variables<random>` file, so one write per render instead of four
    # keeps that churn (and the temporaries concurrent renderers leave behind)
    # to a minimum.
    #
    # Slots: 1 left, 2 right-aligned on line 1 (2-line prompt only),
    #        3 character line (2-line prompt only), 4 native right prompt,
    #        5 transient left, 6 transient right.
    # @fish-lsp-disable 2003
    if test "$canaudua_prompt_lines" = 2
        set -l character_prompt (__canaudua_character_prompt)
        set -U canaudua_prompt_$canaudua_pid $left_prompt $right_prompt $character_prompt' ' '' \
            $left_transient_prompt' ' $right_transient_prompt
    else
        set -U canaudua_prompt_$canaudua_pid $left_prompt' ' '' '' $right_prompt \
            $left_transient_prompt' ' $right_transient_prompt
    end
end
