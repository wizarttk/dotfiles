# ~/.config/fish/conf.d/20-tools.fish
# 工具初始化放最后，确保前面的环境变量、abbr 都已就绪

starship init fish | source
zoxide init fish | source
