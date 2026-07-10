#!/usr/bin/env bash
# w2 動畫一鍵 render：殘差如何縮小——直線轉向 OLS
# 用法：./render.sh          （預覽畫質 -ql）
#       ./render.sh -qm      （中畫質）
#       ./render.sh -qh      （高畫質）
set -euo pipefail
cd "$(dirname "$0")"

QUALITY="${1:--ql}"

# 確認依賴已安裝（見套件 SETUP.md）
if ! python3 -c "import manim" >/dev/null 2>&1; then
  echo "錯誤：找不到 manim。請先安裝：pip3 install manim（見 SETUP.md）" >&2
  exit 1
fi
if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "錯誤：找不到 ffmpeg。請先安裝：brew install ffmpeg（見 SETUP.md）" >&2
  exit 1
fi

python3 -m manim "$QUALITY" ols_residuals.py OLSResiduals

# 加 +faststart（適合網頁串流）並抽一張封面
OUT=$(find media/videos -name "OLSResiduals.mp4" | head -1)
if [ -n "$OUT" ]; then
  ffmpeg -y -i "$OUT" -c copy -movflags +faststart ols_residuals.mp4
  ffmpeg -y -i ols_residuals.mp4 -ss 00:00:18 -frames:v 1 ols_residuals_cover.png
  echo "完成：$(pwd)/ols_residuals.mp4（封面 ols_residuals_cover.png）"
else
  echo "錯誤：找不到 render 產出的 mp4。" >&2
  exit 1
fi
