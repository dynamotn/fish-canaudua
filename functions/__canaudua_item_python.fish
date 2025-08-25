function __canaudua_item_python
    type -q python3; or return
    __canaudua_upglob python; or return

    set -l python_version (python3 --version | awk '{print $2}')
    printf '%s' $canaudua_python_icon' ' $python_version
end
