function __canaudua_item_host_context
    if set -q SSH_TTY
        set -g canaudua_host_context_bg $canaudua_host_context_bg_ssh
    else if not cat /proc/1/sched 2>&1 | head -n 1 | grep -qE "(init|systemd)"
        set -g canaudua_host_context_bg $canaudua_host_context_bg_container
    else if test $USER = root
        set -g canaudua_host_context_bg $canaudua_host_context_bg_root
    else
        set -g canaudua_host_context_bg $canaudua_host_context_bg_normal
    end

    set -l distro_icon
    switch (uname | string lower)
        case darwin
            set distro_icon $canaudua_host_context_icon_mac
        case freebsd openbsd dragonfly
            set distro_icon $canaudua_host_context_icon_bsd
        case linux
            set -l icon_var canaudua_host_context_icon_(__canaudua_detect_distro)
            set -q $icon_var
            and set distro_icon $$icon_var
            or set distro_icon $canaudua_host_context_icon_linux
        case '*'
            set distro_icon '?'
    end
    printf '%s' $distro_icon' ' $USER'@'$hostname
end

function __canaudua_detect_distro
    if test (uname -o) = Android
        echo -n termux
        return
    end
    string split '=' < /etc/os-release | read -l split_file
    contains --index ID $split_file | read -l key_index || return
    string trim --chars='"' $split_file[(math $key_index + 1)] | string lower | read -l value
    echo -n $value
end
