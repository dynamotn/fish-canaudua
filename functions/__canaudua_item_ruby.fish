function __canaudua_item_ruby
    type -q ruby; or return
    __canaudua_upglob ruby; or return

    set -l ruby_version (ruby --version | awk '{print $2}')
    printf '%s' $canaudua_ruby_icon' ' $ruby_version
end
