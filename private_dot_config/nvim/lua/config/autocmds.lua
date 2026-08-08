-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- VIM命令的文档：https://yianwillis.github.io/vimcdoc/doc/autocmd.html#BufNew

--------------------------------------------------------------------------------------------------------------------------
-- 1. Fcitx5 退出插入模式自动关输入法 (切回英文)
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    local input_status = tonumber(vim.fn.system("fcitx5-remote"))
    if input_status == 2 then
      vim.fn.system("fcitx5-remote -c")
    end
  end,
})

-- 2. 进入注释区自动开启中文输入法 (增加空值保护与健壮性)
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = { "*" },
  callback = function()
    local commentstring = vim.bo.commentstring
    if not commentstring or commentstring == "" then return end

    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]

    -- 去除 %s 并剪裁两端空格
    local symbol = commentstring:gsub("%%s", ""):gsub("^%s*", ""):gsub("%s*$", "")
    if symbol == "" then return end

    local comment_pos = line:find(symbol, 1, true)
    if comment_pos and col >= comment_pos then
      vim.fn.system("fcitx5-remote -o")
    end
  end,
})

-- 3. 新建 Shell 脚本时自动插入可移植性更高的 Shebang
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  pattern = { "*.sh" },
  callback = function()
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/env bash", "" })
  end,
})

require("config.abbrev")
