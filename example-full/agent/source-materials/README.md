# source-materials/ — 原始教材投放區

> 本資料夾存放課程的**原始教材檔案**，是各教學 Markdown（根目錄 `syllabus.md`／`exams.md`、`lecture-notes/`、`homework/`、`cases/`）的生成依據。核心規則：**有檔案才生成教材；沒有檔案就略過**——不提問、不猜測、不由 AI 補造不存在的內容。

## 分類投放規則

| 子資料夾 | 放什麼 | 對應生成物 |
|---|---|---|
| `syllabus/` | 課綱原始檔（PDF/DOCX/MD 皆可） | 根目錄 `syllabus.md` |
| `lecture-notes/` | 各單元講義（.tex/PDF/DOCX/MD） | `lecture-notes/wXX-topic.md`（14 節結構） |
| `slides/` | 選用：投影片（作為講義的輔助來源，不另生成 slide markdown） | —— |
| `homework/` | 各份作業原卷 | `homework/hwXX.md`（一份作業一檔） |
| `exams/` | 歷年考試原卷（**不得含解答**） | 根目錄 `exams.md`（預設單檔） |
| `cases/` | 案例描述（選用：沒有就不建 `cases/`） | `cases/caseXX.md`（一個 case 一檔） |
| `project/` | 期末專案相關原始檔 | **不生成獨立教材**——課務層級資訊併入 `syllabus.md`；其餘列入初始化報告即可 |

## 本示範版的說明

- 本資料夾在示範版中**未隨附原始檔**：潔淨室測試時，原始教材（`w1-math-review.tex`、`w2-prediction-problem.tex`、`w3-regression-trees.tex`、`FA25 Econ 5166 Syllabus.pdf`、`fa25_econ_5166_hw_1-2.pdf`、`Midterm (2024).pdf`、`Prediction Case Discription.pdf`、`期末專案的管理與交付規範.pdf`）由老師另行提供於 `rawcourse/`，基於著作權考量不隨示範套件發布。
- 生成物與原始檔的對應關係見 `INITIALIZATION-REPORT.md` 第 2 節。

## 排除規則（重要）

本 repo 會被學生 clone，以下原始檔**不得放入本資料夾**：

- 任何**含解答**的考卷原卷、答案卷、教師評分 key、case 的參考解答——誠信規則：本 repo 全面不保存受評內容的解答。

## 其他慣例

- 檔名保留原始命名，方便與老師手上的檔案對照；文件中引用一律使用**相對於 repo 根目錄的路徑**（不得出現任何本機絕對路徑）。
- 原始教材若有著作權限制、或考古題全文是否公開給學生，**請老師確認**後再決定發布範圍。
