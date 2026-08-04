-- ~/.config/yazi/plugins/folder-hints.yazi/main.lua

local M = {}

function M:setup(opts)
  opts = opts or {}
  local timeout = opts.timeout or 999

  -- 尝试自动加载同目录下的 hints.lua
  local default_hints = {}
  local ok, loaded_hints = pcall(require, "folder-hints.hints")
  if ok and type(loaded_hints) == "table" then
    default_hints = loaded_hints
  end

  -- 优先使用外部传入的 hints，未传入则使用 hints.lua 的配置
  local hints = opts.hints or default_hints

  -- 监听 cd 事件
  ps.sub("cd", function()
    if not cx.active or not cx.active.current or not cx.active.current.cwd then
      return
    end

    local cwd = tostring(cx.active.current.cwd)
    local hint_text = hints[cwd]

    -- 未在字典匹配到时，查找当前目录下的 .hint 或 HINT.md
    if not hint_text then
      local hint_file = cwd .. "/.hint"
      local f = io.open(hint_file, "r")
      if not f then
        hint_file = cwd .. "/HINT.md"
        f = io.open(hint_file, "r")
      end

      if f then
        hint_text = f:read("*a")
        f:close()
      end
    end

    -- 弹出提示，持续 15 秒
    if hint_text and #hint_text > 0 then
      ya.notify({
        title = "💡 目录操作指南",
        content = hint_text,
        timeout = timeout,
        level = "info",
      })
    end
  end)
end

return M
