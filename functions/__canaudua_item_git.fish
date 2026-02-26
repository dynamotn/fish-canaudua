function __canaudua_item_git
    set -l current_name

    # Get current information of folder
    if git branch --show-current 2>/dev/null | read -l branch
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        if test "$branch" != master -a "$branch" != main
            set current_name $canaudua_git_icon_branch' '$branch
        else
            set current_name $canaudua_git_icon_branch
        end
    else if test $pipestatus[1] != 0
        return
    else if git tag --points-at HEAD | read -l tag
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        set current_name $canaudua_git_icon_tag$tag
    else
        git rev-parse --git-dir --is-inside-git-dir --short HEAD | read -fL gdir in_gdir commit
        test "$in_gdir" = true; or return
        set current_name $canaudua_git_icon_commit$commit
    end

    # Operation (with step/total for rebase)
    if test -d $gdir/rebase-merge
        if test -f $gdir/rebase-merge/msgnum -a -f $gdir/rebase-merge/end
            read -f step <$gdir/rebase-merge/msgnum
            read -f total_steps <$gdir/rebase-merge/end
        end
        test -f $gdir/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
    else if test -d $gdir/rebase-apply
        if test -f $gdir/rebase-apply/next -a -f $gdir/rebase-apply/last
            read -f step <$gdir/rebase-apply/next
            read -f total_steps <$gdir/rebase-apply/last
        end
        if test -f $gdir/rebase-apply/rebasing
            set -f operation rebase
        else if test -f $gdir/rebase-apply/applying
            set -f operation am
        else
            set -f operation am/rebase
        end
    else if test -f $gdir/MERGE_HEAD
        set -f operation merge
    else if test -f $gdir/CHERRY_PICK_HEAD
        set -f operation cherry-pick
    else if test -f $gdir/REVERT_HEAD
        set -f operation revert
    else if test -f $gdir/BISECT_LOG
        set -f operation bisect
    end

    # Get status of repo and remote repo
    set -l info (git --no-optional-locks status --porcelain 2>/dev/null)
    set -l staged (string match -r '^[AMDR].' $info | count)
    set -l dirty (string match -r '^.[AMDR]' $info | count)
    set -l untracked (string match -r '^\?\?' $info | count)
    set -l conflicted (string match -r '^UU' $info | count)
    set -l stashed (git stash list 2>/dev/null | count)
    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null | read -l -d \t upstream_behind upstream_ahead

    # Set background of item
    if test -n "$operation$conflicted"
        set -g canaudua_git_bg $canaudua_git_bg_dirty
    else if test $dirty -ne 0 2>/dev/null
        set -g canaudua_git_bg $canaudua_git_bg_dirty
    else if test $staged -ne 0 2>/dev/null
        set -g canaudua_git_bg $canaudua_git_bg_staged
    else
        set -g canaudua_git_bg $canaudua_git_bg_clean
    end

    printf '%s' $current_name
    test -n "$operation"; and printf ' %s' $operation
    test -n "$step$total_steps"; and printf ' %s/%s' $step $total_steps
    test $conflicted -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_conflicted $conflicted
    test $staged -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_staged $staged
    test $dirty -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_dirty $dirty
    test $untracked -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_untracked $untracked
    test $stashed -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_stashed $stashed
    test $upstream_behind -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_behind $upstream_behind
    test $upstream_ahead -ne 0 2>/dev/null; and printf ' %s %s' $canaudua_git_icon_ahead $upstream_ahead
end
