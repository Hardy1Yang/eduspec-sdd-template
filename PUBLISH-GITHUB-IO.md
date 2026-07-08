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
2. **放檔案**：把你的 `sim-ols-mse.html`（或整個 `course/examples/...` 資料夾）放進 repo。
   - 網頁介面：Add file → Upload files → 拖進去 → Commit。
   - 或用指令：`git clone` 你的 repo → 複製檔案進去 → `git add . && git commit -m "add sim" && git push`。
3. **開 Pages**：repo → **Settings → Pages** → Source 選 **Deploy from a branch** → Branch 選 `main`、資料夾選 `/ (root)` → Save。
4. **等 1 分鐘**，回到 Pages 頁會出現網址：`https://<你的帳號>.github.io/econ-materials/`。
5. **測試**：打開 `https://<你的帳號>.github.io/econ-materials/sim-ols-mse.html`，確認拉桿、MSE、匯出 CSV 都正常。

> 互動工具是**單檔、離線可用**的，放上 Pages 只是多一個「線上連結」讓學生免下載直接玩；學生的互動紀錄仍存在**他自己的瀏覽器**（不連網、不含個資）。

## Part B — 把 24h 助教發布給學生

助教是給學生用 coding agent 載入的，走 repo 而非 Pages。見
`agent/deploy/README.md`（GitHub clone ＋ 課前說明）。

## Part C — 學生使用與老師看紀錄

- **學生**：開你的 github.io 連結 → 操作互動模擬（拉桿、求 OLS）。
- **老師**：課堂投影同一個連結；想看使用情形，按互動工具裡的「**匯出 CSV**」下載本機紀錄（時間、動作、參數、MSE）。
- 紀錄**預設只存學生自己的瀏覽器**，不連網、不含個資。

## Part D（選用・進階）— 全班共享紀錄（仿 hokkaido）

若要把全班的互動集中成一份共享紀錄（像 hokkaido 記帳 App 那樣寫回 GitHub）：

1. 每位學生到 **GitHub → Settings → Developer settings → Personal access tokens (classic)**，產生一個勾選 `repo` 的 token（`ghp_` 開頭）。
2. token **只貼在自己的瀏覽器**（存 localStorage，不上傳任何第三方）。
3. 互動工具在啟用 GitHub 共享模式時，透過 GitHub API 把每筆紀錄 append 到 repo 的一個 log 檔（實作骨架見 `sim-ols-mse.html` 檔尾 `<optional GitHub 共享>` 註解）。
4. 學期/活動結束後，到 GitHub Settings → Tokens **刪除 token**。

> ⚠️ 這模式**需要網路與 token、門檻較高**，且要提醒學生 token 保管與個資。**預設關閉**；一般課堂用 Part A + C 的離線 localStorage + 匯出 CSV 就夠了。

---

## 發布前檢查

- [ ] 互動工具在 Pages 網址上實際打開、功能正常。
- [ ] 不含學生個資；紀錄只存本機或（選用）學生自己的 repo。
- [ ] 已揭露「本互動由 AI 協助生成，經授課教師審核」。
- [ ] 若用共享模式，已提醒學生 token 保管與事後刪除。

*來源精神：`hokkaido 記帳 App`（GitHub Pages ＋ GitHub API 記錄）。*
