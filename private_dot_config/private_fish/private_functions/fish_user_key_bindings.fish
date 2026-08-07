function fish_user_key_bindings
    fish_vi_key_bindings

    function __yank_to_clipboard --description "把 killring 顶部内容同步进系统剪贴板"
        printf '%s' "$fish_killring[1]" | fish_clipboard_copy
    end

    # 整行 yank
    bind -M default yy kill-whole-line __yank_to_clipboard yank
end
