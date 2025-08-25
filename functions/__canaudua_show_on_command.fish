function __canaudua_show_on_command
    commandline -f expand-abbr
    if test (count (commandline -poc)) -eq 0
        set -l cmd (commandline -t)

        # Check to see if this is an abbr that will be expanded
        if abbr -q $cmd
            set -l var _fish_abbr_$cmd
            set cmd $$var
        end

        set -l cmd (__canaudua_get_origin_command $cmd)

        __canaudua_check_show_on_command kube_context $cmd
        __canaudua_check_show_on_command gcloud $cmd
        __canaudua_check_show_on_command aws $cmd
    end
    commandline -i " "
end

function __canaudua_get_origin_command -a cmd
    test (type -t $cmd 2>/dev/null) != function 2>/dev/null; and echo $cmd; and return
    set -l wrapped_command (string replace -r '.*--wraps ' '' (complete -c $cmd | grep wraps) | string unescape | string split ' ')[1]

    test -z $wrapped_command; and echo $cmd; and return
    echo (__canaudua_get_origin_command $wrapped_command)
end

function __canaudua_check_show_on_command -a item cmd
    set -l bg_var canaudua_"$item"_bg
    set -l show_on_command_var canaudua_"$item"_show_on_command
    test -n $$bg_var; or return

    if string match -qr $$show_on_command_var -- $cmd
        set -gx canaudua_show_$item
        commandline -f repaint
    else
        set -e canaudua_show_$item
        commandline -f repaint
    end
end
