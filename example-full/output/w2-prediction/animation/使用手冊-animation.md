# 使用手冊 — w2 動畫「殘差如何縮小：直線轉向 OLS」

> 本動畫由 AI 協助生成，經授課教師審核。資料為教學用虛構數據（與 sim-ols.html 相同）。

## 老師端

### 如何 render（重跑）
- 一鍵：`./render.sh`（預覽畫質）；`./render.sh -qm` 中畫質、`./render.sh -qh` 高畫質。
- 腳本會先檢查 manim／ffmpeg 是否已裝（未裝見套件 `SETUP.md`），render 後自動加 `+faststart` 並抽封面圖。
- 產出：`ols_residuals.mp4`（約 22.6 秒）＋ `ols_residuals_cover.png`。

### 如何播放與發布
- 課堂直接投影播放 mp4，或嵌入投影片（slides.md 第 5–6 張之間播放效果最佳）。
- 發布：上傳 NTU COOL，或放進 GitHub Pages repo 供學生連結觀看。
- 修改動畫內容：編輯 `ols_residuals.py`（分四幕，對照 `spec.md`），改完重跑 `./render.sh`，**親手看過**方向與標籤再使用。

## 學生端

- 直接觀看 mp4；看的時候注意兩件事：**橘色殘差線段如何縮短**、**MSE 數字如何一路下降到 30.94**。
- 看完可開互動網頁 `sim-ols.html` 自己拉拉看，驗證「怎麼調都贏不了 OLS」。
