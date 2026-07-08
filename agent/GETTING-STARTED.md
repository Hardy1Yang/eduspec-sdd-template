# 從零做出這個助教（Getting Started）

> 這是一個**空白助教骨架**。兩條路都能從零做出你的 24h 助教——挑一條。

## 路線 A（推薦）：用 `teach-agent` skill 自動生成

在 Claude Code／Cursor 開這個套件，於 AI 對話打：
```
用「teach-agent」這個 skill，課名：你的課名，授課教師：你的名字，對象：你的學生。
```
它會一步步幫你填好 `AGENT.md`、`knowledge-graph.md`、`.claude/` 指令檔、`README.md` 與 `使用手冊.md`。
（前提：先把講義放進 `course-context/`。）

## 路線 B：手動三步（照 `HOW-TO-FILL.md`）

1. **放講義** → `course-context/`（一單元一檔）。
2. **填 `AGENT.md`** → 換掉 `{{ }}`（課名、口吻、例子、週次）；保留三條規則。
3. **填 `knowledge-graph.md`** → 概念先備依賴＋標主幹。
   並把 `.claude/commands/ta.md`、`.claude/agents/course-ta.md` 的 `{{ }}` 填好。

## 做完怎麼用（指令互動）

把**這個資料夾當 Claude Code 專案打開**：
- `/ta 你的問題` —— 直接問（觀念題答、作業題只給提示、超綱不編造）
- `用 <課程代碼>-ta 子代理回答：…` —— 獨立 context

## 發布給學生

見 `deploy/README.md`。完整功能與驗收見套件的 `USER-MANUAL.md`。
