# ~/.config/fish/conf.d/10-abbr.fish
# 用 abbr 而非 alias：历史记录里存的是展开后的完整命令，方便回溯

# 编辑器（先检查 nvim 是否存在，避免未装时命令找不到）
if command -q nvim
    abbr -a vim nvim
    abbr -a vi nvim
end

# 现代工具替代（有装才启用对应缩写）
if command -q eza
    # --- 基础列表查看 ---
    abbr -a ls 'eza --icons'
    abbr -a ll 'eza -lah --icons --group-directories-first'

    # --- 目录树视图 (Tree) ---
    abbr -a lt 'eza --tree --icons --level=2' # 目录树（默认只展开 2 层，防止刷屏）
    abbr -a lta 'eza --tree -a --icons --level=2' # 目录树（包含隐藏文件）
    abbr -a lT 'eza --tree --icons' # 目录树（无深度限制，展开全部）
end

if command -q bat
    abbr -a cat bat
end

if command -q zoxide
    abbr -a cd z
end

if command -q fd
    abbr -a find fd
end

if command -q rg
    abbr -a grep rg
end

if command -q btop
    abbr -a top btop
end

if command -q lazygit
    abbr -a lg lazygit
end

if command -q chezmoi
    # 主命令简写
    abbr -a cz chezmoi

    # 核心工作流
    abbr -a cze 'chezmoi edit --apply' # 编辑配置并在保存时立刻生效
    abbr -a cza 'chezmoi apply' # 将源仓库的改动应用到家目录
    abbr -a czd 'chezmoi diff' # 查看差异
    abbr -a czu 'chezmoi update' # 从远程仓库拉取更新并自动 apply
    abbr -a czs 'chezmoi status' # 查看有哪些文件有改动

    # 仓库与文件管理
    abbr -a czc 'chezmoi cd' # 直接进入 chezmoi 的源仓库目录
    abbr -a czr 'chezmoi re-add' # 重新添加/更新家目录中已改动的文件
    abbr -a czaa 'chezmoi add' # 添加新文件到 chezmoi 管理
    abbr -a czf 'chezmoi forget' # 停止管理指定的目标文件
end

# trash-cli
if command -q trash-put
    abbr -a rm trash-put # 简写 rm = 将文件扔到回收站
    abbr -a rl trash-list | sort # 简写 rl = 列出回收站文件（时间排序，最新的在下面）
    abbr -a rr trash-restore # 简写 rr = 恢复回收站文件
    abbr -a rt trash-rm # 简写 rt = 删除回收站特定文件
    abbr -a re trash-empty # 简写 re = 清空回收站
end
