function fish_right_prompt
    if set -q __canaudua_transient
        set -e __canaudua_transient
        string unescape $$canaudua_right_transient_prompt_var
    else
        string unescape $$canaudua_right_prompt_var
    end
end
