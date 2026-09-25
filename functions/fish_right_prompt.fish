function fish_right_prompt
    set -l _parts $$canaudua_prompt_var
    if set -q __canaudua_transient; or contains -- --final-rendering $argv
        set -e __canaudua_transient
        test -n "$_parts[6]"; and string unescape $_parts[6]
    else
        test -n "$_parts[4]"; and string unescape $_parts[4]
    end
end
