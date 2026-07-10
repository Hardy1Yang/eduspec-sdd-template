## Why

w2 講「條件平均是最佳預測子」與 OLS 時，學生常把 OLS 誤解成「畫一條通過最多點的線」或「最小化絕對誤差」，光看投影片很難打破這個直覺。需要一個讓學生**親手調直線、跟 OLS 比賽**的互動教材，讓他們在「怎麼調都贏不了 OLS」的瞬間，體會「最小化 MSE」的意義。

## 教學意圖（依 teaching-dna）

- **要破除／建立哪個直覺**：破除「配適線＝過最多點的線／誤差絕對值最小的線」；建立「OLS＝讓平方誤差的平均（MSE）最小」。
- **發現時刻（aha）**：學生手動調整斜率與截距、想讓 MSE 贏過 OLS——調了幾次發現**怎麼調都贏不了**，才真正懂「argmin MSE」是什麼。
- **螢幕收束**：畫面固定顯示一句「你應該注意到：不管怎麼調，你的 MSE 都不會低於 OLS 的 MSE——OLS 就是這個比賽的必勝解。」

## What Changes

- 新增單一離線 HTML 互動教材 `output/w2-prediction/sim-ols.html`：散布圖（手搖飲店「當日最高溫 vs 日銷量」台灣情境、內建固定資料）＋兩支拉桿（斜率、截距）＋即時 MSE 顯示＋「一鍵 OLS」按鈕。
- 互動紀錄存瀏覽器 localStorage，可匯出 CSV；提供選填 token 欄位（共享模式預留），**沒填 token 一律自動離線、不報錯**。
- 新增 `output/w2-prediction/使用手冊-sim.md`（老師端＋學生端）。

## Capabilities

### New Capabilities

- `ols-sim`: w2 OLS 互動模擬教材的行為規格（散布圖、可調直線、即時 MSE、一鍵 OLS、紀錄與離線退回）。

### Modified Capabilities

（無）

## Impact

- Affected specs: `ols-sim`（新增）
- Affected code:
  - New: output/w2-prediction/sim-ols.html
  - New: output/w2-prediction/使用手冊-sim.md
  - Modified: （無）
  - Removed: （無）
- 無外部相依：不載入任何 CDN／外部字型／外部程式庫，離線可開。
