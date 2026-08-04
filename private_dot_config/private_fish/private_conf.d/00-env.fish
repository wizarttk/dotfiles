# ~/.config/fish/conf.d/00-env.fish
# 环境变量必须最先加载，因为后面的 abbr/tools 可能依赖这里的 PATH

set -g fish_key_bindings fish_vi_key_bindings # 启用 vi 模式

set -gx EDITOR nvim # 设置终端默认文本编辑器为 Neovim 

set -gx VISUAL nvim # 设置全屏/高级交互的默认编辑器为 Neovim (优先于 EDITOR 变量)

set -g fish_greeting # 禁用欢迎语

# 优化历史记录配置
set -g fish_history_size 10000 # 合理设置历史记录大小
set -g fish_history_merge all # 优化合并策略
