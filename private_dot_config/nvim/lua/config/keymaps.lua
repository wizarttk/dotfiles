--
-- <leader>1 代码大纲
-- <leader>cd 突出显示所在行的错误
--
-- <leader>wm 当前窗口最大化（Zoom Mode）
-- <C-a> 关闭当前buffer，保持窗口
-- 命令 :q，退出当前窗口，如果在只剩一个窗口时使用，则退出vim

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Add any additional keymaps here
--[[
全局映射：(更加底层)
      vim.api.nvim_set_keymap()
      vim.api.nvim_get_keymap()
      vim.api.nvim_del_keymap()
缓冲区映射：(用于特定缓冲区)
      vim.api.nvim_buf_set_keymap()
      vim.api.nvim_buf_get_keymap()
      vim.api.nvim_buf_del_keymap()
推荐使用： (包装好的,可以实现复杂功能,可以使用函数)
      vim.keymap.set()
      vim.keymap.del()

插件的映射在"plugins目录"中设置

<cmd> <cr>在中间输入命令模式的命令
--]]

-- vim.keymap.set({ "n", "v" }, "3294", "zz") -- 将 3249(随便写的) 映射到 zz(居中),防止在neotree中使用<C-d>的时候，触发zz(在neotree中是展开目录)

-- <C-d>
local ctrl_d_cmd = function()
  local cur_line = vim.fn.line(".")     -- 当前光标行号
  local after_line = cur_line + 5       -- 移动后的光标行号
  local bottom_line = vim.fn.line("w$") -- 获取窗口最后一行的行号 （w$ 表示窗口最后一行；为0表示第一行）
  -- local bottom_line = vim.fn.line('w0') + vim.fn.winheight(0) - 1 -- 窗口最后一行光标行号 = 窗口第一行的行号 + 窗口行号高度 -1
  if bottom_line - after_line <= 4 then
    vim.cmd("normal! zz")
  end
  vim.cmd("normal! 4j")
end
local ctrl_u_cmd = [[<cmd>norm 4k<cr>]]

-- function to adjust width
local width_increase = function()
  vim.fn.win_move_separator(vim.fn.winnr(), 5)
end
local width_reduce = function()
  vim.fn.win_move_separator(vim.fn.winnr(), -5)
end

-- change the location of current window
-- echo win_screenpos(0) 使用这个命令查看当前所在窗口的坐标
local ch_win_location = function()
  local screen_pos = vim.fn.win_screenpos(vim.fn.win_getid()) -- 获取当前窗口左上角在屏幕上的坐标
  local screen_pos_row = screen_pos[1]                        -- 行坐标
  local screen_pos_col = screen_pos[2]                        -- 列坐标
  if screen_pos_row == 1 or screen_pos_row == 2 then          -- 行坐标为1或2，表明实在垂直窗口（在屏幕上面)
    if screen_pos_col ~= 1 then                               -- 列坐标不为1，表明不是第一个窗口
      vim.cmd("wincmd J")
    end
  else
    vim.cmd("wincmd L") -- 水平窗口
  end
end

-- mode
local mode_all = { "n", "v", "i" }
local mode_nv = { "n", "v" }
local mode_n = { "n" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_t = { "t" } -- 终端模式

--mappings
local mappings = {
  -- ban native mappings
  { mode_nv, "S",       "<Nop>" },
  { mode_nv, "J",       "<Nop>" },
  { mode_nv, "q",       "<Nop>" },
  { mode_nv, "<C-S-j>", "<Nop>" },
  { mode_nv, "<C-w>>",  "<Nop>" },
  { mode_nv, "<C-w><",  "<Nop>" },
  { mode_nv, "M",       "<Nop>" },
  { mode_n,  "[[",      "<Nop>" },
  { mode_n,  "]]",      "<Nop>" },

  -- mode_all
  {
    mode_all,
    "<C-.>",
    width_increase,
    { desc = "increase window width" },
  },
  { mode_all, "<C-,>",   width_reduce,           { desc = "reduce window width" } },

  -- mode_nv
  { mode_nv,  "0",       "q",                    { desc = "Macro" } },

  { mode_nv,  "<C-f>",   "/",                    { desc = "Flash search" } },
  { mode_nv,  "<C-d>",   ctrl_d_cmd,             { desc = "move down 4 lines" } },
  { mode_nv,  "<C-u>",   ctrl_u_cmd,             { desc = "move up 4 lines" } },

  -- mode_n
  { mode_n,   "<C-S-h>", "<cmd>bprevious<cr>zz", { desc = "Prev Buffer then zz" } },
  { mode_n,   "<C-S-l>", "<cmd>bnext<cr>zz",     { desc = "Next Buffer then zz" } },

  {
    mode_n,
    "<C-a>",
    function()
      Snacks.bufdelete()
    end,
    { desc = "Delete Buffer, don't close windows" },
  },
  { mode_n, "<C-S-a>", "<cmd>bd<cr>",       { desc = "Delete Buffer, then close windows" } },
  { mode_n, "vv",      "<cmd>norm viw<cr>", { desc = "Select the current word" } },
  {
    mode_n,
    "<leader>j",
    "<cmd>Translate --engines=google<cr>",
    { desc = "display the translation in a window" },
  },
  {
    mode_n,
    "M",
    ch_win_location,
    { desc = "change the location of window" },
  }, -- change the window location

  -- FIX: 将toggle outline的映射从<leader>cs -> <leader>1
  { mode_n, "<leader>cs", "<Nop>" },
  { mode_n, "<leader>1",  "<cmd>Outline<cr>",     { desc = "Toggle Outline" } },

  { mode_n, "''",         "<cmd>norm gsd'<cr>",   { desc = "surround del '" } },
  { mode_n, '""',         '<cmd>norm gsd"<cr>',   { desc = 'surround del "' } },
  { mode_n, "``",         "<cmd>norm gsd`<cr>",   { desc = "surround del `" } },
  { mode_n, "((",         "<cmd>norm gsd(<cr>",   { desc = "surround del (" } },
  { mode_n, "))",         "<cmd>norm gsd)<cr>",   { desc = "surround del )" } },
  { mode_n, "[[",         "<cmd>norm gsd[<cr>",   { desc = "surround del [" } },
  { mode_n, "]]",         "<cmd>norm gsd]<cr>",   { desc = "surround del ]" } },
  { mode_n, "{{",         "<cmd>norm gsd{<cr>",   { desc = "surround del {" } },
  { mode_n, "}}",         "<cmd>norm gsd}<cr>",   { desc = "surround del }" } },
  { mode_n, "<<",         "<cmd>norm gsd<<cr>",   { desc = "surround del <" } },
  { mode_n, ">>",         "<cmd>norm gsd><cr>",   { desc = "surround del >" } },

  { mode_n, "<F5>rr",     "<cmd>RunCode<cr>",     { desc = "RunCode" } },
  { mode_n, "<F5>rf",     "<cmd>RunFile<cr>",     { desc = "RunFile" } },
  { mode_n, "<F5>rft",    "<cmd>RunFile tab<cr>", { desc = "RunFile tab" } },
  { mode_n, "<F5>rp",     "<cmd>RunProject<cr>",  { desc = "RunProject" } },
  { mode_n, "<F5>rc",     "<cmd>RunClose<cr>",    { desc = "RunClose" } },
  { mode_n, "<F5>crf",    "<cmd>CRFiletype<cr>",  { desc = "CRFiletype" } },
  { mode_n, "<F5>crp",    "<cmd>CRProjects<cr>",  { desc = "CRProjects" } },

  --  mode_v
  {
    mode_v,
    "p",
    "P",
    { desc = "paste but not replace in visual mode" },
  },

  { mode_v, "'",  "<cmd>norm gsa'<cr>",  { desc = "surround '" } },
  { mode_v, '"',  '<cmd>norm gsa"<cr>',  { desc = 'surround "' } },
  { mode_v, "`",  "<cmd>norm gsa`<cr>",  { desc = "surround `" } },
  { mode_v, "\\", "<cmd>norm gsa\\<cr>", { desc = "surround \\" } },
  { mode_v, "(",  "<cmd>norm gsa)<cr>",  { desc = "surround (" } },
  { mode_v, ")",  "<cmd>norm gsa(<cr>",  { desc = "surround )" } },
  { mode_v, "[",  "<cmd>norm gsa]<cr>",  { desc = "surround [" } },
  { mode_v, "]",  "<cmd>norm gsa[<cr>",  { desc = "surround ]" } },
  { mode_v, "{",  "<cmd>norm gsa}<cr>",  { desc = "surround {" } },
  { mode_v, "}",  "<cmd>norm gsa{<cr>",  { desc = "surround }" } },
  { mode_v, "<",  "<cmd>norm gsa><cr>",  { desc = "surround <" } },
  { mode_v, ">",  "<cmd>norm gsa<<cr>",  { desc = "surround >" } },

  -- mode_i
  {
    mode_i,
    "<C-o>",
    "<Esc>o",
    { desc = "go to the next line and enter insert mode" },
  },
  -- {
  --   mode_i,
  --   "<C-CR>",
  --   "<Esc>o",
  --   { desc = "go to the next line and enter insert mode" },
  -- },
  { mode_i, "<C-S-h>", "<C-w>",                             { desc = "Delete word" } },
  {
    mode_i,
    "<C-j>",
    "<cmd>wincmd j<cr><cmd>stopinsert<cr>",
    { desc = "move to below windows in insert mode" },
  },
  {
    mode_i,
    "<C-k>",
    "<cmd>wincmd k<cr><cmd>stopinsert<cr>",
    { desc = "move to upper windows in insert mode" },
  },

  -- { mode_i,   "<C-S-h>",   "<cmd>bprevious<cr><cmd>stopinsert<cr>", { desc = "Prev Buffer" } },
  { mode_i, "<C-S-l>", "<cmd>bnext<cr><cmd>stopinsert<cr>", { desc = "Next Buffer" } },

  -- mode_""
  {
    "",
    "<S-l>",
    "$",
    { desc = "move to the end of line" },
  },
  {
    "",
    "<S-h>",
    "0",
    { desc = "move to the beginning of line" },
  },

  -- mode_t
  -- { mode_t,   "<C-h>",     "<BS>",                                 { desc = "Backspace" } },
}

for _, value in ipairs(mappings) do
  local mode = value[1]
  local from = value[2]
  local to = value[3]
  local opt = value[4]
  vim.keymap.set(mode, from, to, opt)
end
