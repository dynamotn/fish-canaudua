function __canaudua_item_rust
    type -q rustc; or return
    __canaudua_upglob rust; or return

    set -l rust_version (rustup show active-toolchain | string match -qr "(?<v>^[\d.]+)")
    printf '%s' $canaudua_rust_icon' ' $rust_version
end
