-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 使用 set option_name? 命令来查看选项的状态

vim.opt.clipboard = { "unnamed", "unnamedplus" } -- Sync with system clipboard
vim.opt.termguicolors = true                     -- 真彩色
vim.opt.spell = true                             -- 拼写检查
vim.opt.spelllang = { "en_us", "cjk" }           -- 设置拼写检查的语言
vim.opt.spelloptions = "camel"                   -- 设置驼峰检查
vim.g.snacks_animate = true                      -- 所有动画（开启/禁用）
vim.opt.background = "dark"                      -- 强制背景为 dark
vim.opt.scrolloff = 8                            -- 在上下滚动代码时，光标距离顶部和底部始终保留 8 行视界缓冲，不会紧贴屏幕边缘。



-- vim.opt.list =false  -- 显示不可见字符（空格、制表符...）
