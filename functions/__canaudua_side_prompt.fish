function __canaudua_side_prompt -a side
    set -l list_items_var canaudua_"$side"_items
    set -l prev_item start

    # Loop over all items of side prompt
    for item in $$list_items_var
        # Check output of item
        set -l output (__canaudua_item_$item)
        test -z "$output"; and continue

        # Get background color of item
        set -l bg_color_var canaudua_"$item"_bg
        set -l bg_color $$bg_color_var

        if test "$prev_item" = start
            # Print head of prompt if is right prompt
            if string match -q "right*" "$side"
                set_color $bg_color -b normal
                printf '%s' $canaudua_right_separator_diff
            end
        else
            if test "$bg_color" = "$prev_bg_color"
                # Print separator with previous color if previous item and current item has same background
                set -l separator_var canaudua_"$side"_separator_same
                printf '%s' $$separator_var
            else
                if string match -q "right*" "$side"
                    set_color $bg_color -b $prev_bg_color
                else
                    set_color $prev_bg_color -b $bg_color
                end
                set -l separator_var canaudua_"$side"_separator_diff
                printf '%s' $$separator_var
            end
        end

        # Print content of item
        set -l fg_color_var canaudua_"$item"_fg
        set -l fg_color $$fg_color_var
        set_color $fg_color -b $bg_color
        printf '%s' " $output "
        # Save info of current item to next item
        set prev_bg_color $bg_color
        set prev_item $item
    end

    # Print head of prompt if is left prompt
    if string match -q "left*" "$side"
        set_color $prev_bg_color -b normal
        printf '%s' $canaudua_left_separator_diff
    end

    # Reset color after print prompt
    set_color normal
end
