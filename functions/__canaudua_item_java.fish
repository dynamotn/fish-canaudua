function __canaudua_item_java
    type -q java; or return
    __canaudua_upglob java; or return

    java -version &| string match -qr "(?<java_version>[\d.]+)"
    printf '%s' $canaudua_java_icon' ' $java_version
end
