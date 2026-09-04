function __canaudua_upglob -a pattern_type
    set -l path .

    while test (realpath $path) != / -a (realpath $path) != (realpath $HOME/..)
        __canaudua_glob $pattern_type $path; and return 0
        set path $path/..
    end
    return 1
end

function __canaudua_glob -a pattern_type directory
    set -l pattern_var canaudua_{$pattern_type}_glob

    # Check the directory for a matching file on every call instead of caching
    # results in universal variables: a universal variable would be created
    # per directory/pattern pair, never removed, and grow ~/.config/fish/fish_variables
    # without bound.
    # @fish-lsp-disable 2003 3003
    test -n "$(
    find (realpath $directory) \
      -maxdepth 1 \
      -regextype posix-extended \
      -iregex $$pattern_var \
      -type f \
      -print -quit 2>/dev/null
    )"
end
