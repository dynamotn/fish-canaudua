function __canaudua_upglob -a pattern_type
    set -l path .

    while test (realpath $path) != / -a (realpath $path) != (realpath $HOME/..)
        __canaudua_glob $pattern_type $path; and return 0
        set path $path/..
    end
    return 1
end

function __canaudua_glob -a pattern_type directory
    if test (uname -o) = 'Darwin'
        stat -f '%m' $directory | read -l mtime
    else
        stat -c '%Y' $directory | read -l mtime
    end
    set -l folder (realpath $directory | string escape --style=var)
    set -l cache_var canaudua_glob_{$folder}_{$pattern_type}
    set -l pattern_var canaudua_{$pattern_type}_glob

    # Search in cache before
    test "$cache_var" = 0; and return 1
    test "$cache_var" = "$mtime"; and return 0

    # Find with pattern
    test -z "$(find (realpath $directory) \
      -maxdepth 1 \
      -regextype posix-extended \
      -iregex "$$pattern_var" \
      -type f \
      -print -quit 2>/dev/null
    # @fish-lsp-disable-next-line 3003
    )"; and set -g $cache_var 0; and return 1

    # Set cache for glob search
    # @fish-lsp-disable-next-line 3003
    set -g $cache_var $mtime

    return 0
end
