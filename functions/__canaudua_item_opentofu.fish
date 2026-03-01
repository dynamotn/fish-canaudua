function __canaudua_item_opentofu
    type -q tofu; or return
    if set -q canaudua_show_opentofu
        tofu workspace show | read -l workspace

        test -z "$workspace"; or printf $canaudua_opentofu_icon' %s' $workspace
    end
end
