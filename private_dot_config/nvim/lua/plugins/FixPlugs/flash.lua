--[[
参考：https://www.reddit.com/r/neovim/comments/15ptmcq/change_the_mapping_of_s_in_flashnvim_in_it_to/
      https://github.com/folke/flash.nvim
      使用 :h flash 打开help文档
--]]

-- 配置文件思路： 使用<leader>l 1. 找到要配置的插件 -- 回车，cd到第一条目录中，打开lua目录的主配置文件(一般是config.lua  2. 根据主模块(M)的结构，可以改写opts

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      -- 开启 / 搜索时自动显示 Flash 匹配标签
      search = {
        enabled = true,
      },
      -- 禁用 Flash 增强原生的 f/F/t/T 行内跳转 (因为 f 已经改为了全屏跳转)
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    -- 1. 将 f 改为全屏 2D 瞬移跳转
    -- { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash 全局跳转" },

    -- 2. 将 s 改为 Treesitter 智能语法块选择
    { "s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter 块选择" },

    -- 3. 禁用 LazyVim 原生的 S 键 (防止与你的 s 键功能重复)
    { "S", false },

    ----------------------------------------------------------------------------------
    -- 4. Remote 远程操作（光标原地不动，直接对远处的文本执行操作）
    -- mode = "o" 代表操作符挂起模式（即先按下 y / d / c 等操作符后触发）：
    --   • yr + 标签字母 ➔ 复制远处的代码/单词（光标完全不动）
    --   • dr + 标签字母 ➔ 删除远处的代码/单词（光标完全不动）
    --   • cr + 标签字母 ➔ 修改远处的代码/单词（删除远处内容并进入插入模式，光标不动）
    ----------------------------------------------------------------------------------
    { "r", mode = "o", function() require("flash").remote() end, desc = "Flash Remote 远程操作" },
  },
}
