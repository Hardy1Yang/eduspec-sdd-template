#!/usr/bin/env bash
# EduSpec 依賴檢查 — 逐項回報就緒/缺少，缺必要項以非零結束（不靜默）。
# 用法：bash scripts/setup-check.sh              # 完整檢查
#       bash scripts/setup-check.sh --essential  # 工作坊模式：只列必要項，選用項摺疊一行
set -u
ok=0; miss=0
ESSENTIAL=0
[ "${1:-}" = "--essential" ] && ESSENTIAL=1

say_ok()   { echo "  ✓ $1"; ok=$((ok+1)); }
say_miss() { echo "  ✗ 缺少 $1 — $2"; miss=$((miss+1)); }
say_opt()  { [ "$ESSENTIAL" -eq 1 ] && return; echo "  ○ 選用未裝 $1 — $2（缺了只影響對應功能）"; }
say_opt_ok(){ [ "$ESSENTIAL" -eq 1 ] && return; say_ok "$1"; }   # 工作坊模式：選用項一律摺疊

check_req() { if command -v "$2" >/dev/null 2>&1; then say_ok "$1（$2）"; else say_miss "$1" "$3"; fi; }
check_opt() { if command -v "$2" >/dev/null 2>&1; then say_opt_ok "$1"; else say_opt "$1" "$3"; fi; }

echo "== EduSpec 依賴檢查 =="

echo "[必要]"
if command -v claude >/dev/null 2>&1 || command -v codex >/dev/null 2>&1; then
  say_ok "終端機 AI（claude 或 codex）"
else
  say_miss "Claude Code 或 Codex" "見 https://code.claude.com/docs"
fi
check_req "git" git "https://git-scm.com"
# VS Code：先找 code 指令，找不到再看 macOS 應用程式資料夾（沒把 code 加入 PATH 的情況）
if command -v code >/dev/null 2>&1; then
  say_ok "VS Code（code）"
elif [ -d "/Applications/Visual Studio Code.app" ] || [ -d "$HOME/Applications/Visual Studio Code.app" ]; then
  say_ok "VS Code（已安裝；code 指令未加入 PATH，不影響使用）"
else
  say_miss "VS Code" "https://code.visualstudio.com"
fi
check_req "Spectra CLI" spectra "見 https://kaochenlong.com/spectra-app-2（互動教材完整 SDD 需要）"

[ "$ESSENTIAL" -eq 0 ] && echo "[選用]"
check_opt "pandoc（讀 .docx 講義，選用）" pandoc "brew install pandoc / apt install pandoc"
check_opt "ffmpeg（teach-animation render 動畫，選用）" ffmpeg "brew install ffmpeg / apt install ffmpeg"
check_opt "pdftotext（Codex 讀 PDF 講義，選用；Claude Code 內建可略）" pdftotext "brew install poppler / apt install poppler-utils"
if python3 -c "import manim" >/dev/null 2>&1; then say_opt_ok "manim（teach-animation 動畫，選用）"; else say_opt "manim（做動畫用）" "pip install manim（見 docs.manim.community）"; fi
[ "$ESSENTIAL" -eq 1 ] && echo "  （選用工具今天用不到，未逐項列出；需要時跟 AI 說一聲，它會協助安裝）"

echo "[skill 可載入]"
if [ -d "skills" ]; then say_ok "skills/ 可見（你在套件根目錄）"; else
  echo "  ○ 未在此目錄看到 skills/ — 請在**套件根目錄**執行本檢查"; fi

echo "----"
echo "摘要：$ok 項就緒；$miss 項必要缺少。"
if [ "$miss" -gt 0 ]; then
  echo "請先補齊上面 ✗ 的必要項，再開始使用（見 SETUP.md）。"
  exit 1
fi
echo "全部必要項就緒 ✓ — 可從 GETTING-STARTED.md 開始。"
