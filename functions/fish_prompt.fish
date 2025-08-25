status is-interactive; or exit

set -g canaudua_left_prompt_var canaudua_left_prompt_$fish_pid
set -g canaudua_right_prompt_var canaudua_right_prompt_$fish_pid
set -g canaudua_left_transient_prompt_var canaudua_left_transient_prompt_$fish_pid
set -g canaudua_right_transient_prompt_var canaudua_right_transient_prompt_$fish_pid
set -gx canaudua_pid $fish_pid

function fish_prompt
    set -lx canaudua_last_status $status
    set -lx canaudua_last_pipestatus $pipestatus
    set -lx canaudua_duration $CMD_DURATION
    set -lx canaudua_jobs_count (jobs --pid | count)

    if not set -e canaudua_refreshing
        fish -c "__canaudua_setup $fish_bind_mode" </dev/null &
        builtin disown

        command kill $canaudua_last_pid 2>/dev/null
        set -g canaudua_last_pid $last_pid
    end

    if set -q __canaudua_transient
        echo -n \e\[0J
        string unescape $$canaudua_left_transient_prompt_var
    else
        string unescape $$canaudua_left_prompt_var
    end
end

function __canaudua_refresh -v $canaudua_left_prompt_var -v $canaudua_right_prompt_var
    set -g canaudua_refreshing
    commandline -f repaint
end

function __canaudua_exit -e fish_exit
    set -e canaudua_left_prompt_$fish_pid
    set -e canaudua_right_prompt_$fish_pid
end
