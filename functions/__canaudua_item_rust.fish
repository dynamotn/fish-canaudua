function __canaudua_item_rust
    type -q rustc; or return
    __canaudua_upglob rust; or return

    rustup show active-toolchain | string match -qr "(?<rust_version>^[\d.]+)"
    printf '%s' $canaudua_rust_icon' ' $rust_version
end
