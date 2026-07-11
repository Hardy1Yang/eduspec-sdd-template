# 發布到 GitHub Pages（github.io）＋完整使用流程

> 目標：把你做好的**互動工具**與**24h 助教**放上網，讓學生用一個連結免費使用。
> GitHub Pages 是免費的靜態網站託管——你的單檔 HTML 互動模擬，推上去就有一個 `https://<你的帳號>.github.io/<repo>/...` 的網址。

## 全流程一張圖

```
做（SDD 生成教材/助教）
   → 發布（推上 GitHub、開 Pages）
      → 學生使用（開連結玩互動、問助教）
         → 匯出紀錄（老師按「匯出 CSV」看使用情形）
```

---

## Part A — 把互動工具發布到 github.io（5 步）

1. **建 repo**：登入 GitHub → New repository，取名如 `econ-materials`，設 Public。
2. **放檔案**：把你的互動網頁檔放進 repo（範例：`example-full/output/w2-prediction/sim-ols.html`）。
   - 網頁介面：Add file → Upload files → 拖進去 → Commit。
   - 或用指令：`git clone` 你的 repo → 複製檔案進去 → `git add . && git commit -m "add sim" && git push`。
3. **開 Pages**：repo → **Settings → Pages** → Source 選 **Deploy from a branch** → Branch 選 `main`、資料夾選 `/ (root)` → Save。
4. **等 1 分鐘**，回到 Pages 頁會出現網址：`https://<你的帳號>.github.io/econ-materials/`。
5. **測試**：打開 `https://<你的帳號>.github.io/econ-materials/sim-ols.html`，確認拉桿、MSE、匯出 CSV 都正常。

> 互動工具是**單檔、離線可用**的，放上 Pages 只是多一個「線上連結」讓學生免下載直接玩；學生的互動紀錄仍存在**他自己的瀏覽器**（不連網、不含個資）。

## Part B — 把 24h 助教發布給學生

助教是給學生用 coding agent 載入的，走 repo 而非 Pages。見
`agent/deploy/README.md`（GitHub clone ＋ 課前說明）。

## Part C — 學生使用與老師看紀錄

- **學生**：開你的 github.io 連結 → 操作互動模擬（拉桿、求 OLS）。
- **老師**：課堂投影同一個連結；想看使用情形，按互動工具裡的「**匯出 CSV**」下載本機紀錄（時間、動作、參數、MSE）。
- 紀錄**預設只存學生自己的瀏覽器**，不連網、不含個資。

## Part D（選用・進階）— 全班共享紀錄（端到端走查）

> **兩個 repo，務必分開**：一個是**發布網頁的 Pages repo**（public，放 `index.html`），一個是**班級紀錄 repo**（收 `logs/<單元>.csv`）。**不要合成同一個**——GitHub 的 fine-grained token 只能鎖到「整個 repo」、**不能只鎖 `logs/` 資料夾**，所以若紀錄和網頁同一個 repo，那把共享 token 就能改到 `index.html` 本身，任一學生就能把大家正在玩的頁面換成惡意頁面。分開後，共享 token 只授權紀錄 repo，**碰不到發布的程式碼**。

照下面六步做（老師做 ①②③⑥⑦、學生做 ④，⑤ 自動）：

**① 建班級紀錄 repo**（老師，一次性、整學期重用）
GitHub → New repository，取名如 `econ-class-logs`，設 **Private**（紀錄不必公開）。這是與 Pages repo **不同的另一個 repo**。確認：你的帳號下多了一個 `econ-class-logs` repo。

**② 產一把共享 token**（老師）
GitHub → Settings → Developer settings → Personal access tokens → **Fine-grained tokens** → Generate new token → **Repository access** 選 **Only select repositories** 勾 **`econ-class-logs`**（**只有這一個**）→ **Permissions → Repository permissions → Contents** 設 **Read and write** → 產生（`github_pat_` 開頭）。
- 這把是**全班共用一把**：fine-grained token 只能授權你自己有權限的 repo，**學生無法各自產**能寫你 repo 的 token，所以由老師產一把、活動時公布給全班。
- ⚠️ **絕對不要**用「勾滿整個 `repo` scope 的 classic token」或「`gh auth token`（你的全帳號登入 token）」——那被 XSS 竊走就能動你所有 repo。確認：token 的 Repository access 只列 `econ-class-logs` 一個。

**③ 把紀錄 repo 設定進 sim**（老師）
打開 sim 的「共享模式」面板，填 **owner**（你的 GitHub 帳號）、**repo**（`econ-class-logs`）。確認：面板顯示指向該紀錄 repo。

**④ 學生貼 token、開始互動**（學生）
學生在共享面板貼上老師公布的那把共享 token（存自己瀏覽器 localStorage，不上傳第三方），照常玩。

**⑤ 紀錄自動寫回**（自動）
每筆互動經 GitHub API append 到紀錄 repo 的 `logs/<單元>.csv`（暱稱已淨化、防公式注入；token 不進 CSV/URL/畫面——實作規格＝`teach-sim` SKILL §4 四道安全防線）。確認：到 `econ-class-logs` 看 `logs/<單元>.csv`，一列一筆、表頭 `time,nickname,...`、**看不到任何 token**。

**⑥ 老師端彙整看全班結果**（老師）
sim 的「看全班結果」會**再 GET 一次**該 CSV 彙整（分布圖＋統計）；沒開共享或要離線看時，用面板的**離線入口**貼上/載入一份 CSV 也能彙整。確認：畫面出現全班分布與統計。

**⑦ 活動後撤銷**（老師）
GitHub Settings → Tokens **刪掉那把共享 token**（紀錄 repo 留著下次重用）。

> ⚠️ **安全（共享模式必讀）**：紀錄 repo 是**任何持共享 token 的學生都能寫入**的多人可寫來源——等同不可信輸入。惡意暱稱可夾帶 `<img src=x onerror=...>`，在別人開「看全班結果」時竊取其 localStorage 裡的 token。互動工具**渲染共享回來的資料時必須淨化**（textContent／DOM 建構、去角括號、CSV 防公式注入）——`teach-sim` 生成時已內建這四道防線並在驗收清單列有安全探針；老師發布前照該探針測一次。

> ⚠️ 這模式**需要網路與 token、門檻較高**，且要提醒學生 token 保管與個資。**預設關閉**；一般課堂用 Part A + C 的離線 localStorage + 匯出 CSV 就夠了。

---

## 發布前檢查

- [ ] 互動工具在 Pages 網址上實際打開、功能正常。
- [ ] 不含學生個資；紀錄只存本機或（選用）學生自己的 repo。
- [ ] 已揭露「本互動由 AI 協助生成，經授課教師審核」。
- [ ] 若用共享模式，已提醒學生 token 保管與事後刪除。

*機制：GitHub Pages 託管 ＋ GitHub API 紀錄。*
