function __canaudua_item_docker_context
    type -q docker; or return
    if set -q canaudua_show_docker_context
        docker context inspect --format '{{.Name}}' | read -l context

        test -z "$context"; or printf $canaudua_docker_icon' %s' $context
    end
end
