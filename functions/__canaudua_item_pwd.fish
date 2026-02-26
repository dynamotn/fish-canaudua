function __canaudua_item_pwd
    set -l home_replaced (string replace -- $HOME '~' $PWD)
    set -l parts (string split / -- $home_replaced)

    # Truncate intermediate dirs (not first or last) to first 2 characters
    if test (count $parts) -gt 3
        set -l truncated
        for i in (seq 2 (math (count $parts) - 1))
            set -a truncated (string sub -l 2 -- $parts[$i])
        end
        set parts[2..-2] $truncated
    end

    string join / -- $parts
end
