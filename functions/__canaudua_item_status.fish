function __canaudua_item_status
    if string match -qv 0 $canaudua_last_pipestatus # If there is a failure anywhere in the pipestatus
        if test "$canaudua_last_pipestatus" = 1 # If simple failure
            set -g canaudua_status_bg $canaudua_status_bg_failure
            set_color $canaudua_status_fg_failure
            printf '%s' $canaudua_status_icon_failure' ' 1
        else
            if test $canaudua_last_status = 0
                set -g canaudua_status_bg $canaudua_status_bg_success
                set_color $canaudua_status_fg_success
                printf '%s' $canaudua_status_icon_success' '
            else
                set -g canaudua_status_bg $canaudua_status_bg_failure
                set_color $canaudua_status_fg_failure
                printf '%s' $canaudua_status_icon_failure' '
            end

            fish_status_to_signal $canaudua_last_pipestatus | string replace SIG '' | string join '|'
        end
    else
        set -g canaudua_status_bg $canaudua_status_bg_success
        set_color $canaudua_status_fg_success
        printf '%s' $canaudua_status_icon_success
    end
end
