# Initialization Report — Econ 5166「Data Science and Social Inquiry」（fa-25 示範版）

> 初始化的**集中檢查回報**——所有需要老師人工判斷的事集中在這裡，各生成檔內**不**例行加「待老師確認」。
> 本檔為 example-full 的**示範寫法**：對應潔淨室實測（fa-25 素材，見 `../操作走查.md`）。

## 1. 生成摘要

掃描老師提供之原始教材資料夾 `rawcourse/`（講義 .tex 3 份、課綱 PDF 1 份、作業原卷 PDF 1 份、期中考原卷 PDF 1 份、case 描述 PDF 1 份、期末專案規範 PDF 1 份，共 8 檔），生成：根目錄 `syllabus.md`（課綱＋專案規範之課務層級內容）與 `exams.md`（2024 期中考複習指引）、`lecture-notes/` 3 檔（w01–w03，14 節結構）、`homework/hw01.md`（題型摘要）、`cases/case01.md`（prediction case），並填實 `AGENT.md`、學生版 `README.md`、`INSTRUCTOR-MANUAL.md`、`ACCEPTANCE-CHECKLIST.md` 與 `.claude/`／`.codex/` 兩套轉接頭；`prerequisites.md` 與 `knowledge-graph.md` 依同一批教材產生。合理性檢查：**有** syllabus／lecture-notes／homework／exams／cases 五類教材；**無** slides——未建立 slides 輔助來源；project 教材僅取課務層級資訊併入 `syllabus.md`（見第 5 節）。

本示範版採用之**預設**：

- **考古題檔案形式**：採**單一 `exams.md`**（不逐份考試拆檔）。
- **source-materials 是否隨學生版發布**：本示範資料夾**未隨附原始 PDF**（僅留 `source-materials/README.md` 說明投放規則）；正式使用時由老師決定是否隨附。
- **front matter 欄位**：保留 `source_files` 與 `last_updated`，便於對照原始檔與追蹤更新。

## 2. 已生成檔案

| 檔案 | 來源 |
|------|------|
| `syllabus.md` | `FA25 Econ 5166 Syllabus.pdf`＋`期末專案的管理與交付規範.pdf`（僅課務層級部分） |
| `exams.md` | `Midterm (2024).pdf`（主題與題型摘要，無解答） |
| `lecture-notes/w01-math-review.md` | `w1-math-review.tex` |
| `lecture-notes/w02-prediction-problem.md` | `w2-prediction-problem.tex` |
| `lecture-notes/w03-regression-trees.md` | `w3-regression-trees.tex` |
| `homework/hw01.md` | `fa25_econ_5166_hw_1-2.pdf`（實際僅含 HW1，見第 4 節） |
| `cases/case01.md`（prediction） | `Prediction Case Discription.pdf` |
| `knowledge-graph.md`、`prerequisites.md` | 依 lecture-notes 與 syllabus 產生（`teach-prereq` 盤點外部先備） |
| `AGENT.md`、`README.md`、`INSTRUCTOR-MANUAL.md`、`ACCEPTANCE-CHECKLIST.md` | 骨架範本填實（口吻指引、主題範圍、協助邊界） |
| `.claude/commands/ta.md`、`.claude/agents/fa-25-econ-5166-ta.md`、`.codex/skills/fa-25-econ-5166-ta-agent/SKILL.md`＋`agents/openai.yaml` | 骨架轉接頭填實（名稱 `/ta`、`fa-25-econ-5166-ta`、`fa-25-econ-5166-ta-agent`；路由指向新結構） |
| `source-materials/README.md` | 分類投放規則與本示範版說明 |

## 3. 略過的選用模組

- **slides/**：無投影片原始檔 → 未建立，lecture notes 僅依講義 .tex 生成。
- **project 教材**：`期末專案的管理與交付規範.pdf` 依規格 project 不屬本 repo 範圍 → 未生成獨立教材；課務層級資訊（時程、交付、評量）已併入 `syllabus.md` 的 Final Project 節。

## 4. 需要人工檢查的檔案

> 每項含：生成檔／原始來源／具體位置／問題原因／AI 採取的處理方式。

- 生成檔：`homework/hw01.md`
  - 原始來源：`fa25_econ_5166_hw_1-2.pdf`
  - 位置：整份檔案
  - 原因：檔名為 `hw_1-2` 但**實際內容僅含 HW1**
  - 處理：依實際內容生成 hw01；檔名疑義於檔內註記，未自行改名
- 生成檔：`exams.md`
  - 原始來源：`Midterm (2024).pdf`
  - 位置：卷首
  - 原因：2024 期中卷**頁首課號疑似誤植**
  - 處理：照原卷主題蒸餾並註記，未自行更正
- 生成檔：`lecture-notes/w03-regression-trees.md`
  - 原始來源：`w3-regression-trees.tex`
  - 位置：遞迴分割例（第 3.1 節）
  - 原因：講義**文字敘述與圖中分割數值不一致**
  - 處理：照原稿轉寫、未擅自修正，請老師裁決
- 生成檔：`homework/hw01.md`
  - 原始來源：同上
  - 位置：frontmatter `due_date`、`submission_method`、`total_points`
  - 原因：原卷未載明截止日與繳交平台
  - 處理：標「未載明（以最新公告為準）」，未自行猜測

## 5. 未使用或無法分類的原始檔

- **`期末專案的管理與交付規範.pdf`**：project 不屬本 repo 範圍——課務層級資訊已併入 `syllabus.md` 的 Final Project 節，其餘詳規（範本筆記本等）屬專案範本 repo 的範圍，未處理成教材。

## 6. 原始教材衝突

- **w3 講義內部**：遞迴分割例的文字與圖中數值不一致——照原稿並列，未裁決（詳見第 4 節）。
- 其餘：無。

## 7. 可能缺少的附件

- `cases/case01.md`：case 原始 PDF 提及配套資料集（3,000 台販賣機歷史銷售紀錄、1,000 個候選點資料），資料檔未隨 repo 附上——取得管道以課程公告為準。
