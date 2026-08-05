-- 1. 改变关键词的图标，2. desc描述改为中文
return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  opts = {
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = "📌", color = "info", alt = { "待做" } },
      HACK = { icon = "🔧", color = "warning", desc = { "一个临时性的修复或者变通的方法" } },
      WARN = { icon = "💥", color = "warning", alt = { "WARNING", "XXX", "警告" } },
      PERF = { icon = "⏫", color = "#FFDAB9", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "改进", "优化" } },
      NOTE = { icon = "📝", color = "hint", alt = { "INFO" } },
      TEST = { icon = "🧪", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      NEW = { icon = "✨", color = "#FFFF00" }, -- 新增
    }
  },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "跳转到下一个 TODO 注释" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "跳转到上一个 TODO 注释" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "打开 TODO 面板（Trouble）" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "打开 TODO/FIX/FIXME 面板（Trouble）" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "搜索 TODO 注释" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "搜索 TODO/FIX/FIXME 注释" },
  },
}

-- FIX:
-- TODO:
-- HACK:
-- WARN:
-- PERF:
-- NOTE:
-- TEST:
-- NEW :
