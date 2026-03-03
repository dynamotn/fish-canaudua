function __canaudua_semver_compare
    set -l current_str $argv[1]
    set -l target_str $argv[2]

    set -l c_parts (string split -m 1 "-" $current_str)
    set -l t_parts (string split -m 1 "-" $target_str)

    set -l c_nums (string split . $c_parts[1])
    set -l t_nums (string split . $t_parts[1])

    # Compare Major.Minor.Patch
    for i in 1 2 3
        set -l c (if set -q c_nums[$i]; echo $c_nums[$i]; else; echo 0; end)
        set -l t (if set -q t_nums[$i]; echo $t_nums[$i]; else; echo 0; end)

        if test $c -gt $t; return 0; end
        if test $c -lt $t; return 1; end
    end

    if set -q c_parts[2]; and not set -q t_parts[2]
        return 1
    else if not set -q c_parts[2]; and set -q t_parts[2]
        return 0
    else if not set -q c_parts[2]; and not set -q t_parts[2]
        return 0
    end

    set -l weights alpha 1 beta 2 rc 3

    function get_weight -V weights
        for i in 1 3 5
            if string match -q "$weights[$i]*" $argv[1]
                echo $weights[(math $i + 1)]
                return
            end
        end
        echo 0
    end

    set -l cw (get_weight $c_parts[2])
    set -l tw (get_weight $t_parts[2])

    if test $cw -gt $tw; return 0; end
    if test $cw -lt $tw; return 1; end

    return 0
end
