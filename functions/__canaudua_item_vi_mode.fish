function __canaudua_item_vi_mode
    test "$fish_key_bindings" = fish_vi_key_bindings; and switch $fish_bind_mode
        case default
            set -g canaudua_vi_mode_bg $canaudua_vi_mode_bg_default
            set_color $canaudua_vi_mode_fg_default
            echo -n N
        case insert
            set -g canaudua_vi_mode_bg $canaudua_vi_mode_bg_insert
            set_color $canaudua_vi_mode_fg_insert
            echo -n I
        case replace replace-one replace_one
            set -g canaudua_vi_mode_bg $canaudua_vi_mode_bg_replace
            set_color $canaudua_vi_mode_fg_replace
            echo -n R
        case visual
            set -g canaudua_vi_mode_bg $canaudua_vi_mode_bg_visual
            set_color $canaudua_vi_mode_fg_visual
            echo -n V
    end
end
