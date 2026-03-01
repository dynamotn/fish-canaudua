function __canaudua_item_zig
    type -q zig; or return
    __canaudua_upglob zig; or return

    zig version | string match -qr "(?<zig_version>[\d.]+(-dev)?)"
    printf '%s' $canaudua_zig_icon' ' $zig_version
end
