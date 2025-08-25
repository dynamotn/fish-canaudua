function __canaudua_item_duration
    if test $canaudua_duration -gt 2000
        set -l hours (math -s0 "$canaudua_duration/3600000")
        set -l minutes (math -s0 "$canaudua_duration/60000" % 60)
        set -l seconds (math -s0 "$canaudua_duration/1000" % 60)

        printf '%s' $canaudua_duration_icon' '
        test $hours != 0; and printf '%s' $hours'h '
        test $minutes != 0; and printf '%s' $minutes'm '
        test $seconds != 0; and printf '%s' $seconds's'
    end
end
