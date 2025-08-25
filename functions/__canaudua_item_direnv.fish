function __canaudua_item_direnv
    set -q DIRENV_DIR || return
    direnv status | string match -q 'Found RC allowed *'; or return
    printf '%s' $canaudua_direnv_icon
end
