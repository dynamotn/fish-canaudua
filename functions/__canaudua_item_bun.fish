function __canaudua_item_bun
    type -q bun; or return
    __canaudua_upglob bun; or return

    bun --version | read -l bun_version
    printf '%s' $canaudua_bun_icon' ' $bun_version
end
