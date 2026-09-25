status is-interactive; or exit

set -g canaudua_prompt_var canaudua_prompt_$fish_pid
set -gx canaudua_pid $fish_pid

function fish_prompt
    set -lx canaudua_last_status $status
    set -lx canaudua_last_pipestatus $pipestatus
    set -lx canaudua_duration $CMD_DURATION
    set -lx canaudua_jobs_count (jobs --pid | count)

    if not set -e __canaudua_refreshing
        fish -c "__canaudua_setup $fish_bind_mode" </dev/null &
        builtin disown

        command kill $canaudua_last_pid 2>/dev/null
        set -g canaudua_last_pid $last_pid
    end

    set -l offset 0
    set -l left_top_frame ''
    set -l left_bottom_frame ''
    set_color $canaudua_prompt_frame_fg -b normal | read -l prompt_frame_fg
    if test "$canaudua_prompt_has_frame" = true
        set left_top_frame $prompt_frame_fg$canaudua_left_top_frame
        set left_bottom_frame $prompt_frame_fg$canaudua_left_bottom_frame
        set offset (string length -V $canaudua_left_top_frame)
    end

    set -l _parts $$canaudua_prompt_var
    if set -q __canaudua_transient; or contains -- --final-rendering $argv
        echo -n \e\[0J
        test -n "$_parts[5]"; and string unescape $_parts[5]
    else if test -n "$_parts[3]"
        # 2-line prompt: [1]=left_line1, [2]=right_line1, [3]=char_line2
        set -l _left (string unescape $_parts[1])
        set -l _right (string unescape $_parts[2])
        set -l _char (string unescape $_parts[3])
        if test -n "$_right"
            set -l _spaces (math max 0, $COLUMNS - (string length -V $_left) - (string length -V $_right) - $offset)
            echo -n $left_top_frame$_left$prompt_frame_fg
            string repeat -Nm$_spaces $canaudua_prompt_center_char
            echo $_right
        else
            echo $_left
        end
        echo -n $left_bottom_frame$_char
    else
        test -n "$_parts[1]"; and string unescape $_parts[1]
    end
end

function __canaudua_refresh -v $canaudua_prompt_var -v COLUMNS
    set -g canaudua_refreshing
    commandline -f repaint
end

function __canaudua_exit -e fish_exit
    set -e canaudua_prompt_$fish_pid
end
