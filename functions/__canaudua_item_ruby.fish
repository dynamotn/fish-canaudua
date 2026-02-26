function __canaudua_item_ruby
    type -q ruby; or return
    __canaudua_upglob ruby; or return

    ruby --version | string match -qr "(?<ruby_version>[\d.]+)"
    printf '%s' $canaudua_ruby_icon' ' $ruby_version
end
