# 修改或增加 fish 自带的 vi 模式的按键映射
# default visual insert 三个模式

# 在 Fish 中运行 Fish 自带的检测工具检测按键的名字 
# fish_key_reader

bind -M default H beginning-of-line
bind -M default L end-of-line

bind -M visual H beginning-of-line
bind -M visual L end-of-line

bind -M insert ctrl-H backward-kill-word
