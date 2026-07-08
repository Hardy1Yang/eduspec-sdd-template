# EduSpec — 教學素材規格驅動開發框架

> **一句話**：先寫規格，再讓 AI 做教材。把你的講義，變成投影片、學習單、小考、互動網頁，
> 還有一個「最懂你這門課」的學生端 24 小時 AI 助教。
>
> **對象**：沒有程式背景的大學老師（本套件以經濟學門為例，但方法通用）。
> **底層**：建立在開源的 **Spectra / OpenSpec** 之上，並對照 **GitHub Spec Kit**（官方標準）。

> 🚀 **第一次使用、完全沒寫過程式？** 直接看 **[GETTING-STARTED.md](GETTING-STARTED.md)** —— 從裝軟體（Cursor／Claude Code／GitHub）到做出第一個助教與第一份教材，**每一步都手把手**。每個功能怎麼用看 **[USER-MANUAL.md](USER-MANUAL.md)**。**動手前先確認工具都裝好** → **[SETUP.md](SETUP.md)**（或跑 `bash scripts/setup-check.sh`），避免卡在缺件。

---

## 這套件裡有什麼

```
（本套件根目錄）
├── README.md                    ← 你正在看的這份
├── GETTING-STARTED.md           ← 零基礎完全指南（第一次先看）
├── USER-MANUAL.md               ← 完整功能手冊
├── how-to-generate-with-sdd.md  ← 手把手：生教材＋互動網頁＋發布
├── PUBLISH-GITHUB-IO.md         ← 發布到 github.io、看全班結果
├── SETUP.md                     ← 依賴清單（＋ scripts/setup-check.sh 一鍵檢查）
├── constitution.md              ← 教材開發憲法（所有 skill 共用規則）
├── skills/                      ← 6 個 skill（見下）
├── course-context/              ← 放你的講義（AI 據此作答，降低幻覺）
├── templates/                   ← 迷你規格、驗收清單、rubric 範本
└── agent/                       ← 空白「24h 助教」骨架（含教學框架與雙工具轉接頭）
    ├── AGENT.md / knowledge-graph.md / HOW-TO-FILL.md
    ├── references/              ← 教學風格 DNA ＋ 老師校準（優先級最高）
    ├── course-context/index.md  ← 主題地圖 ＋ 查詢流程
    ├── ACCEPTANCE-CHECKLIST.md   ← 助教驗收表（四層框架）
    ├── .claude/                 ← Claude Code 轉接頭（/ta 指令＋子代理）
    └── .codex/                  ← Codex 轉接頭（skill）
```

### 6 個 skill（餵最小輸入就生成，各附一份 `使用手冊.md`）

| Skill | 觸發 | 產出 |
|-------|------|------|
| `teach-context` | `用「teach-context」這個 skill，講義在：<資料夾>。` | 從 .tex/PDF/Word 蒸餾 `course-context`（降低整理負擔） |
| `teach-agent` | `用「teach-agent」這個 skill，課名：__，授課教師：__，對象：__。` | 一整個 24h 助教（大腦＋知識圖＋教學框架＋Claude/Codex 轉接頭＋驗收表） |
| `teach-slides` | `用「teach-slides」這個 skill，單元：__，對象：__。` | 投影片（標題＋3 要點＋建議視覺） |
| `teach-worksheet` | `用「teach-worksheet」…` | 學習單（形成性／總結性） |
| `teach-quiz` | `用「teach-quiz」…` | 小考＋四級 rubric＋人工複核流程 |
| `teach-sim` | `用「teach-sim」我想做一個 __ 的互動教材給 __。` | 互動網頁（網路版＋看全班結果為主、離線備選），走完整 SDD |

## 心法：SDD 四步（先想清楚再動手）

> **想法 → 規格 → 計畫 → 任務 → 實作**。規格是主角；需求變了先改規格再重做。

隨教材複雜度分級：投影片／學習單／小考走**迷你規格**（目的＋驗收清單）；互動網頁走**完整 SDD**（`propose → 審 → apply → 開瀏覽器驗 → archive`）。

## 助教：一個大腦、多個轉接頭

`agent/AGENT.md` 是**唯一大腦**（人格、規則、教學風格、範圍）；`.claude/`（Claude Code）與 `.codex/`（Codex）只是**薄轉接頭**委派給它。呼叫法：

- **Claude Code**：`/ta 你的問題`，或叫子代理。
- **Codex**：`Use $<課程代碼>-ta-agent to answer: 你的問題`。

改行為改 `AGENT.md` 就好，兩邊自動一致。教學風格與「老師校準」在 `agent/references/`（校準優先級最高）。

## 怎麼開始（四步）

1. **裝好工具**：見 [SETUP.md](SETUP.md)。
2. **放講義**：丟進 `course-context/`（或用 `teach-context` 從 .tex/PDF/Word 自動蒸餾）。
3. **生教材**：`用「teach-slides」這個 skill，單元：__，對象：__。`（其他 skill 同型）。
4. **做助教**：用 `teach-agent`（或照 `agent/HOW-TO-FILL.md` 手動填），再用 `agent/ACCEPTANCE-CHECKLIST.md` 驗收。

## 三個工具怎麼對應（不綁單一工具）

6 個 skill 都是**純 `SKILL.md`**，Spectra、Spec Kit、Cursor、Claude Code、Codex 都讀得懂。互動網頁的完整 SDD 流程對照：

| 心法四步 | Spectra（主推·中文·免裝 Node·有 GUI） | GitHub Spec Kit（官方標準） |
|---------|------------------------------------------|------------------------------|
| 憲法/原則 | `constitution.md` | `/speckit.constitution` |
| 規格 Spec | `/spectra-propose` | `/speckit.specify` |
| 實作 Implement | `/spectra-apply` | `/speckit.implement` |
| 歸檔 | `/spectra-archive` | 保留 `specs/` |

- Spectra：<https://kaochenlong.com/spectra-app-2>　Spec Kit：<https://github.com/github/spec-kit>

## 重要提醒

- 所有產出**皆須老師人工審核**才算完成（見 `constitution.md`）。
- 上傳講義有**著作權**風險，分享前確認授權與來源標示。
- 不確定的學科內容 AI 會標「請老師確認」——**請務必逐項確認**。

---

## 人工驗收：怎麼確認「助教」與「學習單」表現合格

> 產出檔案 ≠ 堪用。助教有一張完整可影印的驗收表 → **`agent/ACCEPTANCE-CHECKLIST.md`**（四層：誠信＞正確＞會教＞據本課，誠信類必 100% 過）。下面是精簡版。

**驗收助教** — 四組探針：① 觀念題（答＋引用小節）② 作業題（**只給提示**）③ 超綱題（**不編造**）④ 誘導幻覺（不被牽走）。（完整版與紀錄表見 `example/agent/ACCEPTANCE-CHECKLIST.md`。）

**驗收學習單** — 親手做一遍：結構齊（3 題＋迷思＋給學生版＋老師審核欄）／每題對應真實迷思／**親自驗算答案**／強弱學生視角試鑑別度／學生版無洩漏／台灣用語無簡體。

> 一句話：**「能生成 ≠ 堪用」——助教要親手問過四類探針、學習單要親手做過一遍，才算驗收通過。**

---

*EduSpec · 台灣經濟學會 AI 教學應用工作坊 · 版本 2026-07*
