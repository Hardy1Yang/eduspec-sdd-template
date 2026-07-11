---
name: teach-agent
description: 課程 TA 初始化技能——老師把原始教材丟進 source-materials/，本 skill 依「有檔案才生成」原則掃描並生成整個學生端 TA（syllabus/lecture-notes/homework/cases/prerequisites/knowledge-graph/學生版 README/AGENT.md），最後集中回報需要人工檢查的檔案（INITIALIZATION-REPORT.md）。要做課程助教時使用。
license: MIT
metadata:
  author: EduSpec
  version: "2.0"
---

# teach-agent — 課程 TA 初始化（檔案偵測式：有檔才生成）

**觸發**：`用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____。`

> **核心規則：有檔案才生成；沒有檔案就略過——不提問、不猜測、不生成示範內容。**
> 不建立課程功能清單、不要老師填 manifest：直接檢查 `source-materials/` 中實際存在的原始教材。
> 逐檔蒸餾的細節規則（高保真、分類表、14 節 lecture schema）見 `skills/teach-context/SKILL.md`——本 skill 是總指揮，teach-context 是蒸餾引擎。

## 0. 準備

1. 把套件內的空白骨架 `agent/` 複製成 `<課程代碼>-ta/`。骨架已含：`AGENT.md`（通用行為規則）、`INSTRUCTOR-MANUAL.md`、`README.md`（學生版模板）、`knowledge-graph.md`／`prerequisites.md` 模板、`ACCEPTANCE-CHECKLIST.md`、`.claude/`＋`.codex/` 轉接頭、`source-materials/` 收件夾。
2. 請老師把**原始教材**丟進 `source-materials/`（子夾：`syllabus`／`lecture-notes`／`slides`／`homework`／`cases`；格式不拘 .tex/PDF/DOCX/MD）。

## 1. 掃描並分類 source-materials

列出實際存在的檔案並分類。**分不出來的列入初始化報告的「未使用或無法分類的原始檔」，不硬塞。**
疑似 **project 教材**（proposal/milestone/期末專案範本…）→ **不生成**、列入報告未處理檔（Project 屬獨立 repo，非本範本範圍）。

## 2. 生成 `syllabus.md`（根目錄）

找到 syllabus 原始檔才生成；課務細節忠實保留，日期/評分比重等變動性資訊標「以最新公告為準」。syllabus 若提到期末專案，**只忠實保留課務資訊**、不建 project 模組。

## 3. 逐單元生成 `lecture-notes/wXX-topic.md`

依 teach-context 的 **14 節統一結構**與高保真規則逐檔蒸餾。有對應 slides 時作**輔助來源**（補課堂順序/例子/圖表強調；不另生 slide md、不逐頁轉錄；**note 與 slides 矛盾時不自行裁決，列入初始化報告**）。

## 4. 逐份生成 `homework/hwXX.md`

每份作業獨立一檔，**frontmatter schema**（id/title/status/assigned_date/due_date/submission_method/total_points/related_weeks/related_topics/source_files/assets/ai_policy/last_updated）＋正文 10 節（作業目的／涵蓋範圍與先備／重要日期與繳交／應繳內容／資料程式附件／**題目**（每題：題目敘述＋評量重點＋相關課程內容）／格式技術要求／評分原則／AI 使用與學術誠信規範／常見行政問題）。
- **完整題幹**（數字、資料、子題、配分）全留；**不存解答、最終數字、完整程式或教師評分 key**。
- **不逐題加「TA 可提供的協助」**（全域協助邊界在 `AGENT.md`）；個別作業自身的 ai_policy 可保留。

## 5. （選用）逐個生成 `cases/caseXX-topic.md`

**只有 `source-materials/cases/` 實際有檔才生成**；沒有就不建 `cases/`、不提問、不生示範。每個 case 獨立一檔，frontmatter（id/title/status/case_type/graded/individual_or_group/assigned_date/due_date/related_weeks/related_topics/source_files/assets/last_updated）＋正文 11 節（情境背景／核心決策問題／學習目標／利害關係人／可用資料／任務與問題／應繳內容／分析面向／相關課程內容／評分原則／格式分組時程）。
**明確不加入**：TA 可提供的協助、AI 誠信規範章節、例行「待老師確認」——這些統一由 `AGENT.md` 控制。

## 6. 生成 `prerequisites.md`＋自動檢測題

照 `skills/teach-prereq/SKILL.md`（必要/建議先備表＋十分鐘快速檢測＋摺疊答案＋補強順序）。

## 7. 生成 `knowledge-graph.md`

雙受眾（學生看全貌與複習順序；TA 用來路由與診斷缺口）。結構：這份圖怎麼用（給學生/給 TA）→課程全貌→核心學習路徑→**核心概念索引表**（核心概念/需要先懂/接下來會用到/主要教材/自我檢查）→卡住時從哪檢查→跨主題連結。
規則：統一 `A → B`＝「A 是理解 B 的先備」，**不得混用反向**；只收核心概念（約 15–40 節點）；每個概念連到實際 lecture note；不重複正式定義與推導。

## 8. 生成學生版 `README.md`

照骨架模板填實（10 節：這是什麼／能幫你做什麼／如何開始／可以怎麼問／正確心態／作業考試與誠信／如何核對回答／課程資料導覽／隱私安全／回報問題）。**只寫學生需要的**；老師操作一律在 `INSTRUCTOR-MANUAL.md`。

## 9. 更新 `AGENT.md` 與轉接頭

填 `{{ }}`（課名/教師/對象/單元清單）——**行為規則骨架已內建，不要改寫**；把 `.claude/`（`/ta` 指令＋子代理）與 `.codex/skills/` 轉接頭改名為課程代碼並填實（皆委派 AGENT.md 完整載入清單）。

## 10. 生成 `INITIALIZATION-REPORT.md`

**不例行加「待老師確認」**：除非原始教材存在**實質**歧義、衝突、缺頁或無法可靠辨識（OCR 讀不出公式數字、note/slides 定義矛盾、同一作業兩個截止日、圖缺軸標、缺頁、附件對不上題目、無法判定先備還是課內教、依賴方向不明、檢測題疑似超綱），否則不要在生成的 md 裡加確認標記。
報告結構：生成摘要／已生成檔案／略過的選用模組／**需要人工檢查的檔案**（每項含：生成檔・原始來源・具體位置・問題原因・AI 採取的處理）／未使用或無法分類的原始檔／原始教材衝突／可能缺少的附件。**沒有問題就明寫「無」。**

## 11. 驗收測試

跑 `ACCEPTANCE-CHECKLIST.md`：誠信（作業一步為限、多輪不得拼答案）／正確／會教（含 KG 診斷路由）／據本課，另加「optional 模組行為」（沒 cases 時不虛構）與「先備互動檢測一次一題」。結果附進初始化報告。

---

規則：
- **有檔案才生成；查無教材的內容不生成、不虛構。**
- 繁體中文台灣用語；數學符號保留原文；exams 原始檔蒸成根目錄 `exams.md` 單檔（規格 §十七#1 未定案下的預設，於報告註明）。
- 受評素材保留完整題幹、僅排除解答——誠信由 `AGENT.md` 行為政策把關。
- 所有產出為 AI 草稿；**需要人工檢查的集中列在初始化報告**，由老師逐項處理後才算完成。
