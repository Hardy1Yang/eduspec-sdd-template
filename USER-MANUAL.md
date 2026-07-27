# EduSpec 使用手冊（完整功能）

> 這份是**完整參考（附錄性質）**。第一次裝機看 [GETTING-STARTED.md](GETTING-STARTED.md)；**日常生成看 [生成手冊.md](生成手冊.md)**（按目標組織）。
> 貫穿原則：**老師是領域專家、AI 是助手；所有產出都要人工審核**（見 `constitution.md`）。

## 〇、先裝好工具

動手前先確認依賴都在，避免中途卡關：見 **[SETUP.md](SETUP.md)**，或直接跑 `bash scripts/setup-check.sh`（逐項回報就緒/缺少＋安裝指引）。

## 一、套件組成

| 目錄／檔 | 是什麼 |
|----------|--------|
| `constitution.md` | 教材開發憲法（所有 skill 共用的底線規則） |
| `skills/` | 9 個 skill（見第三節） |
| `course-context/` | 放你的講義（AI 據此作答，降低幻覺） |
| `templates/` | 迷你規格、驗收清單、rubric 空白範本 |
| `agent/` | 空白助教骨架（老師熟悉的分類：`AGENT.md`、根 `syllabus.md`/`exams.md`、`lecture-notes/`、`homework/`、`cases/`（選用）、`source-materials/`、`INSTRUCTOR-MANUAL.md`）＋`.claude/`＋`.codex/` 轉接頭；完整樹見其 `INSTRUCTOR-MANUAL.md` §2 |
| `scripts/` | `setup-check.sh` 依賴一鍵檢查 |
| `openspec/` | Spectra／SDD 設定（互動教材走完整 SDD 時用） |
| `GETTING-STARTED.md` / `USER-MANUAL.md` | 從零上手 / 完整手冊 |
| `生成手冊.md` | 按目標的日常生成教學（觸發句→過程→產出→驗收→發布） |
| `SETUP.md` | 依賴清單與安裝/驗證指引（搭配 `scripts/setup-check.sh`） |
| `example/`（發布版） | 迷你格式示範（填好的迷你助教＋一份投影片） |
| `example-full/`（發布版） | 真實課程實測全套範例：助教＋w2 教材＋SDD 歸檔＋操作走查（見其 README 對照表） |

> **講義放哪**：套件根 `course-context/` 僅供**材料 skill**（投影片/學習單/小考等）當工作區讀取；助教資料夾的 `lecture-notes/` 由 `teach-agent` 從其 `source-materials/` 生成——**兩邊是兩條獨立的線，沒有同步機制**。助教的講義要更新，是把新原始檔丟進助教 repo 的 `source-materials/` 再重跑初始化或增量生成（見其 `INSTRUCTOR-MANUAL.md` §14）。只做助教不生教材，可不用 `course-context/`。

## 二、心法：先寫規格再生成（隨複雜度分級）

| 教材 | 流程 |
|------|------|
| 投影片 / 學習單 / 小考 | 迷你規格（目的＋驗收清單）→ 生成 → 自查 |
| 互動教材（程式） | 完整 SDD：`/spectra-propose` → 審 → `/spectra-apply` → 開瀏覽器驗 → `/spectra-archive` |

## 三、九個 skill（餵最小輸入就生成；教材類各附一份 `使用手冊-<類型>.md`（如 `使用手冊-slides.md`），`teach-context` 為蒸餾器、不另產手冊）

| Skill | 觸發 | 產出 |
|-------|------|------|
| `teach-context` | `用「teach-context」這個 skill，講義在：<資料夾或檔案路徑>。` | 把整個課程資料夾**分類蒸餾**（有檔才生成）：講義→`lecture-notes/`、課綱→根 `syllabus.md`、作業→`homework/`、考古題→根 `exams.md`、案例→`cases/` |
| `teach-prereq` | `用「teach-prereq」這個 skill，課名：____，對象：____。` | 課前先備知識清單（外部/假設先備）＋學生課前自我檢測；寫回知識圖供助教診斷 |
| `teach-agent` | `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。` | 一整個 24h 助教資料夾 `<課程代碼>-ta/`（大腦＋知識圖＋教學框架＋Claude/Codex 轉接頭＋驗收表，已 git init 可發布） |
| `teach-slides` | `用「teach-slides」這個 skill，單元：____，對象：____。` | 投影片（每張標題＋3 要點＋建議視覺）＋使用手冊 |
| `teach-worksheet` | `用「teach-worksheet」…` | 學習單（形成性 3 題附迷思／總結性先藍圖）＋使用手冊 |
| `teach-quiz` | `用「teach-quiz」…` | 小考＋四級 rubric＋人工複核流程＋使用手冊 |
| `teach-sim` | `用「teach-sim」這個 skill，我想做一個 ____ 的互動教材給 ____。` | 互動教材（**網路版部署**；紀錄預設離線、可開共享看全班結果）＋使用手冊 |
| `teach-animation` | `用「teach-animation」這個 skill，我想做一個 ____ 的動畫。` | 用 **manim** 做動畫影片（mp4）＋使用手冊（選用依賴 manim/ffmpeg，見 SETUP） |
| `teach-refine` | `用「teach-refine」這個 skill，TA 資料夾：____，回饋來源：____。` | 上線後迭代：回饋收斂成逐條裁決表→老師確認→最小修改對應層→重跑相關驗收探針→`REFINE-LOG.md` 留痕 |

> **四個材料 skill（slides／worksheet／quiz／sim）都套用教學 DNA**（見 `skills/teaching-dna.md`）：問題先行、點出常見迷思、收一句金句——讓產出不只是「結構完整卻平庸」。投影片走「地圖→鉤子→直覺→機制→誤解→金句」弧線；小考誘答項編碼真實迷思；互動要有「發現時刻」。
>
> **材料 skill 也會選用助教的課程檔對齊實況**（若有）：quiz 對齊 `exams.md` 考風、worksheet 銜接 `homework/`、slides/animation 依 `syllabus.md` 定位、sim 取材 `cases/`、`teach-prereq` 納入課綱明列先備——但**一律不把作業/考試的解答抄進教材、不重現現行考題**（這些檔本就不含解答）。

## 四、助教（agent）

- **建立**：貼 `用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。`——它會複製骨架 `agent/` 成 `<課程代碼>-ta/`、把你指定資料夾的教材複製進其 `source-materials/`、檔案偵測式初始化（有檔才生成）、最後 `git init`＋初始 commit 成可發布的獨立 repo（手動流程見助教的 `INSTRUCTOR-MANUAL.md`）。生成物含**教學框架**（`references/teaching-style.md` 教學 DNA、`references/first-person-calibration.md` 老師校準·優先級最高）與**雙工具轉接頭**（`.claude/` ＋ `.codex/`，皆委派 `AGENT.md`）。
- **接地不只講義**：課綱（根 `syllabus.md`）、作業（`homework/`）、考古題（根 `exams.md`）、案例（`cases/`，選用）都是助教的來源，依 `AGENT.md` 行為規則回應——課務據實答（變動性標「以公告為準」）、作業/考試**只給提示**（多輪也拼不出完整解）、考古題帶複習。**從零最省事**：觸發句指定原始教材資料夾，`teach-agent` 一次生成全部。
- **驗收**：用 `agent/ACCEPTANCE-CHECKLIST.md`（四層框架、可影印）。
- **用指令呼叫**：把助教資料夾當專案打開 →
  - Claude Code · 斜線指令：`/ta 你的問題`
  - Claude Code · 子代理：`用 <課程>-ta 子代理回答：…`（獨立 context）
  - Codex · skill：`Use $<課程代碼>-ta-agent to answer: 你的問題`
  - **一個大腦、多轉接頭**：規則都在 `AGENT.md`；`.claude/` 與 `.codex/` 只是把不同工具導向它。
- **預期行為（Claude 與 Codex 皆同）**：觀念題答並引用講義小節；**課務題據課綱答（標「以公告為準」）**；**作業/考試只給提示不給答案**；考古題帶複習；超綱題說超出範圍、不編造。兩種工具的轉接頭都委派 `AGENT.md` 的完整規則（來源路由、協助邊界、多輪不拼裝）。
- **發布**：見助教的 `INSTRUCTOR-MANUAL.md` §12（GitHub clone 給學生；著作權與個資檢查在 §13）。
- **上線後迭代（`teach-refine`）**：老師試用意見、學生問答紀錄、驗收失敗項都收進 `用「teach-refine」這個 skill，TA 資料夾：____，回饋來源：____。`——它先把回饋收斂成逐條裁決表（各標對應層：`AGENT.md` 規則／週蒸餾／知識圖譜／某 skill）、**你確認後才動手**、一輪只改一層、改完重跑相關驗收探針並在 `REFINE-LOG.md` 留痕。常見失誤：把模糊回饋直接改規則（應標「待老師釐清」）；一輪同時動多層（難以歸因）。

## 五、互動教材與「看全班結果」

- **產出＝可直接推的資料夾**：sim 生成為**套件同層的 `<單元>-sim/`**（`index.html`＋手冊＋sdd-archive＋README，已 git init，不進 `output/`——與 teach-agent 的獨立資料夾對稱）。本機開 `index.html` 預覽；發布就建 GitHub repo → push → 開 Pages，照套件根 [PUBLISH-GITHUB-IO.md](PUBLISH-GITHUB-IO.md)（發布版附），給學生連結。
- **紀錄預設離線**：互動紀錄存學生**自己瀏覽器**（localStorage）、可**匯出 CSV**——不連網、不含個資，一般課堂這樣就夠。
- **共享紀錄（選用・進階）**：紀錄放**另一個與 Pages 分開的班級紀錄 repo**（分開的理由：token 無法只鎖 `logs/`，同 repo 會讓寫入 token 能改發布頁）。老師產**一把 fine-grained、只授權該紀錄 repo 的**共享 token（fine-grained token 無法讓學生各自產寫你 repo 的 token，故老師產一把、活動時公布給全班），學生貼上後互動 append 到 `logs/<單元>.csv`，老師端**彙整看全班結果**。用**代號、不放個資**；沒 token 時自動退回離線。共享回來的資料視為不可信輸入、已內建淨化。**端到端六步（建 repo→發 token→設定→學生貼→寫入→彙整）見 PUBLISH-GITHUB-IO Part D**。

## 六、發布到 github.io

互動教材的發布已在第五節第一點；完整 5 步與「做→發布→學生用→匯出/彙整紀錄」流程見套件根 [PUBLISH-GITHUB-IO.md](PUBLISH-GITHUB-IO.md)（發布版附）。助教的發布走其 `INSTRUCTOR-MANUAL.md` §12。

## 七、驗收（人工，務必做）

完整可影印驗收表見 `agent/ACCEPTANCE-CHECKLIST.md`（四層框架：誠信＞正確＞會教＞據本課，含探針題與判定表）；教材類通用清單見 `templates/acceptance-checklist.md`；精簡版探針見 `README.md` 的「人工驗收」段落。

## 八、常見問題

| 狀況 | 處理 |
|------|------|
| skill 沒依講義答 | 確認 `course-context/` 有對應單元；skill 查無會請你補放 |
| `/ta` 指令沒出現 | 打開的要是**助教資料夾**本身；重開 Claude Code |
| 共享模式連不上 | 檢查 token（**fine-grained、只授權班級 repo 的 Contents 讀寫**，勿用全帳號）與 `owner/repo`；沒設 token 會自動離線 |
| 想換概念重做 | 先改規格再重跑（SDD 精神），別直接改程式 |

---

*EduSpec · 台灣經濟學會 AI 教學應用工作坊。所有產出需人工審核；上傳講義注意著作權與個資。*
