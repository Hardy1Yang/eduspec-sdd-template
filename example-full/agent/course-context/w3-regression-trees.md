> 來源 = Econ 5166「Data Science and Social Inquiry」w3 講義（授課教師：陳由常）
> 助教應據此檔作答，回答時引用對應小節編號；若問題內容在本檔查無相關內容，回覆「講義未提及」，不得編造。

# w3：迴歸樹（Decision Trees for Prediction Problems）

本週主軸：**ML 演算法**＝classification and regression trees (CART)；**一般 ML 技術**＝cross-validation；**核心觀念**＝bias-variance trade-off、hyperparameters。

## 1. 承上週：預測問題＝估計條件平均

- 在 mean squared error (MSE) 風險下，給定 $\bm{x}$ 對 $y$ 的最佳預測是條件平均 $E[y|\bm{x}]$；預測問題本質上就是估計這個條件平均函數。
- 古典統計做法：先指定函數形式 $g(\bm{x}, \bm{\beta})$，例如線性迴歸 $g(\bm{x}, \bm{\beta}) = \bm{x}^T \bm{\beta}$（即 OLS），或非線性模型如 $g(\bm{x}, \bm{\beta}) = \exp(\bm{x}^T \bm{\beta})$（適用於 $y$ 嚴格非負時）。
- 再以最小平方法估計參數：
  $\hat{\bm{\beta}} = \arg\min_{\bm{\beta}\in\mathbb{R}^p} \sum_{i=1}^n [y_i - g(\bm{x}_i, \bm{\beta})]^2$，
  對新觀察值 $\bm{x}_{n+1}$ 預測 $\hat{y}_{n+1} = g(\bm{x}_{n+1}, \hat{\bm{\beta}})$。

## 2. 決策樹是什麼：資料的遞迴分割

- 資料記為 $\mathcal{D}=\{(y_i, x_{i1}, x_{i2}, \ldots, x_{ip})\}_{i=1}^n$。決策樹本質上是對資料集的**遞迴分割（recursive partitioning）**。
- 講義例子（兩層樹）：先依 $x_{i1} > 12$ 分成左右，再分別依 $x_{i1} > 9$、$x_{i2} > 5$ 細分，把樣本切成四個互斥「葉子（leaves）」$\mathcal{D}_1, \mathcal{D}_2, \mathcal{D}_3, \mathcal{D}_4$，且 $\mathcal{D} = \mathcal{D}_1 \cup \mathcal{D}_2 \cup \mathcal{D}_3 \cup \mathcal{D}_4$。
- 幾何直覺：樹把共變數空間切成一塊塊**長方形區域**；每個區域內的預測值就是該區域內 $y_i$ 的平均。例如新觀察值 $\bm{x}_{n+1}$ 落在 $\mathcal{D}_3$，則
  $\hat{y}_{n+1} = \frac{1}{|\mathcal{D}_3|} \sum_{(y_i,\bm{x}_i) \in \mathcal{D}_3} y_i$。

## 3. 決策樹作為條件平均的模型設定

- 可以把決策樹視為條件平均 $E[y|\bm{x}]$ 的一種模型設定：形式為高度非線性、**分段常數（piecewise constant）**。
- 對比：線性迴歸假設全域線性 $E[y|\bm{x}] = \bm{x}^T\bm{\beta}$；決策樹允許 $y$ 與 $\bm{x}$ 的關係在不同區域間突然改變，因此能捕捉線性模型可能遺漏的**非線性與交互作用**。
- 講義強調的 ML 關鍵優勢：古典迴歸要研究者事先「猜」函數形式、選變數與交互項；ML 演算法（如決策樹）則**直接從資料中找出好的模型**——自動搜尋變數與切點，「演算法做了粗重的工作（the algorithm does the heavy lifting）」。
- 交互作用的圖例（講義 Figure，橫軸 Schooling、縱軸 Experience）：$x_{i2}$（Experience）同樣增加 1 單位，一個點留在 $\mathcal{D}_2$、另一個點卻從 $\mathcal{D}_3$ 移到 $\mathcal{D}_4$ ——顯示樹能捕捉共變數之間的交互效果。

## 4. CART 演算法：資料驅動地「長」出一棵樹

- 「Growing a tree, data-drivenly」：不需事先指定樹的結構，演算法以資料為輸入、輸出一棵配適好的樹。
- 常用演算法：**Classification and Regression Trees (CART)**（Breiman et al., 1984）。本週聚焦**迴歸樹**（$y$ 連續）；分類樹（$y$ 類別型）留待之後幾週。
- CART 每一步解：
  $\min\limits_{\substack{j=1,\ldots,p \\ c \in \mathbb{R}}} \Big\{ \sum_{i: x_{ij} \leq c}(y_i - \bar{y}_{L})^2 + \sum_{i: x_{ij} > c}(y_i - \bar{y}_{R})^2 \Big\}$，
  其中 $\bar{y}_{L}, \bar{y}_{R}$ 為左右節點的平均結果。之後對每個節點**遞迴**套用同樣的切割規則，直到滿足停止條件。
- 最常見停止規則：限制樹的**最大深度**。其他停止規則：葉節點最少觀察數、MSE 改善低於門檻、切割不再改善預測等；若不設限，樹可能長到每片葉子只剩一筆觀察值而**過度配適（overfitting）**。另有「剪枝（pruning）」可簡化過度複雜的樹。
- **Greedy（貪婪）性質**：每一步只選當下讓 MSE 下降最多的切割，不考慮對後續切割的影響，因此 CART 是短視的，找到的樹**不一定是全域最適（globally optimal）**；作業中會看到 greedy 演算法找不到最適樹的例子。但 greedy 演算法計算效率高，實務上預測表現通常不錯。
- Remark：找全域最適樹是組合最佳化問題，可能的樹結構數隨深度呈指數成長；近年混整數最佳化（mixed-integer optimization）已可對中等規模問題求全域最適樹（Bertsimas & Dunn, 2017）。
- Remark（學習方法）：學數學要培養「找例子、畫圖」的能力——具體、簡單但有代表性的例子與清楚的視覺化，是建立直覺的關鍵。

## 5. 超參數（Hyperparameters）

- CART 不需指定條件平均的函數形式，但需事先指定**樹的深度**。這種「執行演算法前就要決定、且不從資料中學出來」的參數稱為**超參數（hyperparameter）**。
- 對照：CART 中「學出來」的是切割變數、切點 $c$、各葉節點的條件平均；「事先指定」的是深度。超參數集合依實作而異（例如有些實作以葉節點最少觀察數當停止規則，該數字也是超參數）。

## 6. Bias–Variance Trade-off 與 MSE 分解

- 設定與記號：
  - $(y', \bm{x}')$：新觀察值，觀察到 $\bm{x}'$ 但看不到 $y'$；
  - $\mathcal{D} = \{(y_i, \bm{x}_i)\}_{i=1}^n$：訓練樣本；
  - $g^*(\bm{x}) = E[y|\bm{x}]$：MSE 下最佳預測子；
  - $\hat{g}_{\mathcal{D},h}(\cdot)$：以超參數 $h$（深度）在 $\mathcal{D}$ 上跑 CART 得到的預測子；
  - $\bar{g}_{\mathcal{D},h}(\cdot) = E_{\mathcal{D}}[\hat{g}_{\mathcal{D},h}(\cdot)]$：跨重複訓練樣本的**期望預測子**（理論構念，實務上算不出來）。
  - 延續上週：$(y',\bm{x}')$ 與 $(y_i,\bm{x}_i)$ 為同一母體的 i.i.d. 抽樣（cross-sectional 預測設定）。
- **Proposition（MSE 分解；作業會要求證明）**：
  $\underbrace{E_{\bm{x}', y', \mathcal{D}}[(y' - \hat{g}_{\mathcal{D},h}(\bm{x}'))^2]}_{\text{out-sample MSE}} = \underbrace{E_{\bm{x}',y'}[(y'- g^*(\bm{x}'))^2]}_{\text{irreducible noise}} + \underbrace{E_{\bm{x}'}[(g^*(\bm{x}') - \bar{g}_{\mathcal{D},h}(\bm{x}'))^2]}_{\text{bias}^2} + \underbrace{E_{\bm{x}',\mathcal{D}}[(\bar{g}_{\mathcal{D},h}(\bm{x}') - \hat{g}_{\mathcal{D},h}(\bm{x}'))^2]}_{\text{variance}}$
- 三項意義：
  - **irreducible noise**：來自資料生成過程的隨機性，任何演算法都無法消除；只有增加共變數才可能降低；
  - **bias**：平均預測與真值的距離；
  - **variance**：預測值隨不同訓練樣本波動的程度。
- Remark：此分解對**任何**預測演算法都成立，不限決策樹。
- 以深度 $d$ 表達：$\text{MSE}(d) = \text{Bias}^2(d) + \text{Var}(d) + C$（$C$ 為 irreducible noise，與超參數無關）。
- **Trade-off**：深度 $d$ 增加 → 模型更有彈性、bias 下降；但每片葉子觀察值變少、預測更吵雜 → variance 上升。最佳深度 $d^*$ 是兩股力量平衡的點。深度太小＝**underfitting**（配適不足，抓不到型態）；太大＝**overfitting**（把雜訊當型態學起來）。實務上 bias 與 variance 的實際水準未知，$d^*$ 無法用解析方式算出。

## 7. 用交叉驗證（Cross-Validation）選深度

- Cross-validation 是估計 **out-of-sample MSE** 的簡單而強大的方法：反覆把部分樣本留作 validation data，用其餘資料配適模型，在留出集上評估預測誤差，平均後即為 out-of-sample MSE 的估計。
- **Leave-one-out cross-validation (LOOCV)**：
  1. 對每個 $i \in \{1,\ldots,n\}$：以第 $i$ 筆 $(y_i,\bm{x}_i)$ 當 validation set，用其餘 $n-1$ 筆訓練 $\hat{g}_{-i}(\cdot)$（深度 $d$ 的 CART），算 $e_i = y_i - \hat{g}_{-i}(\bm{x}_i)$；
  2. $LOOCV(d) = \widehat{\text{MSE}}(d) = \frac{1}{n} \sum_{i=1}^n e_i^2$；
  3. 對不同 $d$ 重複，取 $d^* = \arg\min_d CV(d)$。
  - 優點：每次幾乎用全樣本訓練，近似不偏；缺點：要訓練 $n$ 次，計算成本高。
- **$K$-fold cross-validation**：
  1. 隨機把樣本切成 $K$ 個大小約相等的 folds，$K(i)$ 表示觀察值 $i$ 所屬 fold；
  2. 對每個 fold $k$：以 fold $k$ 為 validation set，用其餘 $K-1$ folds 訓練 $\hat{g}_{-k}$，對 fold $k$ 內所有 $i$ 算 $e_i = y_i - \hat{g}_{-k}(\bm{x}_i)$；
  3. $CV(d) = \frac{1}{n}\sum_{i=1}^n e_i^2$；對不同 $d$ 重複並取 $d^* = \arg\min_d CV(d)$。
  - 每筆觀察值恰好當一次 validation、$K-1$ 次 training。$K$ 小（如 $K=2$）省計算但估計較吵；$K$ 大（$K=n$ 即 LOOCV）用較多訓練資料但計算重。實務常用 $K=5$ 或 $K=10$。
- Remark：cross-validation 在 ML 與無母數統計中無所不在，例如：series regression 的多項式階數 $p$、kernel density estimation 的 bandwidth $h$、深度學習的 learning rate 或隱藏層數。它在**監督式學習（supervised learning）**中特別有用，因為觀察得到「ground truth」$y$，可直接用 validation data 評估與挑選模型。

## 8. In-sample MSE 為何不能拿來選模型

- In-sample MSE：$\frac{1}{n}\sum_{i=1}^n (y_i - \hat{g}_{\mathcal{D},h}(\bm{x}_i))^2$，傾向**低估** out-sample MSE。
- 直覺：模型是用同一批資料配適的，對訓練資料的預測平均而言會比對新資料好；參數本來就是挑來最小化 in-sample 誤差，配適度報告因此樂觀偏誤。
- 而且 in-sample MSE 對模型選擇沒有資訊量：它隨模型複雜度增加而**單調下降**，機械性地偏好最複雜的模型，與真實預測表現無關。

---
> 提醒：助教作答時應以本檔為依據並註明引用小節（如「見第 6 節」）；本檔查無的內容一律回覆「講義未提及」，不得自行編造。
