# {{課程代碼}}-ta-agent（空白骨架）

**這是一個空白的「學生端 24 小時 AI 助教」骨架。** 填入你自己的課程內容，就能得到一個用你的教學口吻回答、遇作業只給提示、據講義作答不編造的助教。

## 怎麼開始

**看 `HOW-TO-FILL.md`**，照三步做：放講義 → 填 `AGENT.md` → 填 `knowledge-graph.md`。

## 檔案結構

```
（你的課）-ta-agent/
├── HOW-TO-FILL.md          # ← 先看這個：填空指南
├── GETTING-STARTED.md      # 快速上手（兩條路線：teach-agent 自動／手動填）
├── AGENT.md                # 大腦：口吻 + 據講義作答 + 只給提示 + 資料來源行為政策
├── knowledge-graph.md      # 概念先備依賴圖（含外部先備知識）
├── references/             # 教學風格 DNA ＋ 老師校準（優先級最高）
├── course-context/         # 放講義精華（助教據此作答）＋ index.md 主題地圖
├── supplementary/          # 講義以外素材（課綱/作業/考古題/案例/專案）＋ 行為政策
├── ACCEPTANCE-CHECKLIST.md # 助教驗收表（四層框架、可影印）
├── .claude/  .codex/       # Claude Code／Codex 兩個薄轉接頭（皆委派 AGENT.md）
├── deploy/                 # 發布給學生的說明
└── README.md               # 你正在看的這份
```

## 怎麼用（指令互動）

填好後，把**這個助教資料夾當作 Claude Code 專案打開**（`claude` 或 Cursor 開資料夾），它內建兩種呼叫方式：

- **Claude Code · 斜線指令**：`/ta 你的問題` —— 直接問，例如 `/ta 這個概念是什麼？`
- **Claude Code · 子代理**：一句話「用 `{{課程代碼}}-ta` 子代理回答：……」，在獨立 context 回答。
- **Codex · skill**：`Use ${{課程代碼}}-ta-agent to answer: 你的問題`。

預期行為：**觀念題**完整答並引用講義小節；**作業題只給提示不給答案**；**超綱題**說超出範圍、不編造。

> **一個大腦、多個轉接頭**：規則都在 `AGENT.md`；`.claude/`（Claude Code）與 `.codex/`（Codex）只是把不同工具導向它。改行為改 `AGENT.md` 就好，兩邊自動一致。

## 驗收助教表現

填好後，用 **[`ACCEPTANCE-CHECKLIST.md`](ACCEPTANCE-CHECKLIST.md)** 逐項打勾——它用四層框架（誠信＞正確＞會教＞據本課）判「這是不是你這門課的好助教」，含驗證說明與可影印表格。**誠信類必 100% 過**（不代寫、不編造）。

## 想看填好的樣子？

參考一個**填好的助教範例**：`../example/agent/`（含填好的 `ACCEPTANCE-CHECKLIST.md`）。

---

*本骨架由 EduSpec 提供；產出的助教一切回答需老師人工審核。*
