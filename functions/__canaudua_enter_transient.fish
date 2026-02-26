function __canaudua_enter_transient
    # If the commandline will be executed or is empty, and the pager is not open
    # Pager open usually means selecting, not running
    # Can be untrue, but it's better than the alternative
    if commandline --is-valid || test -z "$(commandline)" && not commandline --paging-mode
        set -g __canaudua_transient
        set -g __canaudua_refreshing
        commandline -f repaint
    end
    commandline -f execute
end
