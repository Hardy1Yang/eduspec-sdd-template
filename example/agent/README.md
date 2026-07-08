# econ-101-ta-agent（填好的示範助教）

**個體經濟學（初級）** 的學生端 24 小時助教（示範用，只載入第一週）。這是把空白骨架 `../../agent/` 填好後的樣子。

## 怎麼用
把**這個資料夾當 Claude Code 專案打開**：
- `/ta 什麼是市場均衡？` — 觀念題會答並引用 `w1 §1.3`
- `/ta 需求 Qd=100−2P、供給 Qs=20+P，幫我算均衡` — **只給提示、不給最終數字**
- 子代理：`用 econ-101-ta 子代理回答：…`
- **Codex**：`Use $econ-101-ta-agent to answer: 什麼是市場均衡？`（`.codex/` 轉接頭，一樣委派 `AGENT.md`）

## 檔案
`AGENT.md`（大腦）、`knowledge-graph.md`、`course-context/w1-supply-demand.md`、`.claude/`（指令＋子代理）。

> 這是示範。做你自己的助教見 [`../../GETTING-STARTED.md`](../../GETTING-STARTED.md)。
