function __canaudua_item_kube_context
    type -q kubectl; or return
    if set -q canaudua_show_kube_context
        set -l context (kubectl config current-context 2>/dev/null)
        if string match -qr 'gke_(?<project>.*)_(?<zone>.*)_(?<cluster>.*)' -- $context
            # GKE cluster
            set context $cluster
        else if string match -qr 'arn:aws:eks:(?<zone>.*):\d+:(?<cluster>.*)' -- $context
            # EKS cluster
            set context $cluster
        else if string match -qr 'do-(?<zone>.*)-(?<cluster>.*)' -- $context
            # DOKS cluster
            set context $cluster
        end

        set -l namespace (kubectl config view --minify --output 'jsonpath={..namespace}')
        test -z $namespace; and set -l namespace default

        test -z $context; or printf $canaudua_kube_icon' %s' $context' ('$namespace')'
    end
end
