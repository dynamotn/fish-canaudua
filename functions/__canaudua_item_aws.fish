function __canaudua_item_aws
    type -q aws; or return
    if set -q canaudua_show_aws
        set -l profile $AWS_PROFILE
        test -z "$AWS_PROFILE"; and set -l profile default
        aws configure get region | read -l region
        test -z "$profile"; or printf '%s' $canaudua_aws_icon' ' $profile': '$region
    end
end
