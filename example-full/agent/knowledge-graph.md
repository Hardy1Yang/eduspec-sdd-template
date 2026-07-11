# Econ 5166「Data Science and Social Inquiry」課程知識圖譜（fa-25 示範版，w1–w3）

> 學生與 TA agent 共用。**箭頭統一 `A → B`＝「A 是理解 B 的先備概念」**，全圖單向、不混用反向。
> 每個概念都連到實際的 lecture note；本圖不重複正式定義與推導——正式內容以 `lecture-notes/` 為準。
> 目前僅涵蓋已載入的 w01–w03；其餘週次載入後續填。**外部先備**（微積分、機率統計、線性代數、程式）不畫進本圖，見 `prerequisites.md`。

## 1. 這份圖怎麼用

- **給學生**：看第 2 節的主幹路徑了解複習順序；卡住時查第 3 節找「該先補什麼」。
- **給 TA agent**：用第 3 節索引路由到正確 lecture note 與節號；判斷先備缺口時**沿箭頭往上游、一次最多回補一個最近的概念**（完整規則見 `AGENT.md` 第五節）；缺的若是外部先備，改走 `prerequisites.md` 的補強路線。

## 2. 主幹學習路徑（最關鍵）

1. **預測主幹**：期望值／條件期望（w01）→ 損失與風險（w02）→ 最佳預測子＝E[y|x]（w02）→ 預測誤差三分解（w02）→ bias–variance 與 CV（w03）
2. **模型主幹**：矩陣符號與線性模型（w01）→ OLS 預測子（w02）→ 迴歸樹作為非線性替代（w03）

## 3. 概念依賴（`A → B`＝A 是 B 的先備）

```
期望值、隨機變數（w01 複習）        → 損失／風險函數（w02）
條件期望 E[y|x]、疊代期望 LIE       → 最佳預測子＝條件期望（w02）
損失／風險函數（w02）               → 最佳預測子＝條件期望（w02）
線性模型與 OLS（w01）、矩陣符號 x^T β（w01） → OLS 作為預測子（w02）
最佳預測子（w02）、變異數 Var(y)（w01 複習） → 預測誤差三分解（w02）
最佳預測子＝條件期望（w02）、遞迴分割 → 迴歸樹＝分段常數的 E[y|x]（w03）
迴歸樹的模型設定（w03）、貪婪法 vs 全域最佳（概念） → CART 演算法（w03）
預測誤差三分解（w02）、期望值／變異數（w01） → bias–variance trade-off（w03）
bias–variance trade-off（w03）、i.i.d. 抽樣（w01） → 交叉驗證選超參數（w03）
過度配適（w03）、風險函數（w02）     → in-sample MSE 的樂觀偏誤（w03）
梯度／偏微分、凸性（外部先備）       → 梯度下降（w01）
共變異數矩陣（w01）、矩陣運算（w01 複習） → 多變量常態（w01）
```

### 路由索引（概念 → 教材位置）

| 核心概念 | 主要教材 |
|---|---|
| 矩陣符號、維度檢查 | `lecture-notes/w01-math-review.md` §3 |
| 內積、範數、距離 | `lecture-notes/w01-math-review.md` §4.1 |
| 實譜定理、SVD | `lecture-notes/w01-math-review.md` §4.2 |
| CDF、常見分配、厚尾 vs 薄尾 | `lecture-notes/w01-math-review.md` §4.3 |
| 多變量常態 | `lecture-notes/w01-math-review.md` §4.4 |
| 獨立性、共變異數、相關 | `lecture-notes/w01-math-review.md` §4.5 |
| OLS 閉合解 | `lecture-notes/w01-math-review.md` §5 |
| 學統計的四步驟、線性模型 | `lecture-notes/w01-math-review.md` §6.1 |
| 梯度下降、學習率 | `lecture-notes/w01-math-review.md` §6.2 |
| 預測問題的設定 | `lecture-notes/w02-prediction-problem.md` §2 |
| 損失函數與風險函數 | `lecture-notes/w02-prediction-problem.md` §3 |
| 最佳預測子＝條件期望、LIE | `lecture-notes/w02-prediction-problem.md` §4.1 |
| 預測誤差三分解 | `lecture-notes/w02-prediction-problem.md` §4.2 |
| OLS 作為預測子、線性假設 | `lecture-notes/w02-prediction-problem.md` §5 |
| 遞迴分割、分段常數 E[y|x] | `lecture-notes/w03-regression-trees.md` §3.1–3.2 |
| 超參數 | `lecture-notes/w03-regression-trees.md` §3.3 |
| bias–variance trade-off、MSE 分解 | `lecture-notes/w03-regression-trees.md` §4 |
| CART 演算法、greedy 性質 | `lecture-notes/w03-regression-trees.md` §5.1 |
| 交叉驗證（LOOCV、K-fold） | `lecture-notes/w03-regression-trees.md` §5.2 |
| in-sample MSE 的樂觀偏誤 | `lecture-notes/w03-regression-trees.md` §6 |

## 4. 沒打好會連環崩盤的主幹節點（老師特別放慢處，標 ⚠）

- **⚠ 條件期望 E[y|x]**：w02「最佳預測子」、w03「樹在估什麼」全都掛在它上面；學生若把樹當成「規則清單」而不是「E[y|x] 的分段常數估計」，之後隨機森林、分類都會歪。
- **⚠ 預測誤差三分解（irreducible／approximation／estimation）**：w03 的 bias–variance trade-off、CV 選模、之後所有「模型複雜度」討論都以它為骨架。
- **⚠ 風險函數（期望損失）**：「用什麼標準比較預測子」是整門課反覆使用的評準；in-sample vs out-sample 的分野也從這裡長出來。

## 5. 外部先備知識（課前應已具備，課內不教）

> 這門課「常提到、卻假設你以前就會」的東西（由 `teach-prereq` 盤點；詳表見 `prerequisites.md`）。
> 注意：w01 是「數學複習」週，**有複習**期望值、矩陣、分配等——下面列的是 w01 也只複習不細教、或完全沒教的 root 節點。
> 助教遇學生卡住時，**先看是不是缺了這裡的外部先備**。

```
微積分（偏微分、梯度、凸性）   → 梯度下降（w01）、OLS 閉式解推導（w01）
期望值／變異數的基本操作       → 風險函數（w02）、bias–variance（w03）
條件期望與疊代期望 LIE         → 最佳預測子（w02）
矩陣代數（轉置、反矩陣、特徵值） → 資料矩陣操作、Spectral／SVD（w01）、OLS 閉式解
機率分配（CDF/pdf、常態）      → w01 分配複習、多變量常態（w01）
i.i.d. 抽樣、母體 vs 樣本      → 抽樣假設（w01）、CV 的合理性（w03）
收斂概念（LLN/CLT、plim）      → 一致性（w01）；w01 只點名不細教
R/Python/Stata 資料操作（課綱要求） → 全部作業與期末專案
```

- **⚠ 最關鍵的外部先備：條件期望（含 LIE）**——w02 最佳預測子、w03 樹的目標函數全靠它。
- **⚠ 次關鍵：矩陣代數**——w01 的 Spectral/SVD、OLS 閉式解、之後 PCA 都用到；特徵值／特徵向量課內只複習、不從頭教。

---

*標 ⚠ 者為主幹；助教遇學生卡在下游概念時，先回頭確認這些主幹是否打好。*
*本圖由 AI 依 w01–w03 講義蒸餾草擬，學科正確性請老師審核。*
