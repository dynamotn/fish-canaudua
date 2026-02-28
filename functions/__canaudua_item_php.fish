function __canaudua_item_php
    type -q php; or return
    __canaudua_upglob php; or return

    php --version | string match -qr "(?<php_version>[\d.]+)"
    printf '%s' $canaudua_php_icon' ' $php_version
end
