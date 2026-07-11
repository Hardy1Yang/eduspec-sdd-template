# Econ 5166「Data Science and Social Inquiry」——24 小時 AI 助教（範例，涵蓋 w1–w3）

這是 Econ 5166（授課教師：陳由常）的 AI 助教：用這門課的講義與老師的說法回答你的問題，**全天候、免費**。本範例載入 w1–w3（數學回顧、預測/OLS、迴歸樹）與課綱/作業/考古題脈絡。

## 三步開始用

1. **裝一個 coding agent**（擇一）：[Claude Code](https://code.claude.com/docs) 或 Codex，用你的帳號登入。
2. **下載本資料夾**：`git clone <repo 網址>`（或 Download ZIP）。
3. **用 coding agent 打開這個資料夾**，直接發問（見下）。

## 怎麼問

- **Claude Code**：打 `/ta 你的問題`（例：`/ta 什麼是最佳預測子？`）；或說「用 `fa-25-econ-5166-ta` 子代理回答：…」。
- **Codex**：打 `Use $fa-25-econ-5166-ta-agent to answer: 你的問題`。

## 它會怎麼回答（請先知道）

- **觀念題**：完整教學（直覺→機制→陷阱→一句重點），並引講義小節。
- **作業／考題**：講得清楚題目在問什麼，但**只給提示、不給答案**——刻意設計。
- **課務**：據課綱回答，變動資訊以最新公告為準。
- **課程沒教的**（含 w4 之後）：直說「尚未載入／超出範圍」，不會亂編。

## 使用須知（誠信與免責）

- AI 可能講錯——**交出去的內容視同你自己確認、自己負責**。
- 作業使用 AI 請依老師的**綠／黃／紅燈**規範，誠實揭露。
- 本助教由 AI 協助建置、經審核流程驗證；學科正確性最終以老師與講義為準。

---

## 給老師（學生可略過）

- 本檔是 **example-full 的展示助教**——由潔淨室測試以 `teach-context`＋`teach-agent` 從真實 fa-25 素材建出（過程見 [`../操作走查.md`](../操作走查.md)）。
- 維護與更新見 `deploy/README.md`；驗收見 `ACCEPTANCE-CHECKLIST.md`；架構＝一個大腦 `AGENT.md`＋雙轉接頭（`.claude/`＋`.codex/`）；講義在 `course-context/`、講義以外素材在 `supplementary/`；`HOW-TO-FILL.md`／`GETTING-STARTED.md` 為骨架指南原樣保留供對照。
