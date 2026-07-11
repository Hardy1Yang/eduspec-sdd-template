---
id: w02-prediction-problem
title: 第二週：預測問題（Prediction Problems）
week: 2
source_files:
  - w2-prediction-problem.tex
last_updated: 2026-07-11
---

# 第二週：預測問題（Prediction Problems）

## 1. 與前後週的關係

- 本週直接使用第一週複習的期望值、條件期望、線性模型與 OLS：把 OLS 從「量化關係的工具」轉成「預測子」，並用風險函數評估它。
- 與機器學習的連結（後續課程預告）——講義指出：機器學習方法的一大優勢，在於能平衡近似誤差與估計誤差的取捨。透過正則化（regularization）或自適應演算法，機器學習模型能直接從資料中搜尋好的模型設定，有效處理兩種誤差之間的張力。第三週的迴歸樹就是第一個例子。

## 2. 核心問題

- 給定 i.i.d. 樣本 $\mathcal{D}=\{(\bm{x}_i,y_i)\}_{i=1}^n$，目標是建構一個預測子（predictor）$g(\cdot): \mathcal{X} \mapsto \mathcal{Y}$，即把 $\bm{x}$ 映射到 $y$ 的函數。
- 用途：觀察到新的共變數向量 $\bm{x}_{n+1}$（但沒有其結果變數）時，可以形成預測 $\hat{y}_{n+1} = g(\bm{x}_{n+1})$。
- 講義註明：本課程不涵蓋時間序列預測（用過去觀察值預測未來），焦點是橫斷面（cross-sectional）預測，觀察值假設為自同一母體獨立且同分布抽出。

## 3. 正式定義與假設

評估預測子：損失函數與風險函數。

- **損失函數（loss function）** $L(y, \hat{y})$：量化在真值為 $y$ 時預測 $\hat{y}$ 的成本。連續結果變數最常用平方損失（squared loss）：$L(y, \hat{y}) = (y - \hat{y})^2$。
- 損失取決於 $(\bm{x},y)$ 的隨機實現值，因此本身是隨機的。為得到非隨機的績效衡量，定義**風險函數（risk function）**：
  $$R(g) = \mathbf{E}[L(y, g(\bm{x}))],$$
  即把損失對 $(\bm{x},y)$ 的分布取平均。
- 在平方損失下，風險即為**均方誤差（mean squared error, MSE）**：$R(g) = \mathbf{E}\big[(y-g(\bm{x}))^2\big]$。
- 講義 Remark：MSE 雖常用但不一定合適——MSE 是對稱的，高估與低估被視為一樣糟。但現實中成本常不對稱。講義例子：預測下一小時 YouBike 的可借車輛數，若 $(y,\hat{y})=(0,2)$，對使用者的困擾比 $(y,\hat{y})=(9,7)$ 嚴重得多，儘管兩者平方誤差相同。

## 4. 推導與機制

### 4.1 條件期望值是最佳預測子（關鍵定理）

**Proposition 1（Conditional mean is the best predictor）**：在所有可能的函數 $g: \mathcal{X} \rightarrow \mathcal{Y}$ 中，最小化均方誤差
$$\min_{g: \mathcal{X} \rightarrow \mathcal{Y}} \E{(y-g(\bm{x}))^2}$$
的解為 $g^*(\bm{x}) = \mathbf{E}[y|\bm{x}]$。也就是說，在平方損失下，條件平均數是 $Y$ 的最佳預測子。

**Proposition 2（Law of Iterated Expectation，重複期望值法則，又稱 tower property）**：
$$\mathbf{E}[y] = \mathbf{E}\big[\mathbf{E}[y|\bm{x}]\big].$$
講義直覺：這像一條會計恆等式——要算 $Y$ 的整體平均，可以先算各子群體內的 $Y$ 平均，再對子群平均取（加權）平均。例：全體平均身高可以表示為男性平均身高與女性平均身高的加權平均。

**證明架構**（重點步驟）：
1. 暖身：先證 $\mathbf{E}[(y-c)^2]$ 在 $c^* = \mathbf{E}[y]$ 處最小。方法是加減 $\mathbf{E}[y]$ 展開平方，交叉項 $2\mathbf{E}[(y-\mathbf{E}[y])(\mathbf{E}[y]-c)]$ 消失，得 $\mathbf{E}[(y-c)^2] \geq \mathbf{E}[(y-\mathbf{E}[y])^2] = Var(y)$。
2. 主證明結構類似：加減 $\mathbf{E}[y|\bm{x}]$ 展開，再用 Law of Iterated Expectation 證明交叉項為 0，得到分解
   $$\mathbf{E}[(y-g(\bm{x}))^2] = \mathbf{E}\big[(y - \mathbf{E}[y|\bm{x}])^2\big] + \mathbf{E}\big[(\mathbf{E}[y|\bm{x}] - g(\bm{x}))^2\big].$$
   取 $g(\bm{x}) = \mathbf{E}[y|\bm{x}]$ 使第二項為零即達最小。

**三個重要 Remark**：
- 預測問題本質上就是估計迴歸平均（regression mean）：知道條件平均函數，就知道如何做好預測。
- Proposition 1 只適用於平方損失。在其他損失函數下（例如 $L_1$ 損失 $\E{|y-g(\bm{x})|}$），條件平均數**不是**最佳預測子。
- 條件平均雖是最佳預測子，我們仍需從資料中把它估計出來。

### 4.2 模型複雜度的代價：預測誤差三分解

- 迴歸問題的真正挑戰是如何設定（specify）條件平均函數。$\bm{x}$ 是一維或二維時可看散布圖；高維時目視檢查不可行。不斷把模型加複雜有代價：更複雜的模型更難估計，估計誤差可能抵銷預測準確度的潛在增益。
- 設模型 $y = g(\bm{x}, \bm{\beta}_0) + \varepsilon$（$\bm{\beta}_0$ 為真實參數），估計量 $\hat{\bm{\beta}} = \arg\min_{\bm{\beta}\in\mathbb{R}^p} \frac{1}{n}\sum_{i=1}^n [y_i - g(\bm{x}_i, \bm{\beta})]^2$。對新觀察值 $\bm{x}_{n+1}$，預測誤差可分解為：
  $$y_{n+1} - \hat{y}_{n+1} = \underbrace{\big[y_{n+1} - E[y_{n+1}|\bm{x}_{n+1}]\big]}_{\text{irreducible error（不可消除誤差）：最佳預測子的誤差}} + \underbrace{\big[E[y_{n+1}|\bm{x}_{n+1}] - g(\bm{x}_{n+1}, \bm{\beta}_0)\big]}_{\text{approximation error（近似誤差）：模型設定錯誤}} + \underbrace{\big[g(\bm{x}_{n+1}, \bm{\beta}_0) - g(\bm{x}_{n+1}, \hat{\bm{\beta}})\big]}_{\text{estimation error（估計誤差）：有限樣本不確定性}}$$
- 直覺：第一項不可消除（irreducible），是最佳預測子本身的誤差；第二、三項存在取捨（trade-off）——降低近似誤差需要提高模型複雜度，但通常會使估計誤差變大。

## 5. 分析方法、求解步驟與實證策略

### 5.1 以 OLS 迴歸作為預測子

- 預測的核心是找出 $\bm{x}$ 與 $y$ 之間的規律：看到 $\bm{x}$ 時，我們通常會預期 $y$ 是多少。
- 若相信 $y$ 與 $\bm{x}$ 呈線性關係 $y = \bm{x}^T\bm{\beta} + \varepsilon$，可用資料 $\mathcal{D}$ 估計
  $$\hat{\bm{\beta}} = \arg\min_{\bm{\beta}\in\mathbb{R}^p} \frac{1}{n}\sum_{i=1}^n \big(y_i - \bm{x}_i^T\bm{\beta}\big)^2,$$
  得到預測子 $\hat{g}(\bm{x})=\bm{x}^T\hat{\bm{\beta}}$。
- 講義附散布圖示意：以配適直線 $\hat g(\mathbf{x})=\mathbf{x}^T\hat{\boldsymbol{\beta}}$，將新點 $x_{n+1}$ 對應到預測值 $\hat{y}_{n+1}$。

### 5.2 線性假設是否成立？（工資例子）

- 由 Proposition 1，OLS 是好的預測子的條件為：真實條件平均函數是線性的，即存在 $\bm{\beta}\in\mathbb{R}^p$ 使 $E[y|\bm{x}] = \bm{x}^T\bm{\beta}$。是否成立取決於情境。
- 講義例子：用工作經驗年數（$Exp_i$）與受教育年數（$Schooling_i$）預測工資（$Wage_i$）：
  $$Wage_i = \beta_0 + \beta_1 \cdot Exp_i + \beta_2 \cdot Schooling_i + \varepsilon_i.$$
  線性假設下，兩位經驗相同、但 $i'$ 多一年教育的人，$\widehat{Wage}_{i'} - \widehat{Wage}_i = \beta_2$，與 $Exp_i$、$Schooling_i$ 的實際水準無關——每多一年教育，預測工資固定增加 $\beta_2$。
- 這可能過於嚴格：現實中經驗的報酬可能取決於教育程度（教育程度較高者可能從經驗中獲益更多）；教育報酬也可能有邊際遞減。這類交互作用與非線性型態被簡單線性設定排除。
- 自然的延伸是加入非線性項，例如加入 $Exp_i^2$：
  $$Wage_i = \beta_0 + \beta_1 \cdot Exp_i + \beta_2 \cdot Exp_i^2 + \beta_3 \cdot Schooling_i + \varepsilon_i,$$
  但也沒有特別理由相信真實條件平均恰好是 $Exp_i$ 的二次式。

## 6. 課程例子

預測的商業應用。講義列出的例子：

- 需求預測（demand prediction）：供應鏈管理。
- 顧客流失（customer churn）：預測哪些顧客近期可能離開。
- 顧客終身價值（customer lifetime value）：估計新顧客一生會在公司花多少錢。
- 風險評分（risk scoring）：預測貸款或信用卡違約風險。
- 推薦系統（recommender systems）：根據使用者歷史，預測其是否會看某部影片或購買某商品。

大型語言模型（large language model, LLM）也是一種預測演算法：它根據前文預測下一個最可能的字。講義稱：可以說預測是讓資料科學在今日具有影響力的最核心任務。
