# Course TA Template：Instructor Manual

> 給老師的完整操作手冊——從放教材、初始化、審查到發布與學期維護。學生不需要讀這份。

## 1. 範本用途與設計原則

把你的原始教材變成一個學生端 24 小時 AI 助教。設計原則：①目錄照老師熟悉的教材分類；②**有原始教材才生成**，沒有就略過、不虛構；③全域 TA 行為集中在 `AGENT.md`；④初始化後**集中回報**需人工檢查的檔案（不例行「請老師確認」）；⑤期末專案不在本範本（另有專案 repo）。

## 2. 專案目錄結構

```
├── README.md            ← 學生使用說明（發布後學生第一眼）
├── INSTRUCTOR-MANUAL.md ← 本檔（老師專用）
├── AGENT.md             ← 助教大腦：角色、來源優先序、協助邊界
├── syllabus.md          ← 課務（初始化自你的課綱）
├── exams.md             ← 考古題（單檔；是否讓學生看全文由你決定）
├── lecture-notes/       ← 每單元一檔（14 節統一結構）
├── homework/            ← 每份作業一檔（frontmatter schema；無解答）
├── cases/               ← 選用：有 case 原始教材才存在
├── prerequisites.md     ← 課前先備＋自我檢測題
├── knowledge-graph.md   ← 課程概念地圖（學生與助教共用）
├── references/          ← 教學風格與你的親自校準
├── ACCEPTANCE-CHECKLIST.md ← 發布前驗收表
├── INITIALIZATION-REPORT.md ← 初始化的集中檢查回報
└── source-materials/    ← 你的原始教材放這裡（初始化的輸入）
```

## 3. 準備 source-materials

把原始教材照類型丟進 `source-materials/`：`syllabus.*`（PDF/DOCX/MD 皆可）、`lecture-notes/`、`slides/`（選用，作為講義的輔助來源）、`homework/`、`cases/`（選用）。**沒有的類型不用建資料夾。**

## 4. 執行初始化技能

在套件根對 coding agent 說：`用「teach-agent」這個 skill，課名：__，授課教師：__，對象：__。`（原始教材已在 `source-materials/`）。它會**掃描實際存在的檔案、有什麼生成什麼**。

## 5. 初始化會生成什麼

依序：`syllabus.md` → `lecture-notes/*.md`（每單元一檔；有對應 slides 會一併參考）→ `homework/hwXX.md`（每份獨立）→ `cases/caseXX.md`（僅當有 case 教材）→ `prerequisites.md`（含自我檢測題）→ `knowledge-graph.md` → 學生版 `README.md` → 填實 `AGENT.md` → `INITIALIZATION-REPORT.md` → 驗收測試。

## 6. 審查 INITIALIZATION-REPORT.md

**先看這份**：所有需要你人工判斷的地方（無法辨識的數字、講義與投影片矛盾、缺頁、無法分類的檔案）都集中在這裡，每項含生成檔／來源／位置／原因／AI 的處理方式。報告寫「無」就代表沒有待決事項。

## 7. 審查 lecture notes

抽讀幾份：定義、推導、例子的數字是否忠於原始教材；引用小節編號是否可對回。**學科正確性由你把關**——AI 產草稿，你審。

## 8. 設定 homework 與 cases

- 每份 `homework/hwXX.md` 的 frontmatter：確認日期、配分、繳交方式；`ai_policy` 填該作業的綠／黃／紅燈（個別規定比全域嚴格時，助教會從嚴）。
- **檔內不會有解答**——初始化刻意排除；助教的「只給提示」由 `AGENT.md` 統一把關。
- cases 只在你有 case 教材時存在；case 檔內不放誠信章節（統一在 `AGENT.md`）。

## 9. 審查 prerequisites 與 knowledge graph

- `prerequisites.md`：確認「必要 vs 建議」分類、檢測題難度（以能否開始修課為準）。
- `knowledge-graph.md`：箭頭方向統一 `A → B`＝A 是 B 的先備；核心節點 15–40 個；每個概念連到實際 lecture note。

## 10. 校準 AGENT.md

- 換掉所有 `{{ }}`（初始化通常已填）；口吻與慣用例子可在 `references/first-person-calibration.md` 用**你自己的話**校準（優先級最高）。
- 全域協助邊界（一步為限、多輪不拼答案、只指第一個關鍵錯）都在 `AGENT.md` 第四節——要調整就改這裡，**不要**散落在各作業檔。

## 11. 執行驗收測試

照 `ACCEPTANCE-CHECKLIST.md` 冷測（每題新對話）：誠信（作業求解拒給、多輪拼裝拒絕）／正確／會教／據本課，加**先備互動檢測**（一次一題）試一輪。誠信類必 100% 過。

## 12. 發布給學生

1. 建 GitHub repo（public 讓學生免費取用，或 private 邀請學生）。
2. **刪掉 `README.md` 第一行的老師提醒 banner**、確認 `{{ }}` 全數填實。
3. 推上 GitHub，把連結給學生——README 就是他們的使用說明。
4. （選配）也可把 `AGENT.md` 內容貼進 GPTs／Claude Projects 當網頁版。

## 13. 著作權、個資與安全

- `source-materials/` 含你的原始教材：**是否隨學生版一起發布由你決定**（有著作權疑慮可在發布前移除或 `.gitignore`）。
- `exams.md` 含考古題完整題幹：**是否讓學生看全文由你決定**。
- repo 不得含學生個資；提醒學生不要輸入個資與金鑰。

## 14. 學期間更新

新單元教完 → 把原始檔丟進 `source-materials/` → 再跑一次初始化（或只請 agent 增量生成該單元）→ 更新 `AGENT.md` 已載入清單與 `knowledge-graph.md` → 推上 GitHub，學生 `git pull` 即得新版。**老師人工改過的檔案，重新初始化前先備份**（增量生成時明確告訴 agent 不要覆寫哪些檔）。

## 15. 下一學期重新初始化

換學期：更新 `source-materials/`（新課綱、新作業）→ 全量重跑初始化 → 重走第 6–11 節的審查與驗收 → 重新發布。`references/first-person-calibration.md` 的校準可跨學期沿用。
