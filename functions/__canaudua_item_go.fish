function __canaudua_item_go
    type -q go; or return
    __canaudua_upglob go; or return

    go version | string match -qr "(?<go_version>[\d.]+)"
    printf '%s' $canaudua_go_icon' ' $go_version
end
