function __canaudua_item_node
    type -q node; or return
    __canaudua_upglob node; or return

    set -l node_version (node --version | awk '{print substr($1,2)}')
    printf '%s' $canaudua_node_icon' ' $node_version
end
