# example-full — 真實課程的完整實測範例（輸入 → 一句話 → 產出）

> 這是用**本套件、對一門真實課程**（Econ 5166「Data Science and Social Inquiry」，陳由常老師，已同意作為範例）在乾淨環境實測產生的**全套成品**——你 clone 套件後照著做，得到的就是這些東西。
> 完整步驟見 [`操作走查.md`](操作走查.md)（Step 0→6，標明 👤 人工 vs 🤖 agent 自動）。
> 蒸餾內容為講義**精華摘要**；作業/考題部分**只含題目主題與題型、不含任何解答**。僅供學習套件用法，請勿另作他用。

## 輸入 → 觸發句 → 產出 對照表

| 你給什麼（輸入） | 你說哪句（👤 全部的人工輸入） | 得到什麼（🤖 產出，就在本資料夾） |
|------------------|------------------------------|----------------------------------|
| 一個混合資料夾 `rawcourse/`：3 份講義 .tex ＋ 課綱/作業/考古題/案例/專案規範 PDF | `用「teach-agent」這個 skill，課名：Econ 5166「Data Science and Social Inquiry」，授課教師：陳由常，對象：經濟系研究生，原始教材在：rawcourse/。` | 整個 [`agent/`](agent/)（可發布的學生 repo）：[`AGENT.md`](agent/AGENT.md)（大腦）、[`lecture-notes/`](agent/lecture-notes/)（w01–w03，14 節結構）、根 [`syllabus.md`](agent/syllabus.md)/[`exams.md`](agent/exams.md)、[`homework/`](agent/homework/)＋[`cases/`](agent/cases/)、[`knowledge-graph.md`](agent/knowledge-graph.md)、[`prerequisites.md`](agent/prerequisites.md)、學生版 [`README.md`](agent/README.md)、[`INSTRUCTOR-MANUAL.md`](agent/INSTRUCTOR-MANUAL.md)、[`INITIALIZATION-REPORT.md`](agent/INITIALIZATION-REPORT.md)、`.claude/`＋`.codex/` 雙轉接頭 |
| 指定單元 w2 | `用「teach-slides」這個 skill，單元：…，對象：…。` | [`output/w2-prediction/slides.md`](output/w2-prediction/slides.md)（12 張、鉤子→誤解→金句弧線）＋使用手冊 |
| 同上 | `用「teach-worksheet」…` | [`worksheet.md`](output/w2-prediction/worksheet.md)（3 題情境開場＋迷思註記＋給學生版） |
| 同上 | `用「teach-quiz」…` | [`quiz.md`](output/w2-prediction/quiz.md)（誘答＝迷思診斷、對齊歷年考風、四級 rubric） |
| 同上 | `用「teach-sim」我想做一個 OLS／MSE 的互動教材…` | [`sim-ols.html`](output/w2-prediction/sim-ols.html)（雙擊即玩：拉直線看 MSE、一鍵 OLS）＋ [`sdd-archive/`](sdd-archive/)（完整 SDD 規格歸檔軌跡） |
| 同上 | `用「teach-animation」我想做一個 殘差縮短 的動畫。` | [`output/w2-prediction/animation/`](output/w2-prediction/animation/)（規格＋manim scene＋`ols_residuals.mp4` 22.6 秒成品） |

## 立即體驗

1. **玩互動教材**：雙擊 `output/w2-prediction/sim-ols.html`（離線可用）。
2. **看動畫**：開 `output/w2-prediction/animation/ols_residuals.mp4`。
3. **跟助教講話**：用 Claude Code／Cursor 把 [`agent/`](agent/) 資料夾當專案打開 → `/ta 什麼是最佳預測子？`（Codex：`Use $fa-25-econ-5166-ta-agent to answer: …`）。試試問它作業答案——它只會給提示。
4. **看初始化報告長什麼樣**：讀 [`agent/INITIALIZATION-REPORT.md`](agent/INITIALIZATION-REPORT.md)——所有需要老師人工判斷的事集中在這一份。
5. **看 SDD 長什麼樣**：讀 `sdd-archive/2026-07-10-w2-ols-sim/` 內的 proposal/spec/tasks——互動教材就是照這份規格做出來的。

## 品質保證（實測驗證過）

依賴檢查 exit 0、8/8 檔分類正確、零解答外洩、agent 行為探針全過（概念完整教／作業只給提示且多輪拼不出完整解／課務標「以公告為準」／超綱不編造）、sim 的 OLS 數學經獨立手算驗證、動畫逐幀複驗。細節見 [`操作走查.md`](操作走查.md) 的驗證彙總表。

---

*所有內容為 AI 蒸餾/生成草稿並經測試驗證；實際課堂使用前仍需授課教師人工審核。*
