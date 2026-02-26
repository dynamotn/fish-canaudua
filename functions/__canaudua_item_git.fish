function __canaudua_item_git
    set -l current_name

    # Get current information of folder
    if git branch --show-current 2>/dev/null | read -l branch
        if test "$branch" != master -a "$branch" != main
            set current_name $canaudua_git_icon_branch' '$branch
        else
            set current_name $canaudua_git_icon_branch
        end
    else if test $pipestatus[1] != 0
        return
    else if git describe --tags --exact-match 2>/dev/null | read -l tag
        set current_name $canaudua_git_icon_tag$tag
    else
        git rev-parse -q --short=7 --is-inside-work-tree HEAD | read -lL is_work_tree commit
        test "$is_work_tree" = true; or return
        set current_name $canaudua_git_icon_commit$commit
    end

    # Operation
    if test -d .git/rebase-merge
        test -f .git/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
    else if test -d .git/rebase-apply
        if test -f .git/rebase-apply/rebasing
            set -f operation rebase
        else if test -f .git/rebase-apply/applying
            set -f operation am
        else
            set -f operation am/rebase
        end
    else if test -f .git/MERGE_HEAD
        set -f operation merge
    else if test -f .git/CHERRY_PICK_HEAD
        set -f operation cherry-pick
    else if test -f .git/REVERT_HEAD
        set -f operation revert
    else if test -f .git/BISECT_LOG
        set -f operation bisect
    end

    # Get status of repo and remote repo
    git --no-optional-locks status --porcelain | read -l info
    string match -r '^[AMDR].' $info | count | read -l staged
    string match -r '^.[AMDR]' $info | count | read -l dirty
    string match -r '^\?\?' $info | count | read -l untracked
    string match -r '^UU' $info | count | read -l conflicted
    git stash list | count | read -l stashed
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null | read -l -d \t upstream_behind upstream_ahead

    # Set background of item
    if test $dirty -ne 0 2>/dev/null
        set -g canaudua_git_bg $canaudua_git_bg_dirty
    else if test $staged -ne 0 2>/dev/null
        set -g canaudua_git_bg $canaudua_git_bg_staged
    else
        set -g canaudua_git_bg $canaudua_git_bg_clean
    end

    printf '%s' $current_name
    test $conflicted -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_conflicted $conflicted
    test $staged -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_staged $staged
    test $dirty -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_dirty $dirty
    test $untracked -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_untracked $untracked
    test $stashed -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_stashed $stashed
    test $upstream_behind -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_behind $upstream_behind
    test $upstream_ahead -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_ahead $upstream_ahead
    test -n "$operation"; and printf ' %s' $operation
end
