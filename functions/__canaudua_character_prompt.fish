function __canaudua_character_prompt
    if test "$canaudua_last_status" = 0
        set_color $canaudua_character_fg_success
    else
        set_color $canaudua_character_fg_failure
    end
    printf '%s' $canaudua_character_icon
    set_color normal
end
