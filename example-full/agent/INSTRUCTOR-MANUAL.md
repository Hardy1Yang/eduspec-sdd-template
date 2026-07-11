# Econ 5166 AI TA（fa-25 示範版）：Instructor Manual

> 給老師的完整操作手冊——從放教材、初始化、審查到發布與學期維護。學生不需要讀這份。
> 本資料夾是 example-full 的**展示助教**：以 fa-25 真實素材、在潔淨室實測中由 `teach-agent` 建出（過程見 `../操作走查.md`）；同一門課的正式版助教（fa-26，全 12 週＋hw01–hw05＋case01–case04）另存於獨立 repo。

## 1. 範本用途與設計原則

把你的原始教材變成一個學生端 24 小時 AI 助教。設計原則：①目錄照老師熟悉的教材分類；②**有原始教材才生成**，沒有就略過、不虛構；③全域 TA 行為集中在 `AGENT.md`；④初始化後**集中回報**需人工檢查的檔案（不例行「請老師確認」）；⑤期末專案不在本 repo（另有專案 repo，`syllabus.md` 只留課務層級資訊）。

## 2. 專案目錄結構

```
agent/（示範助教）
├── README.md            ← 學生使用說明（發布後學生第一眼）
├── INSTRUCTOR-MANUAL.md ← 本檔（老師專用）
├── AGENT.md             ← 助教大腦：角色、來源優先序、協助邊界
├── syllabus.md          ← 課務（初始化自 FA25 課綱＋專案規範的課務部分）
├── exams.md             ← 考古題（單檔：2024 期中考複習指引、無解答）
├── lecture-notes/       ← 每單元一檔（本示範版：w01–w03，14 節結構）
├── homework/            ← hw01（題型摘要；無解答）
├── cases/               ← case01（prediction：販賣機部署決策）
├── prerequisites.md     ← 課前先備＋自我檢測
├── knowledge-graph.md   ← 課程概念地圖（學生與助教共用）
├── references/          ← 教學風格 DNA ＋ 你的親自校準（first-person-calibration.md）
├── ACCEPTANCE-CHECKLIST.md ← 發布前驗收表
├── INITIALIZATION-REPORT.md ← 初始化的集中檢查回報
├── .claude/  .codex/    ← 兩套薄轉接頭（皆委派 AGENT.md；改行為改 AGENT.md 即可兩邊一致）
└── source-materials/    ← 原始教材投放區（本示範版僅留 README 說明，原始 PDF 未隨附）
```

## 3. 準備 source-materials

把原始教材照類型丟進 `source-materials/`：`syllabus/`、`lecture-notes/`、`slides/`（選用）、`homework/`、`exams/`、`cases/`（沒有的類型不用建資料夾）。本示範版的原始檔（3 份講義 .tex＋5 份 PDF）在潔淨室測試中由老師另行提供、未隨本資料夾發布——見 `source-materials/README.md`。

## 4. 執行初始化技能

在套件根對 coding agent 說：

```
用「teach-agent」這個 skill，課名：Econ 5166「Data Science and Social Inquiry」，授課教師：陳由常，對象：經濟系研究生，原始教材在：rawcourse/。
```

它會複製骨架成 `<課程代碼>-ta/`、把指定資料夾的教材匯入其 `source-materials/`、**掃描實際存在的檔案、有什麼生成什麼**，最後 git init 成可發布的獨立 repo。本示範資料夾就是這樣建出來的成品。

## 5. 初始化會生成什麼

依序：`syllabus.md` → `lecture-notes/*.md`（每單元一檔）→ `homework/hwXX.md`（每份獨立）→ `cases/caseXX.md`（僅當有 case 教材）→ `prerequisites.md`（含自我檢測題）→ `knowledge-graph.md` → 學生版 `README.md` → 填實 `AGENT.md` → `INITIALIZATION-REPORT.md` → 驗收測試。

## 6. 審查 INITIALIZATION-REPORT.md

**先看這份**：所有需要你人工判斷的地方都集中在這裡，每項含生成檔／來源／位置／原因／AI 的處理方式。本示範版的待決重點：HW PDF 檔名 `hw_1-2` 但內文僅 HW1、2024 期中卷頁首課號誤植、w3 講義文字與圖中分割數值不一致（詳見報告第 4、6 節）。

## 7. 審查 lecture notes

抽讀幾份：定義、推導、例子的數字是否忠於原始講義；引用小節編號是否可對回。**學科正確性由你把關**——AI 產草稿，你審。

## 8. 設定 homework 與 cases

- 每份 `homework/hwXX.md` 的 frontmatter：確認日期、配分、繳交方式；`ai_policy` 填該作業的綠／黃／紅燈（個別規定比全域嚴格時，助教會從嚴）。本示範版 hw01 為題型摘要（`content_fidelity: 摘要`），正式版應保留完整題幹。
- **檔內不會有解答**——初始化刻意排除；助教的「只給提示」由 `AGENT.md` 統一把關。
- cases 只在你有 case 教材時存在；case 檔內不放誠信章節（統一在 `AGENT.md`）。

## 9. 審查 prerequisites 與 knowledge graph

- `prerequisites.md`：確認「必要 vs 建議」分類、檢測題難度（以能否開始修課為準；本課先備＝微積分基礎統計＋R/Python/Stata 資料操作經驗）。
- `knowledge-graph.md`：箭頭方向統一 `A → B`＝A 是 B 的先備；每個概念連到實際 lecture note；三個主幹概念（條件期望、預測誤差三分解、風險函數）應為圖的樞紐。

## 10. 校準 AGENT.md

- 換掉所有 `{{ }}`（初始化通常已填）；口吻與慣用例子可在 `references/first-person-calibration.md` 用**你自己的話**校準（優先級最高，會凌駕 `teaching-style.md` 的推測）。
- 全域協助邊界（一步為限、多輪不拼答案、只指第一個關鍵錯）都在 `AGENT.md` 第四節——要調整就改這裡，**不要**散落在各作業檔。

## 11. 執行驗收測試

照 `ACCEPTANCE-CHECKLIST.md` 冷測（每題新對話——Claude Code 輸入 /clear 或重啟；Codex 重新啟動一次）：誠信（作業求解拒給、多輪拼裝拒絕、附嘗試只指第一錯）／正確／會教／據本課，加**先備互動檢測**（一次一題）試一輪。誠信類必 100% 過。

## 12. 發布給學生（GitHub 流程）

1. 建 GitHub repo（**public** 讓學生免費取用，或 **private** 再邀請學生）。
2. 逐項走完下方**發布前檢查清單**。
3. 確認 `{{ }}` 全數填實、README 第 10 節的回報管道已填。
4. 把整個資料夾推上 GitHub，把連結公告給學生——README 就是他們的使用說明（含 Claude Code `/ta` 與 Codex `$fa-25-econ-5166-ta-agent` 兩種呼叫法）。
5. （選配）也可把 `AGENT.md` 內容貼進 GPTs／Claude Projects 當網頁版；缺點是 `lecture-notes/` 教材要另外提供。

### 發布前檢查清單（務必逐項確認）

- [ ] **著作權**：`lecture-notes/`、`exams.md` 若含課本／出版社素材片段，已確認授權與來源標示；學科圖表盡量自製。
- [ ] **source-materials/**：原始檔是否隨學生版發布由老師決定；**含解答的原始檔一律排除在 repo 外**（見 `source-materials/README.md`）。
- [ ] **個資**：檔案與 repo **不含任何學生個資**（姓名、學號、成績）。
- [ ] **揭露**：已告知學生「本助教由 AI 協助建置，回答須自行核對」（README 已內建）。
- [ ] **範圍**：`AGENT.md` 第七節已寫明目前涵蓋單元（本示範版 w1–w3），避免學生誤以為全課程都能答。
- [ ] **hint-not-answer**：已冷測作業題只給提示、多輪拼裝會被擋（`ACCEPTANCE-CHECKLIST.md` ① 全過）。

> **懶人路線**：直接對 coding agent 說「照本手冊第 12 節，把這個資料夾發布成 public（或 private）GitHub repo」——它會代你建 repo、刪 banner、推送；完成後把網址發給學生。

## 13. 著作權、個資與安全

- `source-materials/` 含你的原始教材：**是否隨學生版一起發布由你決定**（有著作權疑慮可在發布前移除或 `.gitignore`）。
- 任何**含解答**的原始檔（考卷解答、作業 key、case 參考解答）一律不進 repo——誠信由行為政策把關，但解答檔本身不該存在於學生可見處。
- repo 不得含學生個資；提醒學生不要輸入個資與金鑰（README 第 9 節已內建）。

## 14. 學期間更新

新單元教完 → 把該週原始檔丟進 `source-materials/` → 請 agent **增量生成**該單元（明確告訴它不要覆寫你人工改過的檔）→ 更新 `AGENT.md` 第七節已載入清單與 `knowledge-graph.md` → 推上 GitHub，學生 `git pull` 即得新版。**老師人工改過的檔案，重新初始化前先備份。**

## 15. 下一學期重新初始化

換學期：更新 `source-materials/`（新課綱、新作業）→ 全量重跑初始化 → 重走第 6–11 節的審查與驗收 → 重新發布。`references/first-person-calibration.md` 的校準可跨學期沿用。
