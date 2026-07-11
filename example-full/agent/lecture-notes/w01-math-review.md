---
id: w01-math-review
title: 第一週：數學複習（Math Review）
week: 1
source_files:
  - w1-math-review.tex
last_updated: 2026-07-11
---

# 第一週：數學複習（Math Review）

## 1. 學習目標

資料科學、計量經濟學與統計學都建立在四個基礎上：

- **線性代數**：用矩陣表示與操作資料
- **機率**：以機率論作為框架，定義研究問題與資料生成過程
- **統計**：用機率論研究方法的統計性質
- **計算**：用有效率的演算法在實務上實作方法

本講義是數學參考資料（refresher 兼 diagnostic tool），學生只需對「其他講義或作業明確提到的內容」負責，不必精通此份講義的全部。

## 2. 與前後週的關係

- 本週複習的期望值、條件期望、線性模型與 OLS，是第二週「預測問題」的直接先備；矩陣符號與維度檢查的習慣貫穿整門課。
- 講義中預告的 LASSO、決策樹（decision trees）、隨機森林（random forests）、交叉驗證等，都是課程後續各週的主題；SVD 是 PCA、降維、推薦系統的數學基礎；梯度下降與數值最佳化會在之後的機器學習方法中反覆出現。

## 3. 重要名詞與符號

- 結構化資料可想成 Excel 試算表：每一列（row）是一個觀察值（observation），每一行（column）是一個變數。observation（單一筆紀錄）與 sample（全部觀察值的集合）不同。
- 資料在數學上就是 $n \times p$ 矩陣 $\bm{X}_{n \times p}$，元素 $x_{ij}$；$n$ = 樣本數、$p$ = 變數個數；$i$ 指觀察值、$j$ 指變數。每個觀察值可寫成 $p \times 1$ 行向量 $\bm{x}_i$，資料矩陣可寫成 $\bm{X} = (\bm{x}_1^T, \ldots, \bm{x}_n^T)^T$。
- **本課程符號慣例**：
  - 矩陣：粗體大寫（$\bm{X}$）
  - 向量：粗體小寫（$\bm{x}_i$），且預設為行向量（column vector）
  - 隨機變數：非粗體大寫（$X$）
  - 純量：非粗體小寫（$x_{ij}$，如隨機變數的實現值）
- 學習訣竅：遇到矩陣或向量務必**檢查維度**（check dimensions），做矩陣乘法前先確認維度相容。
- 矩陣可統一表示多種資料：影像（$x_{ij}$ = 像素 $(i,j)$ 的顏色）、文字（$x_{ij}$ = 文件 $i$ 中字詞 $j$ 的出現次數）、使用者—項目互動（$x_{ij}=1$ 表示使用者 $i$ 與項目 $j$ 互動過，例如看過某部電影）。

## 4. 正式定義與假設

### 4.1 內積、範數與距離

- 迴歸配適值是內積：$\hat{y}_i = \langle \bm{x}_i, \hat{\bm{\beta}} \rangle = \bm{x}_i^{\top}\hat{\bm{\beta}} = \sum_{j=1}^p x_{ij}\hat{\beta}_j$。
- 向量長度（norm）：$\|\bm{x}_i\| = \sqrt{\langle \bm{x}_i, \bm{x}_i \rangle} = \sqrt{\sum_{j=1}^p x_{ij}^2}$。
- 歐幾里得距離：$d(\bm{x}_i, \bm{x}_{i'}) = \|\bm{x}_i - \bm{x}_{i'}\| = \sqrt{\sum_{j=1}^p (x_{ij}-x_{i'j})^2}$。

### 4.2 線性變換與兩大定理

- **線性變換定義**：$f: \mathbb{R}^n \to \mathbb{R}^m$ 是線性變換若 (i) $f(\mathbf{u}+\mathbf{v}) = f(\mathbf{u}) + f(\mathbf{v})$，(ii) $f(c\mathbf{u}) = cf(\mathbf{u})$，$\forall \mathbf{u}, \mathbf{v}, c$。
- 關鍵事實：每個 $\mathbb{R}^n \to \mathbb{R}^m$ 的線性變換都可以用矩陣表示。講義以 $\mathbb{R}^2 \to \mathbb{R}^2$ 的例子說明：90 度順時針旋轉 $\begin{pmatrix}0&1\\-1&0\end{pmatrix}$、縮放 $\begin{pmatrix}c_1&0\\0&c_2\end{pmatrix}$、投影到 x 軸 $\begin{pmatrix}1&0\\0&0\end{pmatrix}$。
- **實譜定理（Real Spectral Theorem）**：$\bm{A}$ 為 $n \times n$ 對稱矩陣，則 $\exists$ $\bm{Q}, \bm{D}$ 使得 $\bm{A} = \bm{QDQ}^T$，其中 $\bm{Q^TQ} = \bm{QQ^T} = \bm{I}$（即 $\bm{Q}^{-1}=\bm{Q}^T$），$\bm{D}$ 為對角矩陣。即對稱矩陣可對角化（diagonalized）。講義例：$\begin{pmatrix}4&2\\2&4\end{pmatrix}$ 的分解。
- **奇異值分解（SVD）**：任意 $m \times n$ 矩陣 $\bm{A}$，存在正交矩陣 $\bm{U}_{m\times m}, \bm{V}_{n \times n}$ 與對角矩陣 $\bm{\Sigma}_{m \times n}$ 使 $\bm{A} = \bm{U\Sigma V}$。$\bm{\Sigma}$ 的對角元素稱為奇異值（singular values）。SVD 是 PCA、降維、推薦系統的數學基礎。
- 課程要求：不必完整證明，但要能**精確陳述**這兩個定理。

### 4.3 機率：CDF 與常見分配

- 機率是描述不確定性的數學語言。頻率學派把機率解讀為長期頻率；貝氏學派解讀為信念程度。機率論在統計/資料科學的三個角色：描述母體、刻畫抽樣過程、分析方法的隨機性質——即描述**資料生成過程（DGP, data-generating process）**。
- **CDF 定義**：$F_X(x) = P(X \leq x)$。CDF 完全刻畫 $X$ 的分配；由 CDF 可導出各事件機率，例如 $P(X > a) = 1 - F_X(a)$、$P(a < X \leq b) = F_X(b) - F_X(a)$。
- **p.m.f. / p.d.f.**：p.m.f. 只存在於離散隨機變數，p.d.f. 只存在於連續隨機變數；CDF 則是普遍的——每個隨機變數都有 CDF。$f(x)$ 是 p.d.f. 若 $P(X \leq x) = \int_{-\infty}^{x} f_X(x)\,dx$。注意 **pdf 不唯一（但 cdf 唯一）**：把 $\mathcal{N}(0,1)$ 的密度在單點 $x=0$ 改成 $10^{10}$ 仍是合法 pdf。
- 講義介紹的分配：Bernoulli（$P(X=1)=p$）、Poisson（$P(X=x) = \frac{e^{-\lambda}\lambda^{x}}{x!}$）、常態、指數（$f_X(x) = \lambda e^{-\lambda x}$, $x \geq 0$）、Pareto（$f_X(x) = \frac{\alpha}{x^{\alpha+1}}$, $x>0$）。
- **厚尾 vs 薄尾**：比較尾端 $f(1), f(10), f(100)$，指數分配 $e^{-x}$ 衰減遠快於 Pareto 的 $\frac{1}{x^2}$。Pareto 是厚尾（heavy-tail）分配：極端大值出現頻率遠高於薄尾（thin-tail）分配。
- 分配會依實體機制自然出現：常態＝身高分配（由中央極限定理 CLT 可解釋）、指數＝燈泡壽命、Pareto＝家戶財富或城市規模。
- 實務提醒：簡單的分配特徵分析就很有價值，例如分析顧客終身價值（CLTV, customer lifetime value）的分配可協助決定合理的獲客成本。

### 4.4 多變量分配與多變量常態

- **聯合 CDF**：$F_{\bm{x}}(x_1, \ldots, x_p) = P(X_1 \leq x_1, \ldots, X_p \leq x_p)$；同理有聯合 p.m.f. / p.d.f.。
- **多變量常態** $\bm{x} \sim \mathcal{N}_p(\bm{\mu},\bm{\Sigma})$：$\bm{\mu}$ 為 $p\times 1$ 均值向量、$\bm{\Sigma}$ 為 $p \times p$ 正定共變異數矩陣（$\sigma_{ij} = Cov(X_i,X_j)$、$\sigma_{ii} = Var(X_i)$；$\bm{\Sigma}$ 必為對稱）。聯合 pdf：$f_{\bm{X}}(\bm{x}) = (2\pi)^{-\frac{p}{2}}\det(\bm{\Sigma})^{-\frac{1}{2}} \exp\left(-\frac{1}{2}(\bm{x}-\bm{\mu})^T \bm{\Sigma}^{-1}(\bm{x}-\bm{\mu})\right)$。
- 特例：$\bm{\Sigma}$ 為對角矩陣時，聯合 pdf 就是各單變量常態 pdf 的乘積。
- 等高線（level curve）直覺：$\Sigma$ 對角時為軸對齊的橢圓；$Cov(X_1,X_2)>0$ 時橢圓往正 45 度傾斜；$Cov(X_1,X_2)<0$ 時往負 45 度傾斜。
- **多變量常態的三個性質**（給定 $\bm{X}\sim \mathcal{N}_p(\bm{\mu},\bm{\Sigma})$）：
  1. 若 $Cov(X_i,X_j)=0$ 則 $X_i \perp X_j$（零相關 ⟹ 獨立是多變量常態特有性質，一般分配不成立）。
  2. 線性變換仍為常態：$\bm{AX+B}\sim\mathcal{N}_k(\bm{A\mu+B},\bm{A\Sigma A'})$。前兩部分（均值、共變異數）任何分配都成立，「仍為多變量常態」才是獨有的。
  3. 條件分配 $X_1\mid X_2,\dots,X_p$ 也是常態。
- 反例：邊際皆常態不代表聯合常態。取 $W, Z$ 獨立標準常態，$X = W$、$Y = sgn(W)\cdot |Z|$，則 $X, Y$ 各自常態但 $(X,Y)$ 非聯合常態。

### 4.5 獨立性、共變異數與相關

- 常見關係量：共變異數 $\text{Cov}(X,Y)$、條件期望 $E[Y \mid X]$（如身高多 1 公分平均多重多少）、條件變異數 $\text{Var}(Y \mid X)$（如今日股市波動高，明日是否也高）。
- **獨立定義**：$P(X \in E, Y \in F) = P(X \in E)P(Y \in F)$ 對所有事件 $E, F$。等價直覺：$P(X \in E \mid Y \in F) = P(X \in E)$——知道 $Y$ 對 $X$ 毫無資訊。
- 社會科學中兩變數真正獨立很罕見（如所得與教育幾乎不可能獨立）。獨立假設最常見的用途是**建模抽樣過程**：除時間序列外，通常假設觀察值之間獨立——$i \neq i'$ 時 $X_{ij}$ 與 $X_{i'j'}$ 獨立。
- **共變異數定義**：$\text{Cov}(X, Y) = E[(X - E[X])(Y - E[Y])]$；**相關係數**：$\text{Corr}(X,Y) = \frac{\text{Cov}(X,Y)}{\sqrt{\text{Var}(X)\text{Var}(Y)}}$。
- 正相關的白話意義：$X$ 高於其期望 $E[X]$ 時，$Y$ 也傾向高於 $E[Y]$，兩者偏離期望的方向一致。
- 共變異數只捕捉**線性相依**：若 $Y = aX + b$（$a \neq 0$），則 $a>0$ 時 $\text{Corr}(X,Y)=1$、$a<0$ 時 $=-1$。但非線性相依可以有零相關——強相關的非線性關係仍可能 $Cov = 0$。
- 「相關不代表因果」，但相關仍非常有用，五大用途：(1) 產生假說（建議用 pair plot：對角線放各變數的直方圖/核密度、非對角放兩兩散布圖）、(2) 風險對沖（兩支報酬 $R_1, R_2$ 負相關的股票，分散投資組合 $\tilde{R} = \tfrac{1}{2}R_1 + \tfrac{1}{2}R_2$ 可在相同期望報酬 $r$ 下降低變異數）、(3) 預測（預測本質上利用相關，如昨天下雨預測今天下雨；推薦系統的 item-to-item 與 user-to-user 推薦）、(4) 降維、(5) 發掘隱藏結構。

## 5. 推導與機制

- 迴歸係數定義為最小化平方誤差和：$\hat{\bm{\beta}} = \arg\min_{\bm{\beta}} \|\bm{y} - \bm{X}\bm{\beta}\|^2$，有閉合解（closed-form solution）$\hat{\bm{\beta}} = (\bm{X}^\top \bm{X})^{-1}\bm{X}^\top \bm{y}$。閉合解就像有公式可以直接代入計算；若無公式，則需靠演算法逐步逼近。

## 6. 分析方法、求解步驟與實證策略

### 6.1 學統計的方法：以線性迴歸為例

統計的核心：在無法取得整個母體時，用樣本推論母體（from the part to the whole）。學任何統計方法的**四步驟**：
1. 理解目標與動機
2. 嚴謹定義方法
3. 在資料假設下研究理論性質
4. 用真實資料練習應用

- **動機**：迴歸描述 $\bm{x}\rightarrow y$ 的水準關係與 $\Delta \bm{x} \rightarrow \Delta y$ 的差異關係。經濟學的例子：性別如何影響工資、出生地如何影響教育程度、產假是否影響女性勞動參與。
- **線性模型**：$y_i = \bm{x}_i^\top \bm{\beta} + \varepsilon_i$，其中 $\varepsilon_i$ 代表未觀察到但影響 $y$ 的因素（能力、動機、偏好等），經濟學稱為**未觀察異質性（unobserved heterogeneity）**——講義提醒稱其為「error term」會低估其重要性。線性假設很強（假設關聯對所有人、所有 $x_j$ 值都固定），應視為有用的簡化而非現實的精確描述；這也是使用機器學習等彈性方法的動機。
- 知道 $\bm{\beta}$ 的兩個用途：**量化**（$\hat{\beta}_j$ 是其他變數固定下，$x_j$ 差一單位時 $y$ 的平均差異）與**預測**（$\hat{y}_{n+1} = \bm{x}_{n+1}^\top \hat{\bm{\beta}}$）。
- **OLS 定義**：$\hat{\bm{\beta}} = \operatorname{argmin}_{\bm{\beta} \in \mathbb{R}^p} \frac{1}{n} \sum_{i=1}^n (y_i - \bm{x}_i^\top \bm{\beta})^2$，閉合解 $\hat{\bm{\beta}} = (\bm{X}^\top \bm{X})^{-1}\bm{X}^\top \bm{y}$（迴歸預設含截距，係數向量為 $p+1$ 維）。要區分模型參數 $\bm{\beta}$ 與估計量：OLS 只是估計 $\bm{\beta}$ 的一種方式（也可用 GLS 等）。
- **演算法觀點**：統計程序可視為演算法——輸入資料 $\{(y_i,\bm{x}_i)\}_{i=1}^n$（維度 $n \times (p+1)$）、輸出低維摘要 $\hat{\bm{\beta}}$（維度 $p+1$）。但統計觀點要求同時記住演算法形式與背後的機率框架。
- **假設的兩大類**：
  1. 對母體的假設：如參數模型 $(y,\bm{x}) \sim \mathcal{N}(\bm{\mu}, \bm{\Sigma})$，或較弱的動差條件 $E[y_i] < \infty$、$E[x_ix_i^T] < \infty$。取捨（trade-off）：假設越強結論越強（如常態下的精確有限樣本分配），假設越弱適用越廣但結論較弱（如只有一致性）。
  2. 對抽樣過程的假設：最常見是隨機樣本 $(y_i, \bm{x}_i) \overset{\text{i.i.d.}}{\sim} F_{y, \bm{x}}(\cdot)$；i.i.d. 適合橫斷面資料，時間序列資料相依，需改用平穩性等較弱條件。
- **理論性質**：不偏性（unbiasedness，$\mathbb{E}[\hat{\bm{\beta}}] = \bm{\beta}$）與一致性（consistency，$\hat{\bm{\beta}} \xrightarrow{p} \bm{\beta}$ as $n \to \infty$）。這些性質取決於假設，討論時必須講清楚在什麼假設下成立。
- 本課程較不強調嚴格證明（現代方法常需 VC dimension 等博士級工具），但會用偏誤、變異數、條件期望等概念建立直覺。每個主題都會配一個案例研究（case study），因為實務上還需要：把研究/商業問題轉成資料問題、對非技術受眾溝通結果、辨識資料限制（缺漏、測量誤差、樣本選擇）。

### 6.2 計算與梯度下降

- 現代機器學習與古典統計的關鍵差異之一是**模型複雜度**：OLS 可能只有十幾個參數；核方法、隨機森林隱含上千自由度；深度學習可達數百萬甚至數十億參數。訓練這些模型是大規模（常為非凸）最佳化問題。OLS 有閉合解，多數現代方法必須用迭代數值演算法（如梯度下降）。
- 例子：**LASSO**（least absolute shrinkage and selection operator）$\min_{\alpha, \bm{\beta}} \sum_{i=1}^n (y_i - \alpha - \bm{x}_i^\top \bm{\beta})^2 + \lambda \sum_{j=1}^p |\beta_j|$，懲罰項促使係數稀疏，一般無閉合解。
- **梯度**：$f:\mathbb{R}^p\to\mathbb{R}$ 可微，$\nabla f = (f_{x_1}, \ldots, f_{x_p})^T$，是最陡上升方向。
- **梯度下降更新式**：$x^{(k+1)} = x^{(k)} - \gamma^{(k)}\nabla f(x^{(k)})$，$\gamma^{(k)}$ 是學習率（learning rate）、$x^{(0)}$ 由研究者選定初始點。方向：$\nabla f>0$ 往左、$\nabla f<0$ 往右；步長與陡峭度 $\nabla f$ 及學習率成比例。
- **學習率選擇**：$\gamma^{(k)}$ 太大可能不收斂（跳來跳去）、太小則收斂太慢。方法：
  - **Newton's Method**：$\gamma^{(k)} = (\nabla^2 f(x^{(k)}))^{-1}$（反 Hessian）；Hessian 是梯度的變化率，Hessian 大時選較小（保守）的步長。
  - **Line search**：每次迭代選 $\gamma_k$ 最佳化 $f(x_k - \gamma_k\nabla f(x_k))$。
- **兩類調參（tuning parameters）要區分**：(1) 數值最佳化的調參（如學習率）——選擇常視個案而定；(2) 模型設定的調參（如懲罰項 $\lambda$、決策樹深度）——通常可以系統性方式選擇。
- **「天真」梯度下降的潛在問題**：非嚴格凸（non-strict convex）時會卡在局部極小或平坦處（Stuck）；等高線狹長時會鋸齒前進（zig-zagging）。
- 重要變體：加速梯度下降、L-BFGS（Limited-memory Broyden–Fletcher–Goldfarb–Shanno）、隨機梯度下降（SGD）。L-BFGS 與 SGD 廣用於 SVM、迴歸樹、神經網路。許多機器學習的近期突破源於最佳化方法的進步。

## 7. 常見誤解

- 初學者常以為越複雜的技術越強大；實務上檢視變數分配的簡單特徵就常有價值。

## 8. 本週重點整理

講義中的學習方法提醒：

- 遇到新定義或定理，務必：(1) 用白話翻譯定義，(2) 動手做簡單具體的例子——具體例子能建立直覺。
- 練習第一原理思考（first-principle thinking）：例如自己驗證旋轉、縮放、投影確實符合線性變換定義。
