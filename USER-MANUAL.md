# EduSpec 使用手冊（完整功能）

> 這份是**完整參考（附錄性質）**。第一次裝機看 [GETTING-STARTED.md](GETTING-STARTED.md)；**日常生成看 [生成手冊.md](生成手冊.md)**（按目標組織）。
> 貫穿原則：**老師是領域專家、AI 是助手；所有產出都要人工審核**（見 `constitution.md`）。

## 〇、先裝好工具

動手前先確認依賴都在，避免中途卡關：見 **[SETUP.md](SETUP.md)**，或直接跑 `bash scripts/setup-check.sh`（逐項回報就緒/缺少＋安裝指引）。

## 一、套件組成

| 目錄／檔 | 是什麼 |
|----------|--------|
| `constitution.md` | 教材開發憲法（所有 skill 共用的底線規則） |
| `skills/` | 8 個 skill（見第三節） |
| `course-context/` | 放你的講義（AI 據此作答，降低幻覺） |
| `templates/` | 迷你規格、驗收清單、rubric 空白範本 |
| `agent/` | 空白助教骨架（老師熟悉的分類：根 `syllabus.md`/`exams.md`、`lecture-notes/`、`homework/`、`cases/`（選用）、`source-materials/`、`INSTRUCTOR-MANUAL.md`）＋`.claude/`＋`.codex/` 轉接頭 |
| `scripts/` | `setup-check.sh` 依賴一鍵檢查 |
| `openspec/` | Spectra／SDD 設定（互動教材走完整 SDD 時用） |
| `GETTING-STARTED.md` / `USER-MANUAL.md` | 從零上手 / 完整手冊 |
| `example/`（發布版） | 迷你格式示範（填好的迷你助教＋一份投影片） |
| `example-full/`（發布版） | 真實課程實測全套範例：助教＋w2 教材＋SDD 歸檔＋操作走查（見其 README 對照表） |

> **講義放哪**：套件根 `course-context/`＝**工作區**（材料 skill 讀這裡）；助教資料夾的 `lecture-notes/`＝**出貨快照**（自含可攜，發布給學生）。更新講義先改工作區、再同步進助教重發布（見助教的 `INSTRUCTOR-MANUAL.md` §14）；只做助教可只用 `lecture-notes/`。

## 二、心法：先寫規格再生成（隨複雜度分級）

| 教材 | 流程 |
|------|------|
| 投影片 / 學習單 / 小考 | 迷你規格（目的＋驗收清單）→ 生成 → 自查 |
| 互動教材（程式） | 完整 SDD：`/spectra-propose` → 審 → `/spectra-apply` → 開瀏覽器驗 → `/spectra-archive` |

## 三、八個 skill（餵最小輸入就生成；教材類各附一份 `使用手冊-<類型>.md`（如 `使用手冊-slides.md`），`teach-context` 為蒸餾器、不另產手冊）

| Skill | 觸發 | 產出 |
|-------|------|------|
| `teach-context` | `用「teach-context」這個 skill，講義在：<資料夾>。` | 從 .tex/PDF/Word 蒸餾出 `course-context` 精華（降低整理負擔） |
| `teach-prereq` | `用「teach-prereq」這個 skill，課名：__，對象：__。` | 課前先備知識清單（外部/假設先備）＋學生課前自我檢測；寫回知識圖供助教診斷 |
| `teach-agent` | `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。` | 一整個 24h 助教資料夾 `<課程代碼>-ta/`（大腦＋知識圖＋教學框架＋Claude/Codex 轉接頭＋驗收表，已 git init 可發布） |
| `teach-slides` | `用「teach-slides」這個 skill，單元：__，對象：__。` | 投影片（每張標題＋3 要點＋建議視覺）＋使用手冊 |
| `teach-worksheet` | `用「teach-worksheet」…` | 學習單（形成性 3 題附迷思／總結性先藍圖）＋使用手冊 |
| `teach-quiz` | `用「teach-quiz」…` | 小考＋四級 rubric＋人工複核流程＋使用手冊 |
| `teach-sim` | `用「teach-sim」我想做一個 __ 的互動教材給 __。` | 互動教材（**網路版部署**；紀錄預設離線、可開共享看全班結果）＋使用手冊 |
| `teach-animation` | `用「teach-animation」我想做一個 __ 的動畫。` | 用 **manim** 做動畫影片（mp4）＋使用手冊（選用依賴 manim/ffmpeg，見 SETUP） |

> **四個材料 skill（slides／worksheet／quiz／sim）都套用教學 DNA**（見 `skills/teaching-dna.md`）：問題先行、點出常見迷思、收一句金句——讓產出不只是「結構完整卻平庸」。投影片走「鉤子→直覺→機制→誤解→金句」弧線；小考誘答項編碼真實迷思；互動要有「發現時刻」。
>
> **材料 skill 也會選用助教的課程檔對齊實況**（若有）：quiz 對齊 `exams.md` 考風、worksheet 銜接 `homework/`、slides/animation 依 `syllabus.md` 定位、sim 取材 `cases/`、`teach-prereq` 納入課綱明列先備——但**一律不把作業/考試的解答抄進教材、不重現現行考題**（這些檔本就不含解答）。

## 四、助教（agent）

- **建立**：貼 `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。`——它會複製骨架 `agent/` 成 `<課程代碼>-ta/`、把你指定資料夾的教材複製進其 `source-materials/`、檔案偵測式初始化（有檔才生成）、最後 `git init`＋初始 commit 成可發布的獨立 repo（手動流程見助教的 `INSTRUCTOR-MANUAL.md`）。生成物含**教學框架**（`references/teaching-style.md` 教學 DNA、`references/first-person-calibration.md` 老師校準·優先級最高）與**雙工具轉接頭**（`.claude/` ＋ `.codex/`，皆委派 `AGENT.md`）。
- **接地不只講義**：課綱（根 `syllabus.md`）、作業（`homework/`）、考古題（根 `exams.md`）、案例（`cases/`，選用）都是助教的來源，依 `AGENT.md` 行為規則回應——課務據實答（變動性標「以公告為準」）、作業/考試**只給提示**（多輪也拼不出完整解）、考古題帶複習。**從零最省事**：觸發句指定原始教材資料夾，`teach-agent` 一次生成全部。
- **驗收**：用 `agent/ACCEPTANCE-CHECKLIST.md`（四層框架、可影印）。
- **用指令呼叫**：把助教資料夾當專案打開 →
  - Claude Code · 斜線指令：`/ta 你的問題`
  - Claude Code · 子代理：`用 <課程>-ta 子代理回答：…`（獨立 context）
  - Codex · skill：`Use $<課程>-ta-agent to answer: 你的問題`
  - **一個大腦、多轉接頭**：規則都在 `AGENT.md`；`.claude/` 與 `.codex/` 只是把不同工具導向它。
- **預期行為（Claude 與 Codex 皆同）**：觀念題答並引用講義小節；**課務題據課綱答（標「以公告為準」）**；**作業/考試只給提示不給答案**；考古題帶複習；超綱題說超出範圍、不編造。兩種工具的轉接頭都委派 `AGENT.md` 的完整規則（來源路由、協助邊界、多輪不拼裝）。
- **發布**：見助教的 `INSTRUCTOR-MANUAL.md` §12（GitHub clone 給學生；著作權與個資檢查在 §13）。

## 五、互動教材與「看全班結果」

- **網路版部署**：部署到 GitHub Pages（見套件根 [PUBLISH-GITHUB-IO.md](PUBLISH-GITHUB-IO.md)），給學生連結。
- **紀錄預設離線**：互動紀錄存學生**自己瀏覽器**（localStorage）、可**匯出 CSV**——不連網、不含個資，一般課堂這樣就夠。
- **共享紀錄（選用・進階）**：學生貼自己的 GitHub token（存本機），互動 append 到班級 repo，老師端**彙整看全班結果**（適合賽局遊戲）。用**代號、不放個資**；沒 token 時自動退回離線、不報錯。

## 六、發布到 github.io

見套件根 [PUBLISH-GITHUB-IO.md](PUBLISH-GITHUB-IO.md)：5 步發布互動工具＋完整「做→發布→學生用→匯出/彙整紀錄」流程。

## 七、驗收（人工，務必做）

- **助教**：四組探針——觀念題（答＋引用）／作業題（只給提示）／超綱題（不編造）／誘導幻覺（不被牽走）。
- **學習單／小考**：結構齊、每題對應真實迷思、**親自驗算答案**、用強/弱學生視角試鑑別度、學生版無洩漏、rubric 四級概念與表達分開。
- **互動教材**：能跑 ≠ 正確——親手操作每個控制項驗學科邏輯；離線與（如用）共享都測過。
- 完整可影印驗收表見 `agent/ACCEPTANCE-CHECKLIST.md`（四層框架）；精簡版見 `README.md` 的「人工驗收」段落。

## 八、常見問題

| 狀況 | 處理 |
|------|------|
| skill 沒依講義答 | 確認 `course-context/` 有對應單元；skill 查無會請你補放 |
| `/ta` 指令沒出現 | 打開的要是**助教資料夾**本身；重開 Claude Code |
| 共享模式連不上 | 檢查 token 權限（勾 `repo`）與 `owner/repo`；沒設 token 會自動離線 |
| 想換概念重做 | 先改規格再重跑（SDD 精神），別直接改程式 |

---

*EduSpec · 台灣經濟學會 AI 教學應用工作坊。所有產出需人工審核；上傳講義注意著作權與個資。*
