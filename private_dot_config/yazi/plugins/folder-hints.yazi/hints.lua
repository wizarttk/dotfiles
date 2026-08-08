-- ~/.config/yazi/plugins/folder-hints.yazi/hints.lua

local HOME = os.getenv("HOME")

return {
  -- 1. DWM 窗口管理器目录提示
  [HOME .. "/source/dwm"] = [[
🛠️ DWM 编译与配置指南：
※ 修改配置 + 打补丁
  ○ 任何个人配置修改：改 config.def.h。
  ○ 任何打补丁操作：
      1. 先 patch --dry-run -p1 < xxxx.diff 检查能否干净应用
      2. 确认无误后再 patch -p1 < xxxx.diff。
  ○ 编译：rm -f config.h && sudo make clean install。

※ 去掉补丁
    ○ 撤销补丁前先备份（推荐）：cp config.def.h config.def.h.bak。
    ○ 检查能否干净撤销：patch -R --dry-run -p1 < xxxx.diff。
    ○ 确认无误后正式撤销：patch -R -p1 < xxxx.diff。
    ○ 重新编译安装：rm -f config.h && sudo make clean install。

]],

  -- 2. chezmoi 工作流
  [HOME .. "/.config"] = [[
[💾 chezmoi 点文件同步工作流]

阶段一：首次配置（主电脑上）
  1. 初始化仓库：
    chezmoi init
  2. 把需要托管的配置文件添加给 chezmoi 管理
    chezmoi add ~/.xinitrc                                           czaa
    chezmoi add ~/.config/nvim

阶段二：
  1. 打开并修改文件（建议配合 --apply，保存退出后自动同步到家目录）:
    chezmoi edit --apply ~/.zshrc                                    cze
  2. 检查改动：
    chezmoi diff                                                     czd
  3. 提交修改并推送到远程仓库:
    chezmoi cd                                                       czc
    git add .
    git commit -m "feat: add new zsh aliases"
    git push
    exit

直接更改了配置的原文件（没用 chezmoi edit）：
  1. 查看本地家目录与 Chezmoi 仓库的差异
    chezmoi diff
  2. 将家目录的新改动重新拉回 Chezmoi 源仓库(已追踪的文件)
    chezmoi re-add
  3. 提交并推送

删除了某个已追踪的文件：
  方法一：直接执行 chezmoi forget
    chezmoi forget ~/.bashrc                                         czf
  方法二：进入源码库手动删除
    chezmoi cd
    git rm dot_bashrc
  最后,提交并推送

阶段三：新设备上部署（一键搞定）
  将你的 GitHub 仓库克隆下来并直接应用到新机器
    chezmoi init --apply <你的GitHub用户名>
  如果是私有仓库，需要传入完整 SSH/HTTPS URL：
    chezmoi init --apply git@github.com:<用户名>/dotfiles.git

阶段四：多设备间同步更新
	当你在 A 电脑上更新并推送了配置，需要在 B 电脑上同步时：
   一键完成拉取 (git pull) + 应用 (chezmoi apply)
    chezmoi update                                                   czu

]],


  -- 3. 你可以在这里继续追加其他目录，例如 st、kitty、hyprland 等：
  -- [HOME .. "/.config/st"] = [[ ... ]],
}
