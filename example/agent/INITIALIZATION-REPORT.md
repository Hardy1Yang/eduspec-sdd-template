# Initialization Report（示範）

> 這是初始化技能「集中檢查回報」的**填好示範**（econ-101 假想情境）。空白模板見骨架 `../../agent/INITIALIZATION-REPORT.md`。
> 重點示範：①生成清單怎麼列；②原始教材只有講義（＋課綱）時，只生成對應檔案、其餘模組明列「略過」；③沒有問題的節**明確寫「無」**，不例行請老師確認。

## 1. 生成摘要

掃描 `source-materials/`（本示範為假想教材）：找到課綱一份、第一週講義一份。據此生成根 `syllabus.md` 與 `lecture-notes/w01-supply-demand.md`（14 節結構，無實質內容的節省略並重新編號），並建立 `knowledge-graph.md`、填實 `AGENT.md` 與學生版 `README.md`。無作業、考古題、case 的原始檔，對應模組一律未生成。

## 2. 已生成檔案

| 檔案 | 來源 |
|------|------|
| `syllabus.md` | source-materials/syllabus（假想課綱） |
| `lecture-notes/w01-supply-demand.md` | source-materials/lecture-notes/w1-supply-demand（假想講義） |
| `knowledge-graph.md` | 由 w01 講義概念整理 |
| `AGENT.md`、`README.md` | 骨架模板填實 |

## 3. 略過的選用模組

- `source-materials/` 無作業原始檔 → 未建立 `homework/`。
- 無考古題原始檔 → 未生成 `exams.md`。
- 無 case 原始檔 → 未建立 `cases/`。
- 只有一週講義、課綱未明列先備 → 未生成 `prerequisites.md`。

## 4. 需要人工檢查的檔案

**無。**

## 5. 未使用或無法分類的原始檔

無。

## 6. 原始教材衝突

無。

## 7. 可能缺少的附件

無。
