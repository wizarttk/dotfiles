-- lua/plugins/Schemes/tokyonight.lua (或 lua/plugins/tokyonight.lua)
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      terminal_colors = true, -- 在 :terminal 中使用 TokyoNight 色彩
      -- dim_inactive = true,    -- 【美化亮点】非活动窗口稍微变暗，增强分屏时的聚焦感

      -- 语法文本样式微调
      styles = {
        comments = { italic = true },              -- 注释斜体
        keywords = { italic = true, bold = true }, -- 关键字（如 return/if）斜体+加粗
        functions = { bold = true },               -- 函数名加粗
        variables = {},
        sidebars = "dark",                         -- 侧边栏暗色
        floats = "dark",                           -- 浮动窗口暗色
      },

      plugins = {
        snacks = true,
        auto = true, -- 自动适配其他已安装的插件高亮
      },

      -- 覆盖颜色 (GitHub 暗色风格调色盘)
      on_colors = function(c)
        c.bg = "#0d1117"         -- 背景颜色
        c.bg_float = "#0d1117"   -- 浮动窗口颜色
        c.bg_dark = "#0d1117"    -- 黑色背景色
        c.bg_sidebar = "#11171f" -- 侧边栏颜色
        c.comment = "#a3a2a2"    -- 注释颜色
        c.git.add = "#26a641"    -- Git 新增颜色微调
        c.git.change = "#2f81f7" -- Git 修改颜色微调
        c.git.delete = "#f85149" -- Git 删除颜色微调
      end,

      -- 覆盖高亮组
      on_highlights = function(hl, c)
        ---------------------------------------------------------
        -- 1. 基础 UI 与光标行
        ---------------------------------------------------------
        hl.LineNr                   = { fg = c.purple }                              -- 行号颜色
        hl.CursorLineNr             = { fg = c.white, bold = true }                  -- 当前行行号加粗白色
        hl.Visual                   = { bg = "#26334a" }                             -- 【美化】文本选中区高亮（符合 #0d1117 的 GitHub 选中感）
        hl.CurSearch                = { bg = c.orange, fg = c.bg_dark, bold = true } -- 当前搜索匹配项高亮

        ---------------------------------------------------------
        -- 2. 代码补全下拉框 (Pmenu) 卡片美化
        ---------------------------------------------------------
        hl.Pmenu                    = { bg = "#161b22", fg = "#e6edf3" }              -- 悬浮卡片背景 (略亮于主背景 #0d1117)
        hl.PmenuSel                 = { bg = "#1f6feb", fg = "#ffffff", bold = true } -- 选中项：高对比蓝 + 纯白加粗字 (绝对清晰)
        hl.PmenuSbar                = { bg = "#161b22" }                              -- 滚动条槽
        hl.PmenuThumb               = { bg = "#484f58" }                              -- 滚动条滑块 (清晰可见)

        ---------------------------------------------------------
        -- 3. LSP 报错/警告波浪线 (VSCode 风格 undercurl)
        ---------------------------------------------------------
        hl.DiagnosticUnderlineError = { sp = c.error, undercurl = true }
        hl.DiagnosticUnderlineWarn  = { sp = c.warning, undercurl = true }
        hl.DiagnosticUnderlineInfo  = { sp = c.info, undercurl = true }
        hl.DiagnosticUnderlineHint  = { sp = c.hint, undercurl = true }

        ---------------------------------------------------------
        -- 4. Neo-tree / 文件树边框融合
        ---------------------------------------------------------
        hl.NeoTreeNormal            = { bg = c.bg_sidebar }
        hl.NeoTreeNormalNC          = { bg = c.bg_sidebar }
        hl.NeoTreeWinSeparator      = { fg = "#21262d", bg = c.bg } -- 软化侧边栏分割线
      end,
    },
  },

  -- 全局应用该主题
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
