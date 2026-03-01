function __canaudua_item_dotnet
    type -q dotnet; or return
    __canaudua_upglob dotnet; or return

    dotnet --version 2>/dev/null | string match -qr "(?<dotnet_version>[\d.]+)"
    printf '%s' $canaudua_dotnet_icon' ' $dotnet_version
end
