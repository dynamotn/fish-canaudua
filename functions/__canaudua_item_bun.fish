function __canaudua_item_bun
    type -q bun; or return
    __canaudua_upglob bun; or return

    set -l bun_version (bun --version)
    printf '%s' $canaudua_bun_icon' ' $bun_version
end
