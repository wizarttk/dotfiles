status is-interactive; or exit

function __fcitx5_leave_insert --on-variable fish_bind_mode
    if test "$fish_bind_mode" != insert
        and test "$__fish_prev_bind_mode" = insert
        and type -q fcitx5-remote
        set -l input_status (fcitx5-remote)
        test "$input_status" = 2; and fcitx5-remote -c
    end
    set -g __fish_prev_bind_mode $fish_bind_mode
end
