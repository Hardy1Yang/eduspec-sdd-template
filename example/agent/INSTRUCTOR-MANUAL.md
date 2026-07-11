# 個體經濟學（初級）：Instructor Manual（示範精簡版）

> 這是把空白骨架 `../../agent/INSTRUCTOR-MANUAL.md` 精簡填實後的樣子（econ-101 假想情境）。完整操作手冊請看骨架版；本檔只示範「填好之後老師端看到什麼」。學生不需要讀這份。

## 1. 這個示範怎麼來的

假想情境：老師（王小明）把第一週講義與課綱丟進 `source-materials/`，對 coding agent 說一句觸發句跑初始化。因為原始教材只有課綱與一週講義，所以**只生成**根 `syllabus.md` 與 `lecture-notes/w01-supply-demand.md`——沒有作業、考古題、case 的原始檔，就沒有 `homework/`、`exams.md`、`cases/`（有檔才生成，不虛構）。

## 2. 本示範的目錄結構

```
├── README.md                ← 學生使用說明
├── INSTRUCTOR-MANUAL.md     ← 本檔（老師專用）
├── AGENT.md                 ← 助教大腦：角色、來源優先序、協助邊界
├── syllabus.md              ← 課務（示範）
├── lecture-notes/           ← 每單元一檔（14 節統一結構；本例只有 w01）
├── knowledge-graph.md       ← 課程概念地圖
├── ACCEPTANCE-CHECKLIST.md  ← 發布前驗收表（已填 econ-101 探針）
├── INITIALIZATION-REPORT.md ← 初始化的集中檢查回報（示範寫法）
└── source-materials/        ← 原始教材放這裡（本例為假想，見其 README）
```

## 3. 老師端的審查順序（照骨架手冊，本例已做完）

1. **先看 `INITIALIZATION-REPORT.md`**：需要人工判斷的事全集中在那裡；寫「無」就是沒有待決事項。
2. 抽讀 `lecture-notes/w01-supply-demand.md`：定義與例子是否忠於原始教材、小節編號可否對回。
3. 校準 `AGENT.md`：口吻、慣用例子、協助邊界（一步為限、多輪不拼答案、只指第一個關鍵錯）都在第四節。
4. 照 `ACCEPTANCE-CHECKLIST.md` 冷測：誠信類必 100% 過才可發布。

## 4. 發布與更新（示範情境）

- 發布：確認 README 無老師提醒 banner、`{{ }}` 全填實 → 推上 GitHub 給學生。
- 學期間：教完新單元 → 原始檔丟 `source-materials/` → 增量初始化 → 更新 `AGENT.md` 已載入清單與 `knowledge-graph.md`。
