function __canaudua_item_distrobox
    test -e /etc/profile.d/distrobox_profile.sh
    and test -e /run/.toolboxenv
    and printf '%s' $canaudua_distrobox_icon' ' (string match -rg 'name="(.*)"' </run/.toolboxenv)
end
