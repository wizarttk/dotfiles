-- lua/plugins/smear-cursor.lua
return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  -- 如果是在 GUI 版 Neovide 下启动，则自动禁用本插件，防止双重动画冲突
  cond = function()
    return vim.g.neovide == nil
  end,
  opts = {
    -- -------------------------------------------------------------
    -- 1. 核心手感调控 (打字快，跳转爽)
    -- -------------------------------------------------------------
    -- 关掉相邻行 (j/k) 的残影！这是保持日常打字 0 延迟、手感利落的关键设置
    smear_between_neighbor_lines = false,

    -- 开启跨 Buffer / 跨文件跳转时的残影
    smear_between_buffers = true,

    -- 开启屏幕滚动 (如 <C-d>/<C-u>) 时的残影
    scroll_buffer_space = true,

    -- -------------------------------------------------------------
    -- 2. Alacritty 终端兼容性与渲染修复
    -- -------------------------------------------------------------
    -- 隐藏真正的光标，解决 Alacritty/Kitty 终端下“真实光标与动画虚影”重叠的 Bug
    hide_target_hack = true,

    -- 让残影颜色自动跟随 TokyoNight 当前主题的光标高亮，不硬编码颜色
    -- cursor_color = "#B026FF ",

    -- -------------------------------------------------------------
    -- 3. 果冻质感与物理弹簧参数 (已微调至最佳果冻比)
    -- -------------------------------------------------------------
    -- 光标头部追赶目标的速度 (0~1)，0.6 追赶敏捷不延迟
    stiffness = 0.6,

    -- 光标尾巴的拉伸刚度 (0~1)，0.25 能拉出非常有质感的流线型“果冻尾巴”
    trailing_stiffness = 0.25,

    -- 减小残影体积衰减指数，让拖尾看起来更加饱满
    volume_reduction_exponent = 0.2,

    -- 残影最小停止距离，低于 0.1 字符立刻停止计算，极省 CPU
    distance_stop_animating = 0.1,

    -- 动画最长持续毫秒数，防止大型文件卡顿
    max_time = 100,
  },
  -- 如果开启了 mini.animate，自动禁用其光标模块，防止两个插件抢占光标高亮
  specs = {
    {
      "nvim-mini/mini.animate",
      optional = true,
      opts = {
        cursor = { enable = false },
      },
    },
  },
}
