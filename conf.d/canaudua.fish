function __canaudua_uninstall -e canaudua_uninstall
    set -n | string replace -fr '(^canaudua.*)' 'set -e $1' | source
    functions -e (functions -a | string match -er '^__canaudua_')
    source (functions --details fish_prompt)
end

function __canaudua_install -e canaudua_install
    __canaudua_binding
    __canaudua_uninstall
end

function __canaudua_binding
    bind ' ' __canaudua_show_on_command
    bind -M insert ' ' __canaudua_show_on_command
    bind \r __canaudua_enter_transient
    bind -M insert \r __canaudua_enter_transient
    bind \n __canaudua_enter_transient
    bind -M insert \n __canaudua_enter_transient
end

__canaudua_binding
