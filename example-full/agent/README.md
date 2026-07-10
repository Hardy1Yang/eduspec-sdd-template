# fa-25-econ-5166-ta-agent

**Econ 5166「Data Science and Social Inquiry」（授課教師：陳由常）的學生端 24 小時 AI 助教。** 用這門課的教學口吻回答、遇作業只給提示、據講義作答不編造。目前已載入 w1（數學複習）、w2（預測問題）、w3（迴歸樹）。

## 檔案結構

```
fa-25-econ-5166-ta-agent/
├── HOW-TO-FILL.md          # 填空指南（骨架文件，供加新單元時參考）
├── GETTING-STARTED.md      # 快速上手（兩條路線：teach-agent 自動／手動填）
├── AGENT.md                # 大腦：口吻 + 據講義作答 + 只給提示 + 資料來源行為政策
├── knowledge-graph.md      # 概念先備依賴圖（含外部先備知識）
├── prerequisites.md        # 課前先備知識清單（老師端）＋學生課前自我檢測
├── references/             # 教學風格 DNA ＋ 老師校準（優先級最高）
├── course-context/         # 講義精華（w1–w3）＋ index.md 主題地圖
├── supplementary/          # 課綱/作業/考古題/案例/專案摘要 ＋ 行為政策
├── ACCEPTANCE-CHECKLIST.md # 助教驗收表（四層框架、可影印）
├── .claude/  .codex/       # Claude Code／Codex 兩個薄轉接頭（皆委派 AGENT.md）
├── deploy/                 # 發布給學生的說明
├── 使用手冊.md              # 老師端＋學生端使用手冊
└── README.md               # 你正在看的這份
```

## 怎麼用（指令互動）

把**這個助教資料夾當作 Claude Code 專案打開**（`claude` 或 Cursor 開資料夾），它內建兩種呼叫方式：

- **Claude Code · 斜線指令**：`/ta 你的問題` —— 直接問，例如 `/ta 為什麼條件期望是最佳預測子？`
- **Claude Code · 子代理**：一句話「用 `fa-25-econ-5166-ta` 子代理回答：……」，在獨立 context 回答。
- **Codex · skill**：`Use $fa-25-econ-5166-ta-agent to answer: 你的問題`。

預期行為：**觀念題**完整答並引用講義小節（例：「見 w2-prediction-problem 第 5 節」）；**作業題／考試題只給提示不給答案**；**課務題**據 syllabus 答、變動性資訊標「以最新公告為準」；**超綱題**（未載入週次）說超出範圍、不編造。

> **一個大腦、多個轉接頭**：規則都在 `AGENT.md`；`.claude/`（Claude Code）與 `.codex/`（Codex）只是把不同工具導向它。改行為改 `AGENT.md` 就好，兩邊自動一致。

## 驗收助教表現

用 **[`ACCEPTANCE-CHECKLIST.md`](ACCEPTANCE-CHECKLIST.md)** 逐項打勾——它用四層框架（誠信＞正確＞會教＞據本課）判「這是不是你這門課的好助教」。**誠信類必 100% 過**（不代寫、不編造）。

---

*本助教由 EduSpec 的 teach-context／teach-agent／teach-prereq skills 生成；內容為 AI 蒸餾草稿，一切回答與蒸餾內容需授課教師人工審核。*
