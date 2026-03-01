function __canaudua_item_terraform
    type -q terraform; or return
    if set -q canaudua_show_terraform
        terraform workspace show | read -l workspace

        test -z "$workspace"; or printf $canaudua_terraform_icon' %s' $workspace
    end
end
