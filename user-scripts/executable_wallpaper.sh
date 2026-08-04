#!/usr/bin/bash
# 循环更换壁纸
# 被 .xinitrc 调用
while true; do
  # --randomize 随机挑选，--bg-fill 自动铺满
  # 确保目录路径正确（如果是英文系统默认通常是 ~/Downloads，如果是中文系统可能为 ~/下载）
  feh --bg-fill --randomize ~/downloads/wallpaper/*

  # 间隔 150 秒
  sleep 150
done
