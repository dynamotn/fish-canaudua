function __canaudua_item_rust
    type -q rustc; or return
    __canaudua_upglob rust; or return

    set -l rust_version (rustc --version | awk '{print $2}')
    printf '%s' $canaudua_rust_icon' ' $rust_version
end
