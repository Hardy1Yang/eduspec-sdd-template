# EduSpec — 教學素材規格驅動開發框架

> **一句話**：先寫規格，再讓 AI 做教材。把你的講義，變成投影片、學習單、小考、互動網頁，
> 還有一個「最懂你這門課」的學生端 24 小時 AI 助教。
>
> **對象**：沒有程式背景的大學老師（本套件以經濟學門為例，但方法通用）。
> **底層**：建立在開源的 **Spectra / OpenSpec** 之上，並對照 **GitHub Spec Kit**（官方標準）。

## 快速開始（三步）

1. **下載本套件**：`git clone <本套件 repo 網址>`（或 Download ZIP 解壓）。
2. **準備一個原始教材資料夾**：課綱、講義、作業、考古題放進同一個資料夾即可（.tex/PDF/DOCX/MD 格式不拘）。
3. **用 Claude Code 或 Codex 打開本套件，貼**：`用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。` → 產出 `<課程代碼>-ta/`（已 git init），即為可發布的學生 repo；驗收用其中的 `ACCEPTANCE-CHECKLIST.md`（骨架 `agent/` 附）。

## 📚 文件地圖（先知道要翻哪本）

| 你的情況 | 看這本 |
|----------|--------|
| **工作坊當天、要抄指令** | **[WORKSHOP-COMMANDS.md](WORKSHOP-COMMANDS.md)**（課堂指令表：複製→改空格→貼上就能用） |
| **第一次用、還沒裝工具** | **[GETTING-STARTED.md](GETTING-STARTED.md)**（第一次裝機，手把手） |
| **想生成某個東西**（助教/投影片/小考/互動…） | **[生成手冊.md](生成手冊.md)**（按目標翻節：觸發句→過程→產出→驗收→發布） |
| 想先看成品長什麼樣 | `example-full/`（發布版附；真實課程全套＋操作走查） |
| 查某功能的細節/FAQ | [USER-MANUAL.md](USER-MANUAL.md)（完整參考） |
| 發布互動教材 | PUBLISH-GITHUB-IO.md（發布版附） |
| 工具裝了沒 | [SETUP.md](SETUP.md) 或 `bash scripts/setup-check.sh` |

教材類生成物各附一份**格式統一的使用手冊**（`使用手冊-<類型>.md`，欄位見 `templates/usage-manual-template.md`）。

---

## 這套件裡有什麼

```
（本套件根目錄）
├── README.md                    ← 你正在看的這份
├── GETTING-STARTED.md           ← 零基礎完全指南（第一次先看）
├── WORKSHOP-COMMANDS.md         ← 課堂指令表（工作坊當天照這張抄）
├── USER-MANUAL.md               ← 完整功能手冊
├── 生成手冊.md                   ← ★ 按目標的生成教學（觸發句→產出→驗收→發布）
├── PUBLISH-GITHUB-IO.md（發布版附）         ← 發布到 github.io、看全班結果
├── SETUP.md                     ← 依賴清單（＋ scripts/setup-check.sh 一鍵檢查）
├── constitution.md              ← 教材開發憲法（所有 skill 共用規則）
├── skills/                      ← 9 個 skill（見下）
├── course-context/              ← 放你的講義（AI 據此作答，降低幻覺）
├── templates/                   ← 迷你規格、驗收清單、rubric 範本
├── scripts/                     ← setup-check.sh（依賴一鍵檢查）
├── openspec/                    ← Spectra／SDD 設定（互動教材走完整 SDD 時用）
├── example/ ＋ example-full/    ← 迷你格式示範 ＋ 真實課程實測全套（發布版附）
└── agent/                       ← 空白「24h 助教」骨架（含教學框架與雙工具轉接頭）
    ├── AGENT.md / knowledge-graph.md / INSTRUCTOR-MANUAL.md
    ├── README.md                ← 學生版使用說明模板（發布後學生第一眼）
    ├── references/              ← 教學風格 DNA ＋ 老師校準（優先級最高）
    ├── syllabus.md / exams.md   ← 課務與考古題（根目錄，老師熟悉的分類）
    ├── prerequisites.md         ← 課前先備＋自我檢測題模板
    ├── lecture-notes/ homework/ cases/ ← 講義（14 節）、每份作業一檔、案例（有才生成）
    ├── source-materials/        ← 原始教材投放區（檔案偵測式初始化的輸入）
    ├── ACCEPTANCE-CHECKLIST.md   ← 助教驗收表（四層框架）
    ├── INITIALIZATION-REPORT.md  ← 初始化的集中檢查回報
    ├── .claude/                 ← Claude Code 轉接頭（/ta 指令＋子代理）
    └── .codex/                  ← Codex 轉接頭（skill）
        （完整樹見骨架的 INSTRUCTOR-MANUAL.md §2）
```

### 9 個 skill（餵最小輸入就生成；教材類各附一份 `使用手冊-<類型>.md`（如 `使用手冊-slides.md`），`teach-context` 為蒸餾器——分類蒸餾出 `lecture-notes/`、根 `syllabus.md`/`exams.md`、`homework/`、`cases/`（有檔才生成），不另產手冊）

| Skill | 觸發 | 產出 |
|-------|------|------|
| `teach-context` | `用「teach-context」這個 skill，講義在：<資料夾或檔案路徑>。` | 把整個課程資料夾**分類蒸餾**（有檔才生成）：講義→`lecture-notes/`、課綱→`syllabus.md`、作業→`homework/`、考古題→`exams.md`、案例→`cases/` |
| `teach-prereq` | `用「teach-prereq」這個 skill，課名：____，對象：____。` | 課前先備知識清單（課裡常提到、卻假設你以前就會的）＋學生自我檢測 |
| `teach-agent` | `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。` | 一整個 24h 助教資料夾 `<課程代碼>-ta/`（大腦＋知識圖＋教學框架＋Claude/Codex 轉接頭＋驗收表，已 git init 可發布） |
| `teach-slides` | `用「teach-slides」這個 skill，單元：____，對象：____。` | 投影片（標題＋3 要點＋建議視覺） |
| `teach-worksheet` | `用「teach-worksheet」…` | 學習單（形成性／總結性） |
| `teach-quiz` | `用「teach-quiz」…` | 小考＋四級 rubric＋人工複核流程 |
| `teach-sim` | `用「teach-sim」這個 skill，我想做一個 ____ 的互動教材給 ____。` | 互動網頁（**網路版部署**；紀錄預設離線、可開共享看全班結果），走完整 SDD |
| `teach-animation` | `用「teach-animation」這個 skill，我想做一個 ____ 的動畫。` | 用 **manim** 做動畫影片（mp4），走完整 SDD（選用依賴 manim/ffmpeg） |
| `teach-refine` | `用「teach-refine」這個 skill，TA 資料夾：____，回饋來源：____。` | 上線後迭代：回饋→逐條裁決表→老師確認→最小修改→重跑驗收探針→`REFINE-LOG.md` 留痕 |

## 心法：SDD 四步（先想清楚再動手）

> **想法 → 規格 → 計畫 → 任務 → 實作**。規格是主角；需求變了先改規格再重做。

隨教材複雜度分級：投影片／學習單／小考走**迷你規格**（目的＋驗收清單）；互動網頁走**完整 SDD**（`propose → 審 → apply → 開瀏覽器驗 → archive`）。

## 助教：一個大腦、多個轉接頭

`agent/AGENT.md` 是**唯一大腦**（人格、規則、教學風格、範圍）；`.claude/`（Claude Code）與 `.codex/`（Codex）只是**薄轉接頭**委派給它。呼叫法：

- **Claude Code**：`/ta 你的問題`，或叫子代理。
- **Codex**：`Use $<課程代碼>-ta-agent to answer: 你的問題`。

改行為改 `AGENT.md` 就好，兩邊自動一致。教學風格與「老師校準」在 `agent/references/`（校準優先級最高）。

> **接地不只講義**：課綱（根 `syllabus.md`）、作業（`homework/`）、考古題（根 `exams.md`）、案例（`cases/`，選用）都是助教的來源，依 `AGENT.md` 行為規則回應（課務據實答＋標「以公告為準」、作業/考試只給提示且**多輪拼不出完整解**、考古題帶複習）——**Claude 與 Codex 兩種轉接頭行為一致**。**最省事**：觸發句指定原始教材資料夾，`teach-agent` 會複製骨架、匯入教材、**檔案偵測式初始化**（有檔才生成）一次生出整個助教。

## 怎麼開始（四步）

1. **裝好工具**：**必裝**＝Claude Code 或 Codex（終端機 AI）＋ git ＋ Spectra CLI；**選裝**＝pandoc（讀 .docx 講義）、manim＋ffmpeg（做動畫）。逐項安裝/驗證見 [SETUP.md](SETUP.md)，或跑 `bash scripts/setup-check.sh` 一鍵檢查。
2. **放講義**：丟進 `course-context/`（懶得整理可用 `teach-context` 把原始檔分類蒸餾，見上表）。**做過助教初始化的話這裡通常已自動有講義**——`teach-agent` 收尾會把蒸餾好的 `lecture-notes/*.md` 回寫進來。
   > **講義放哪**：套件根 `course-context/` 供**材料 skill**（投影片/學習單/小考等）當工作區；助教資料夾的 `lecture-notes/` 由 `teach-agent` 從其 `source-materials/` 生成，初始化收尾會回寫一份到套件根 `course-context/`（找不到套件就略過，結果記在初始化報告）。助教講義要更新，是把新原始檔丟進助教 repo 的 `source-materials/` 再重跑初始化或增量生成（見助教 `INSTRUCTOR-MANUAL.md` §14）——重跑後會再次回寫。只做助教不生教材，可不用 `course-context/`。
3. **生教材**：`用「teach-slides」這個 skill，單元：____，對象：____。`（其他 skill 同型）。
4. **做助教**：貼觸發句 `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。`——它會複製骨架 `agent/` 成 `<課程代碼>-ta/`、把你指定資料夾的教材匯入其 `source-materials/`、檔案偵測式生成、最後 git init 成可發布 repo；再用產出資料夾內的 `ACCEPTANCE-CHECKLIST.md` 驗收（老師手冊見其 `INSTRUCTOR-MANUAL.md`）。

> **想先看成品長什麼樣**：開 `example-full/`（發布版附；真實課程實測全套——助教＋教材＋SDD 歸檔），其 README 有「輸入→一句話→產出」對照表；迷你格式示範另見 `example/`。

## 三個工具怎麼對應（不綁單一工具）

9 個 skill 都是**純 `SKILL.md`**，Spectra、Spec Kit、Cursor、Claude Code、Codex 都讀得懂。互動網頁的完整 SDD 流程對照：

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

**驗收助教** — 四組探針：① 觀念題（答＋引用小節）② 作業題（**只給提示**）③ 超綱題（**不編造**）④ 誘導幻覺（不被牽走）。（空白表在 `agent/ACCEPTANCE-CHECKLIST.md`；填好的真實範例見 `example-full/`（發布版附）內助教的同名檔。）

**驗收學習單** — 親手做一遍：結構齊（3 題＋迷思＋給學生版＋老師審核欄）／每題對應真實迷思／**親自驗算答案**／強弱學生視角試鑑別度／學生版無洩漏／台灣用語無簡體。

> 一句話：**「能生成 ≠ 堪用」——助教要親手問過四類探針、學習單要親手做過一遍，才算驗收通過。**

---

*EduSpec · 台灣經濟學會 AI 教學應用工作坊 · 版本 2026-07*
