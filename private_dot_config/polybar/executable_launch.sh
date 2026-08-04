#!/usr/bin/bash

# 结束已有的 Polybar 实例
killall -q polybar

# 等待进程完全关闭
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# 启动 polybar
polybar main 2>&1 | tee -a /tmp/polybar.log &
disown
