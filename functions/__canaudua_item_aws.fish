function __canaudua_item_aws
    type -q aws; or return
    if set -q canaudua_show_aws
        set -l profile $AWS_PROFILE
        test -z "$AWS_PROFILE"; and set -l profile default
        set -l region (aws configure get region)
        test -z "$profile"; or printf '%s' $canaudua_aws_icon' ' $profile': '$region
    end
end
