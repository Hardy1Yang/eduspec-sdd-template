# 課堂指令表（照這張抄）

> 工作坊當天用這一頁就夠：**每個框都可以整段複製 → 貼上 → 只改 `____` 或 `<角括號>` 的部分 → 執行**。
> 貼哪裡？打指令的貼**終端機**（VS Code 下方，`Ctrl`+反引號叫出）；講中文的觸發句貼 **AI 對話框**（右側 extension 面板）。分不清楚看最下面的「介面速查」。

---

## 0. 環境檢查（二選一，看你的電腦）

**Mac**（貼終端機）：

```bash
bash scripts/setup-check.sh --essential
```

**Windows**（貼終端機）：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-check.ps1 -Essential
```

看到「全部必要項就緒」就過關；有 ✗ 就舉手找助教。

---

## 1. 在桌面建教材資料夾 `rawcourse`

最簡單：到**桌面**按右鍵 → 新增資料夾 → 命名 `rawcourse` → 把**前三週**的課綱/講義/作業/考題檔案拖進去（.tex/PDF/Word/MD 都可以，**不要放解答**）。

用指令建也行——**Mac**（貼終端機）：

```bash
mkdir -p ~/Desktop/rawcourse
```

**Windows**（貼終端機）：

```powershell
mkdir "$env:USERPROFILE\Desktop\rawcourse"
```

---

## 2. 生成你的 24 小時助教（今天的主事件）

貼 **AI 對話框**（模型先切到 **light 或 medium**），填四個空：

```
用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____，原始教材在：<資料夾>。
```

（`<資料夾>` 填你桌面 `rawcourse` 的完整路徑。）

> 路徑怎麼拿？在檔案總管/Finder 對 `rawcourse` 按右鍵複製路徑；Mac 通常是 `/Users/你的名字/Desktop/rawcourse`，Windows 是 `C:\Users\你的名字\Desktop\rawcourse`。
> 按下去會跑十幾到二十幾分鐘——正常。讓它跑，去休息，回來先看 `INITIALIZATION-REPORT.md` 第 0 節。

---

## 3. 問你的助教

用 VS Code **Open Folder 開啟生成的 `<課程代碼>-ta/` 資料夾**（不是上層），然後貼 AI 對話框：

```
/ta 這一週的重點概念是什麼？
```

（把問題換成你要問的。）**用 Codex 的話**改貼：

```
Use $<你的課程代碼>-ta-agent to answer: 你的問題
```

---

## 4. 生成教材（四選一，貼 AI 對話框）

```
用「teach-slides」這個 skill，單元：____，對象：____。
```

```
用「teach-worksheet」這個 skill，單元：____，對象：____。
```

```
用「teach-quiz」這個 skill，單元：____，對象：____。
```

```
用「teach-sim」這個 skill，我想做一個 ____ 的互動教材給 ____。
```

（進階·做動畫影片用，需選裝 manim/ffmpeg——跟 AI 說要裝它會幫你裝：）

```
用「teach-animation」這個 skill，我想做一個 ____ 的動畫。
```

> 它會先給一份標「待審核」的迷你規格再生成——看到不對，回一句「改：____」就好。
> 投影片產出是 Marp Markdown：**看效果首選匯出 PDF**（手冊有寫），或裝 Marp 預覽擴充。

---

## 5. 把助教打包給學生（zip，不用 git）

在助教資料夾的**上一層**貼終端機（把兩處 `課程代碼-ta` 換成你的資料夾名）：

```bash
zip -r 課程代碼-ta.zip 課程代碼-ta -x "課程代碼-ta/source-materials/*" -x "課程代碼-ta/.git/*"
```

上傳 zip 到課程平台。學生：裝 VS Code＋AI extension → Open Folder → `/ta` 提問。

---

## 6.（選用/課後）發布到 GitHub

> Mac 第一次用 git 會要求裝 Xcode command line tools（要密碼、數分鐘）；趕時間先用上面的 zip。

貼 AI 對話框（在助教資料夾視窗）：

```
照 INSTRUCTOR-MANUAL.md 第 12 節方式 B，把這個資料夾發布成 private GitHub repo，source-materials/ 不要推上去。
```

---

## 介面速查（第一次用 extension 看這裡）

| 你想做 | 去哪裡 |
|---|---|
| 打指令（`bash…`、`zip…`） | **終端機**：VS Code 下方，`Ctrl`+反引號（Esc 下面那顆）叫出 |
| 跟 AI 說話（觸發句、`/ta`） | **AI 對話框**：右側 extension 面板，點 Claude／Codex 圖示開啟，字打在最下面的輸入框，Enter 送出 |
| 它跳出「要不要允許」 | 按**允許（Allow）**——它是在問你能不能動檔案，課堂操作都可以允許 |
| 看它是不是在跑 | 對話框會**持續冒出文字／轉圈**；停了且出現完整回答＝跑完了 |
| 換模型（省額度） | 對話框輸入框旁的**模型選單**→ 選 light 或 medium |
| 想重來 | 開**新對話**（對話框上方的 ＋ 或 New Chat）再貼一次 |
| 引用某個檔案 | 輸入框打 `@` 選檔案，或直接把路徑貼進句子裡 |
