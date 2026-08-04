function ya
    # 如果带了参数，说明是想用 ya 的原生子命令（如 ya pkg add、ya pub 等）
    # 透传给真正的 ya 二进制，不做拦截
    if test (count $argv) -gt 0
        command ya $argv
        return
    end

    # 没有参数：打开 yazi 文件管理器，并支持退出后 cd 到浏览过的目录
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi --cwd-file="$tmp"
    if read -z cwd < "$tmp"
        and [ -n "$cwd" ]
        and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
