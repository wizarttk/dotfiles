-- 帮助文档：在命令模式输入 :h bufferline

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      -- 鼠标悬停效果配置
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },

      -- Buffer 选中指示器样式 (下划线风格)
      indicator = {
        style = "underline",
      },

      -- 在标签页上直接显示 LSP 报错与警告数量
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}
