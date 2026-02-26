function __canaudua_item_node
    type -q node; or return
    __canaudua_upglob node; or return

    node --version | string match -qr "v(?<node_version>.*)"
    printf '%s' $canaudua_node_icon' ' $node_version
end
