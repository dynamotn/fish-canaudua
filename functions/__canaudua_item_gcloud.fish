function __canaudua_item_gcloud
    type -q gcloud; or return
    if set -q canaudua_show_gcloud
        set -q CLOUDSDK_CONFIG || set -l CLOUDSDK_CONFIG ~/.config/gcloud
        path is $CLOUDSDK_CONFIG/active_config
        and read -l config <$CLOUDSDK_CONFIG/active_config
        and path is $CLOUDSDK_CONFIG/configurations/config_$config
        and string match -qr '^\s*project\s*=\s*(?<project>.*)' <$CLOUDSDK_CONFIG/configurations/config_$config
        and string match -qr '^\s*account\s*=\s*(?<account>.*)' <$CLOUDSDK_CONFIG/configurations/config_$config
        and printf '%s' $canaudua_gcloud_icon' ' $account': '$project
    end
end
