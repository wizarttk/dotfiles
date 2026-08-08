-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    -- 1. 禁用平滑滚动
    scroll    = { enabled = false }, -- 原本是false

    -- 2. 悬浮终端样式
    terminal  = {
      win = {
        border = "rounded",
        position = "float",
      },
    },

    -- 3. Zen (专注模式) 设置
    zen       = {
      show = {
        statusline = false,
        tabline = true,
      },
    },

    styles    = {
      zen = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        backdrop = { transparent = true, blend = 40 },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
      },
    },

    -- 4. 霓虹彩虹缩进线
    indent    = {
      chunk = {
        enabled = true,
        hl = {
          "RainbowIndent1",
          "RainbowIndent2",
          "RainbowIndent3",
          "RainbowIndent4",
          "RainbowIndent5",
          "RainbowIndent6",
          "RainbowIndent7",
        },
      },
    },

    -- 5. 【完全平替 fzf-lua 的 Picker 配置】
    picker    = {
      enabled = true,       -- 这里 开启的话就得把 fzf-lua 关掉
      layout = {
        preset = "default", -- telescope | ivy | dropdown | vscode | sidebar | vertical | default
        cycle = true,
      },
      matcher = {
        fuzzy = true,
        smart_case = true,
        filename_bonus = true,
      },
      sources = {
        files = {
          hidden = true,
          ignored = false,
        },
        grep = {
          hidden = true,
        },
        explorer = {
          hidden = true,
          replace_netrw = true,
        },
      },
      -- 还原 fzf 弹窗内的快捷键映射
      win = {
        input = {
          keys = {
            ["<Esc>"]   = { "close", mode = { "n", "i" } },
            ["<C-j>"]   = { "list_down", mode = { "n", "i" } },           -- 下移
            ["<C-k>"]   = { "list_up", mode = { "n", "i" } },             -- 上移
            ["<C-o>"]   = { "confirm", mode = { "n", "i" } },             -- <c-o> 打开选中的文件
            ["<C-s>"]   = { "edit_vsplit", mode = { "n", "i" } },         -- <c-s> 垂直分屏打开文件
            ["<C-q>"]   = { "qflist", mode = { "n", "i" } },              -- <c-q> 发送到 Quickfix
            ["<C-u>"]   = { "preview_scroll_up", mode = { "n", "i" } },   -- 预览区向上翻页
            ["<C-d>"]   = { "preview_scroll_down", mode = { "n", "i" } }, -- 预览区向下翻页
            ["<Alt-h>"] = { "toggle_hidden", mode = { "n", "i" } },       -- Alt-h: 切换显示隐藏文件
            ["<Alt-i>"] = { "toggle_ignored", mode = { "n", "i" } },      -- Alt-i: 切换显示忽略文件
          },
        },
      },
    },

    -- 6. 实用黑科技模块
    bigfile   = { enabled = true },  -- 大文件保护：打开超大文件时自动关掉高亮/LSP等重功能，防止卡死
    quickfile = { enabled = true },  -- 极速打开：命令行直接 nvim 打开文件时先渲染内容，不等其它插件加载完
    words     = { enabled = true },  -- 自动高亮光标下单词在当前文件里的其它引用，可用 ]] [[ 跳转
    notifier  = { enabled = true },  -- 更好看的通知弹窗，替代默认 vim.notify 的样式
    input     = { enabled = true },  -- 更好看的输入框，替代 vim.ui.input（比如 LSP 重命名弹出的框）
    scratch   = { enabled = true },  -- 随手记的浮动草稿本，按项目持久化保存内容
    gitbrowse = { enabled = true },  -- 把当前文件/选中行在浏览器里打开对应的 git 远程仓库页面
    -- dim       = { enabled = true }, -- 把当前作用域之外的代码调暗，聚焦正在看的代码块
    dashboard = { enabled = true },  -- 开屏欢迎界面（最近文件、快捷入口等）
    explorer  = { enabled = false }, --  改用 neo-tree
  },

  -- 使用 snacks picker 完全还原 fzf-lua.lua 原本的快捷键
  keys = {
    -- 通用与文件查找
    { "<leader>,", function() Snacks.picker.buffers({ sort_lastused = true }) end, desc = "切换缓冲区" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "在根目录中 Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "命令历史" },
    { "<leader><space>", function() Snacks.picker.files() end, desc = "在根目录中查找文件" },

    { "<leader>fb", function() Snacks.picker.buffers({ sort_lastused = true }) end, desc = "缓冲区" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "查找配置文件" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "在根目录中查找文件" },
    { "<leader>fF", function() Snacks.picker.files({ root = false }) end, desc = "在当前目录中查找文件" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "查找 Git 文件" },

    -- 还原你修改过的历史文件快捷键 (<leader>R 与 <leader>r)
    { "<leader>R", function() Snacks.picker.recent() end, desc = "最近文件" },
    { "<leader>r", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "最近文件（当前目录）" },

    -- Git 相关
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "提交记录" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git 状态" },
    { "<leader>gB", function() Snacks.gitbrowse() end, mode = { "n", "v" }, desc = "在浏览器中打开代码" },

    -- 搜索相关 (完全对照原 fzf-lua 配置)
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "寄存器" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "自动命令" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "在当前缓冲区中搜索" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "命令历史" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "命令" },
    { "<leader>sd", function() Snacks.picker.diagnostics({ filter = { buf = 0 } }) end, desc = "文档诊断" },
    { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "工作区诊断" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "在根目录中 Grep" },
    { "<leader>sG", function() Snacks.picker.grep({ root = false }) end, desc = "在当前目录中 Grep" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "帮助页面" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "搜索高亮组" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "跳转列表" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "键位映射" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "位置列表" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man 页面" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "跳转到标记" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "恢复上次搜索" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix 列表" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "搜索当前单词(根目录)" },
    { "<leader>sW", function() Snacks.picker.grep_word({ root = false }) end, desc = "搜索当前单词(当前目录)" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, mode = "v", desc = "搜索选中文本(根目录)" },
    { "<leader>sW", function() Snacks.picker.grep_word({ root = false }) end, mode = "v", desc = "搜索选中文本(当前目录)" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "预览配色方案" },

    -- LSP 符号搜索
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "跳转到符号" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "跳转到工作区符号" },

    -- 其它工具
    { "<leader>.", function() Snacks.scratch() end, desc = "打开草稿本" },
    { "<leader>fe", function() Snacks.picker.explorer() end, desc = "打开文件树 (Explorer)" },
    { "<c-/>", function() Snacks.terminal() end, desc = "切换悬浮终端" },
  },

  -- 初始化彩虹高亮组
  init = function()
    local rainbow_colors = {
      "#ff375f", "#ff763b", "#ffea00", "#39ff14", "#0066ff", "#2dffe6", "#da00ff",
    }
    local set_rainbow = function()
      for i, color in ipairs(rainbow_colors) do
        vim.api.nvim_set_hl(0, "RainbowIndent" .. i, { fg = color })
      end
    end

    set_rainbow()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_rainbow,
    })
  end,
}
