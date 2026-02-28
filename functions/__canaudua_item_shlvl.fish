function __canaudua_item_shlvl
    set -l threshold 1
    if test -n "$ZELLIJ"; or test -n "$TMUX"
        set threshold 2
    end
    test $SHLVL -gt $threshold; and printf '%s' $canaudua_shlvl_icon' ' (math $SHLVL - $threshold)
end
