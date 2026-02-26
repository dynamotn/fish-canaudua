function __canaudua_item_duration
    set -l threshold (test -n "$canaudua_duration_threshold" && echo $canaudua_duration_threshold || echo 2000)
    set -l decimals (test -n "$canaudua_duration_decimals" && echo $canaudua_duration_decimals || echo 0)
    if test $canaudua_duration -gt $threshold
        set -l hours (math -s0 "$canaudua_duration/3600000")
        set -l minutes (math -s0 "$canaudua_duration/60000" % 60)
        set -l seconds (math -s$decimals "$canaudua_duration/1000" % 60)

        printf '%s' $canaudua_duration_icon' '
        test $hours != 0; and printf '%s' $hours'h '
        test $minutes != 0; and printf '%s' $minutes'm '
        printf '%s' $seconds's'
    end
end
