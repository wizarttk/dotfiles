-- 1. 改变关键词的图标，2. desc描述改为中文
-- lua/plugins/todo-comments.lua
return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  opts = {

    keywords = {
      FIX  = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = "📌", color = "info", alt = { "待做" } },
      HACK = { icon = "🔧", color = "warning", alt = { "变通" } },
      WARN = { icon = "💥", color = "warning", alt = { "WARNING", "XXX", "警告" } },
      PERF = { icon = "⏫", color = "#FFDAB9", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "改进", "优化" } },
      NOTE = { icon = "📝", color = "hint", alt = { "INFO" } },
      TEST = { icon = "🧪", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      NEW  = { icon = "✨", color = "#FFFF00", alt = { "新增" } },
    },
  },

  keys = {
    -- 1. 上下跳转
    { "]t", function() require("todo-comments").jump_next() end, desc = "跳转到下一个 TODO 注释" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "跳转到上一个 TODO 注释" },

    -- 2. 结合 Trouble 面板
    { "<leader>xt", function() require("trouble").toggle({ mode = "todo" }) end, desc = "打开 TODO 面板 (Trouble)" },
    {
      "<leader>xT",
      function()
        require("trouble").toggle({ mode = "todo", filter = { tag = { "TODO", "FIX", "FIXME" } } })
      end,
      desc = "打开 TODO/FIX/FIXME 面板 (Trouble)",
    },

    -- 3. 结合 Snacks Picker 搜索 (【修正】：使用了正确的 todo_comments() 函数名)
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "搜索 TODO 注释",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "搜索 TODO/FIX/FIXME 注释",
    },
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
