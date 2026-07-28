# 安裝與依賴（Setup）— 先裝好，避免中途卡關

> 這份列出套件用到的工具與（可選）外掛/MCP，**每項都寫「為何、怎麼裝、怎麼驗」**。
> 想一次檢查電腦有沒有裝好？見下方「一鍵檢查（Mac／Windows）」——Mac 跑 `bash scripts/setup-check.sh`，Windows 有對應的 `setup-check.ps1`。

> ⚠️ **關於 AI 用量（先有心理準備）**：蒸餾教材（`teach-context`／`teach-agent`）會**平行開多個 sub-agent**、生成教材也會用 AI，**都會消耗你 Claude／Codex 的用量**。**第一次先從前三週的素材開始**，別一次倒整包課程；**免費／低額度方案可能中途把 session 額度用完、跑不完**——遇到就分批做。這不是裝哪個工具能解決的，而是使用節奏問題。

## 必要

| 依賴 | 為何需要 | 怎麼裝 | 怎麼驗 |
|------|----------|--------|--------|
| **Claude Code 或 Codex** | 跑 skill、助教、`/ta` 指令 | 以官方為準 <https://code.claude.com/docs>（Codex 見 OpenAI 文件） | 終端機打 `claude`（或 `codex`）能啟動 |
| **git** | 下載套件、發布到 GitHub（選 zip 分享可不用） | <https://git-scm.com> | `git --version` |
| **Spectra CLI** | 互動教材走完整 SDD（`teach-sim`）；GUI 版見官網 | <https://kaochenlong.com/spectra-app-2>；⚠️ **首次啟動會做初始設置（含向量模型下載），需數分鐘——建議課前完成** | `spectra --version` |

> **模型選哪個？** 教學與初次生成用 **light 或 medium** 就夠：high 更耗額度、對這類文件生成感受差異不大；額度有限時尤其別開 high。模型在 AI 對話框的模型選單切換。

## 選用（缺了只影響對應功能，不影響其他）

| 依賴 | 為何需要 | 怎麼裝 | 怎麼驗 |
|------|----------|--------|--------|
| **pandoc** | `teach-context` 讀 **.docx** 講義（.tex/.pdf 不需要） | `brew install pandoc`（Mac）/ `apt install pandoc`（Linux） | `pandoc --version` |
| **manim** | `teach-animation` 做**動畫影片**（互動網頁不需要） | `pip install manim`（見 <https://docs.manim.community>） | `python3 -c "import manim"` |
| **ffmpeg** | `teach-animation` render 動畫成 mp4（配 manim） | `brew install ffmpeg`（Mac）/ `apt install ffmpeg`（Linux） | `ffmpeg -version` |
| **PDF 讀取** | `teach-context` 讀 **PDF** 講義 | Claude Code **內建**；**Codex 使用者**建議裝 poppler（`brew install poppler`，提供 `pdftotext`） | `pdftotext -v` |
| **MCP 外掛** | 本套件**預設不需第三方 MCP** 即可運作；此欄保留給你日後擴充（如接文獻庫、瀏覽器） | 依各 MCP 官方 | 在 coding agent 設定確認已連上 |

## skill 要能被載入（常見「找不到 skill」原因）

- 本套件的 `skills/` 內是純 `SKILL.md`；在**套件根目錄**開 coding agent 時可被讀到。
- 助教的 `/ta` 指令來自 `agent/.claude/`；請把**助教資料夾**當專案打開（不是上層）。
- 若觸發 skill「沒反應」：多半是**沒在套件根目錄**、或**沒放講義到 `course-context/`**。

## 一鍵檢查（Mac／Windows）

**Mac／Linux**：
```bash
bash scripts/setup-check.sh
```

**Windows**（免改系統設定的執行法）：
```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-check.ps1
```

它會逐項回報「✓ 就緒 / ✗ 缺少（附安裝指引）/ ○ 選用未裝」，並在必要項缺少時以非零結束——**缺件不會靜默**。
工作坊當天只想看必要項：Mac 加 `--essential`、Windows 加 `-Essential`（選用項摺疊成一行，不會滿版問號）。

---
*裝好後從 [GETTING-STARTED.md](GETTING-STARTED.md) 開始。*
