# 手把手：用 SDD-template 從零生成教材與互動網頁

> 這份把「開套件 → 生投影片／學習單／小考 → 生**互動網頁** → 發布到 github.io → 看全班結果」串成一條龍。
> **完全沒寫過程式？** 先看 [`GETTING-STARTED.md`](GETTING-STARTED.md) 把工具裝好，再回來這裡。
> 貫穿原則：**AI 產草稿、你審學科正確性**。

---

## 0. 準備

- 已裝好 Cursor／Claude Code、有 GitHub 帳號（見 GETTING-STARTED 的 Part 0）。
- 用 Cursor 開**本套件**資料夾（`prototype/`）。
- 把你的講義放進 `course-context/`（一單元一檔）。

> 下面每一步都是「在 Claude Code 對話裡貼一句話」。把粗體換成你的課。每個 skill 都會**先給你一份迷你規格請你確認、再生成、並附一份 `使用手冊.md`**。

---

## 1. 生投影片

```
用「teach-slides」這個 skill，單元：供需均衡，對象：大一新生。
```
**得到**：`slides.md`（每張＝標題＋3 要點＋建議視覺，Marp 可直接投影，或貼 Gamma 美化）。

## 2. 生學習單

```
用「teach-worksheet」這個 skill，單元：供需均衡，對象：大一新生。
```
**得到**：形成性 3 題（每題標「測什麼迷思」）＋一份「給學生版」＋老師審核欄。

## 3. 生小考

```
用「teach-quiz」這個 skill，單元：供需均衡，對象：大一新生。
```
**得到**：依認知層次的題目＋**四級 rubric**（優異/良好/及格/待加強，概念與表達分開）＋人工複核流程。

## 4. 生互動網頁（重點：網路版，可看全班結果）

```
用「teach-sim」我想做一個 供需拉桿 的互動教材給 大一新生。
```
互動教材**是程式**，所以走完整 SDD：它幫你把需求寫成規格 → 你確認 → 產出**單一 HTML 互動網頁**。
本套件**預設網路版**：預期部署到 GitHub Pages，並內建**共享紀錄**——學生的操作可寫回班級 repo，你能**彙整看全班結果**（很適合做賽局遊戲、投票、模擬）。沒設 token 時自動離線、仍可匯出 CSV。

> 想看生成的教材長什麼樣：見 [`example/`](example/)（填好的助教＋一份投影片範例）。

## 5. 發布到 github.io，讓學生用

照 [`PUBLISH-GITHUB-IO.md`](PUBLISH-GITHUB-IO.md)：
1. 建 GitHub repo → 放你的互動網頁檔。
2. Settings → Pages → 選 `main` 分支 → 得到網址 `https://<你的帳號>.github.io/<repo>/...`。
3. 把網址給學生就能玩。

## 6. 看全班結果（賽局遊戲類）

- 在互動網頁的「共享模式」設好班級 repo；學生貼自己的 token（存自己瀏覽器、用代號、不放個資）。
- 學生每次互動會 append 到班級 repo 的 `logs/`；你讀 `logs/` 或匯出即可**看全班分布**。
- 門檻與替代做法（含較低門檻方案）見 `PUBLISH-GITHUB-IO.md` 的 Part D。

## 7. 帶進課堂前，驗收

對照 `templates/acceptance-checklist.md` 逐項打勾。**能跑 ≠ 正確**：互動網頁要**親手操作每個控制項**驗過學科邏輯。
人工驗收學習單／助教的完整做法見 `README.md` 的「人工驗收」段落。

---

## 範例

- [`example/`](example/)：一份**填好的示範**——填好的迷你助教（可用 `/ta`）＋一份生成的投影片，讓你看「做出來長什麼樣」。

> 想做**助教**（不是教材）？用 `teach-agent` skill，見 GETTING-STARTED 的 Part 3。
>
> **其他 skill**（同樣「打一句就生成」）：`teach-context`（從 .tex/PDF/Word 蒸餾講義）、`teach-prereq`（盤點課前先備知識）、`teach-animation`（用 **manim** 做動畫影片，需選裝 manim/ffmpeg，見 [SETUP.md](SETUP.md)）。八個 skill 一覽見 [USER-MANUAL.md](USER-MANUAL.md)。
