function __canaudua_item_python
    type -q python3; or return
    __canaudua_upglob python; or return

    if command -q python3
        python3 --version | string match -qr "(?<python_version>[\d.]+)"
    else
        python --version | string match -qr "(?<python_version>[\d.]+)"
    end
    printf '%s' $canaudua_python_icon' ' $python_version
end
