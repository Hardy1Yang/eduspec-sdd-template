# 使用手冊 — w2 投影片（slides.md）

> 本投影片由 AI 協助生成，經授課教師審核後使用。

## 老師端

### 如何生成／重生成
1. 在套件根目錄開 Claude Code，貼：`用「teach-slides」這個 skill，單元：w2 預測問題與 OLS，對象：Econ 5166 修課生。`
2. 先確認迷你規格（`slides-mini-spec.md`），再讓 AI 產出；產出存 `output/w2-prediction/slides.md`。
3. **人工審核**：對照迷你規格驗收清單逐項打勾，特別檢查標了「請老師確認」的地方。

### 如何在課堂投影
- 檔案為 **Marp 相容 Markdown**。三種投影方式：
  - VS Code／Cursor 裝 Marp 外掛，開啟即可預覽與匯出 PDF。
  - 命令列：`npx @marp-team/marp-cli slides.md -o slides.pdf`（需 Node.js）。
  - 或把內容貼進 Gamma 等工具美化。
- 第 7 張建議搭配本單元互動網頁 `sim-ols.html` 現場示範。

### 如何發布
- 匯出 PDF 上傳課程平台（NTU COOL 等）；或放進 GitHub Pages repo（見 `PUBLISH-GITHUB-IO.md`）。

## 學生端

- 若發布為 PDF：直接下載閱讀；每張投影片末的「建議視覺」是老師備課註記，可忽略。
- 建議搭配 w2 講義與互動網頁 `sim-ols.html` 複習：先看地圖張與金句張，再回頭補中間推導。
