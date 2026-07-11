# econ-101-ta-agent（填好的示範助教）

**個體經濟學（初級）** 的學生端 24 小時助教（示範用，只載入第一週）。這是把空白骨架 `../../agent/` 填好後的樣子。

## 怎麼用
把**這個資料夾當 Claude Code 專案打開**：
- `/ta 什麼是市場均衡？` — 觀念題會答並引用 `w01 §4.3`
- `/ta 需求 Qd=100−2P、供給 Qs=20+P，幫我算均衡` — **只給第一步與一個引導問題、不給最終數字**（多輪追問也不會拼出完整解）
- `/ta 這門課怎麼評分？` — 課務題以根目錄 `syllabus.md` 為準
- 子代理：`用 econ-101-ta 子代理回答：…`
- **Codex**：`Use $econ-101-ta-agent to answer: 什麼是市場均衡？`（`.codex/` 轉接頭，一樣委派 `AGENT.md`）

## 檔案
`AGENT.md`（大腦）、根 `syllabus.md`（課務）、`lecture-notes/w01-supply-demand.md`（14 節結構）、`knowledge-graph.md`、`INSTRUCTOR-MANUAL.md`＋`INITIALIZATION-REPORT.md`＋`ACCEPTANCE-CHECKLIST.md`（老師端）、`source-materials/`（本例為假想教材，見其 README）、`.claude/`（指令＋子代理）。
本例沒有 `homework/`、`cases/`、`exams.md`——**有原始教材才生成**，沒有就不虛構。

> 這是示範。做你自己的助教見 [`../../GETTING-STARTED.md`](../../GETTING-STARTED.md)。
