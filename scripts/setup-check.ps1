# EduSpec 依賴檢查（Windows PowerShell 5.1+ 原生版）— 與 setup-check.sh 檢查項一對一。
# 逐項回報就緒/缺少，缺必要項以非零結束（不靜默）。
# 執行（免改系統設定）：powershell -ExecutionPolicy Bypass -File scripts\setup-check.ps1
# 工作坊模式（只列必要項）：powershell -ExecutionPolicy Bypass -File scripts\setup-check.ps1 -Essential
param(
    [switch]$Essential
)

$script:ok = 0
$script:miss = 0
$script:optMissing = 0

function Say-Ok([string]$name) {
    Write-Host "  [OK] $name"
    $script:ok++
}
function Say-Miss([string]$name, [string]$hint) {
    Write-Host "  [X] 缺少 $name — $hint"
    $script:miss++
}
function Say-Opt([string]$name, [string]$hint) {
    if ($Essential) { $script:optMissing++; return }
    Write-Host "  [-] 選用未裝 $name — $hint（缺了只影響對應功能）"
    $script:optMissing++
}
function Has-Cmd([string]$cmd) {
    return [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

Write-Host "== EduSpec 依賴檢查（Windows）=="

Write-Host "[必要]"
if ((Has-Cmd "claude") -or (Has-Cmd "codex")) {
    Say-Ok "終端機 AI（claude 或 codex）"
} else {
    Say-Miss "Claude Code 或 Codex" "見 https://code.claude.com/docs"
}
# VS Code：先找 code 指令，找不到再看預設安裝路徑（安裝時未勾 PATH 的情況）
if (Has-Cmd "code") {
    Say-Ok "VS Code（code）"
} elseif (Test-Path "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe") {
    Say-Ok "VS Code（已安裝於預設路徑；code 指令未加入 PATH，不影響使用）"
} else {
    Say-Miss "VS Code" "https://code.visualstudio.com"
}

function Say-OptOk([string]$name) {
    if ($Essential) { return }   # 工作坊模式：選用項一律摺疊，不逐項列
    Say-Ok $name
}

if (-not $Essential) { Write-Host "[選用]" }
if (Has-Cmd "git") { Say-OptOk "git（課後 GitHub 發布才需要，選用）" } else { Say-Opt "git（課後 GitHub 發布才需要）" "https://git-scm.com（下載 Windows 安裝器）" }
if (Has-Cmd "spectra") { Say-OptOk "Spectra CLI（大型迭代專案的圖形介面，選用）" } else { Say-Opt "Spectra CLI（大型迭代專案的圖形介面）" "見 https://kaochenlong.com/spectra-app-2" }
if (Has-Cmd "pandoc") { Say-OptOk "pandoc（讀 .docx 講義，選用）" } else { Say-Opt "pandoc（讀 .docx 講義）" "winget install --id JohnMacFarlane.Pandoc" }
if (Has-Cmd "ffmpeg") { Say-OptOk "ffmpeg（teach-animation render 動畫，選用）" } else { Say-Opt "ffmpeg（teach-animation render 動畫）" "winget install --id Gyan.FFmpeg" }
if (Has-Cmd "pdftotext") { Say-OptOk "pdftotext（Codex 讀 PDF 講義，選用）" } else { Say-Opt "pdftotext（Codex 讀 PDF 講義；Claude Code 內建可略）" "winget install --id oschwartz10612.Poppler" }
$manimOk = $false
foreach ($py in @("py", "python", "python3")) {
    if (Has-Cmd $py) {
        & $py -c "import manim" 2>$null
        if ($LASTEXITCODE -eq 0) { $manimOk = $true }
        break
    }
}
if ($manimOk) { Say-OptOk "manim（teach-animation 動畫，選用）" } else { Say-Opt "manim（做動畫用）" "pip install manim（見 docs.manim.community）" }
if ($Essential) {
    Write-Host "  （選用工具今天用不到，未逐項檢查列出；需要時跟 AI 說一聲，它會協助安裝）"
}

Write-Host "[skill 可載入]"
if (Test-Path "skills") {
    Say-Ok "skills/ 可見（你在套件根目錄）"
} else {
    Write-Host "  [-] 未在此目錄看到 skills/ — 請在套件根目錄執行本檢查"
}

Write-Host "----"
Write-Host "摘要：$script:ok 項就緒；$script:miss 項必要缺少。"
if ($script:miss -gt 0) {
    Write-Host "請先補齊上面 [X] 的必要項，再開始使用（見 SETUP.md）。"
    exit 1
}
Write-Host "全部必要項就緒 — 可從 GETTING-STARTED.md 開始。"
