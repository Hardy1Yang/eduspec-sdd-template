# 安裝與依賴（Setup）— 先裝好，避免中途卡關

> 這份列出套件用到的工具與（可選）外掛/MCP，**每項都寫「為何、怎麼裝、怎麼驗」**。
> 想一次檢查電腦有沒有裝好，跑：`bash scripts/setup-check.sh`。

## 必要

| 依賴 | 為何需要 | 怎麼裝 | 怎麼驗 |
|------|----------|--------|--------|
| **Claude Code 或 Codex** | 跑 skill、助教、`/ta` 指令 | 以官方為準 <https://code.claude.com/docs>（Codex 見 OpenAI 文件） | 終端機打 `claude`（或 `codex`）能啟動 |
| **git** | 下載套件、發布到 GitHub | <https://git-scm.com> | `git --version` |
| **Spectra CLI** | 互動教材走完整 SDD（`teach-sim`）；GUI 版見官網 | <https://kaochenlong.com/spectra-app-2> | `spectra --version` |

## 選用（缺了只影響對應功能，不影響其他）

| 依賴 | 為何需要 | 怎麼裝 | 怎麼驗 |
|------|----------|--------|--------|
| **pandoc** | `teach-context` 讀 **.docx** 講義（.tex/.pdf 不需要） | `brew install pandoc`（Mac）/ `apt install pandoc`（Linux） | `pandoc --version` |
| **PDF 讀取** | `teach-context` 讀 **PDF** 講義 | Claude Code **內建**，無需另裝 | — |
| **MCP 外掛** | 本套件**預設不需第三方 MCP** 即可運作；此欄保留給你日後擴充（如接文獻庫、瀏覽器） | 依各 MCP 官方 | 在 coding agent 設定確認已連上 |

## skill 要能被載入（常見「找不到 skill」原因）

- 本套件的 `skills/` 內是純 `SKILL.md`；在**套件根目錄**開 coding agent 時可被讀到。
- 助教的 `/ta` 指令來自 `agent/.claude/`；請把**助教資料夾**當專案打開（不是上層）。
- 若觸發 skill「沒反應」：多半是**沒在套件根目錄**、或**沒放講義到 `course-context/`**。

## 一鍵檢查

```bash
bash scripts/setup-check.sh
```
它會逐項回報「✓ 就緒 / ✗ 缺少（附安裝指引）/ ○ 選用未裝」，並在必要項缺少時以非零結束——**缺件不會靜默**。

---
*裝好後從 [GETTING-STARTED.md](GETTING-STARTED.md) 開始。*
