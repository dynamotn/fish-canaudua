function __canaudua_item_azure
    type -q az; or return
    if set -q canaudua_show_azure
        set -l subscription (az account show --query name -o tsv 2>/dev/null)
        test -z "$subscription"; or printf '%s' $canaudua_azure_icon' '$subscription
    end
end
