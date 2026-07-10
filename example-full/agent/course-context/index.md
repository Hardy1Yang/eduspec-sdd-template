# course-context 索引（主題地圖 + 查詢流程）

> 助教先看這張地圖挑對單元，再據該單元的講義檔作答。填你自己的課。

## 主題地圖（Econ 5166，已載入 w1–w3）

| 單元檔 | 一句話主題 | 主幹？ |
|--------|-----------|--------|
| `w1-math-review.md` | 數學複習：資料矩陣與線性代數（Spectral、SVD）、機率分配、多變量常態、共變異數與相關、線性模型與 OLS、梯度下降 | ⚠ 期望值／條件期望與矩陣符號是整門課的地基 |
| `w2-prediction-problem.md` | 預測問題：損失函數與風險函數、條件期望是最佳預測子、線性假設的限制、預測誤差三分解（irreducible／approximation／estimation） | ⚠ 「最佳預測子＝條件期望」與誤差三分解是後續所有 ML 方法的骨架 |
| `w3-regression-trees.md` | 迴歸樹：遞迴分割與 CART、超參數（樹深）、bias–variance trade-off、交叉驗證選模、in-sample MSE 為何不可靠 | |

> 主幹路徑：**w1（期望值、條件期望、OLS）→ w2（風險、最佳預測子、誤差分解）→ w3（樹、bias–variance、CV）**。其餘週次尚未載入。

## 查詢流程（query-playbook，助教每題照做）

1. **判斷意圖與來源**：這題該用哪個來源？**概念**→講義（course-context）；**課務**（時間/評分/office hour）→`../supplementary/syllabus.md`；**作業/專案**→`../supplementary/assignments.md`／`project.md`（只給提示）；**考古題**→`../supplementary/exams.md`（複習）；**案例**→`../supplementary/cases.md`。依 `../supplementary/README.md` 的**行為政策**回應（越靠近受評產出越只給提示）。
2. **挑單元**：概念題用上面主題地圖，找對應的 `course-context/` 檔。
3. **據檔作答**：只依該檔內容回答，並**註明出處小節**。
4. **依教學 DNA 組織**：大綱→直覺→（問題先行）機制→陷阱→回顧＋一個 punchline（見 `../references/teaching-style.md`）。
5. **診斷先備**：學生明顯卡在某個下游概念時，先看 `../knowledge-graph.md` 的「外部先備知識」段落，判斷是不是缺了**課前應具備的先備**（如特徵向量、疊代期望）；若是，溫和點出並給補強方向，而非硬推下游。
6. **作業題**：只給提示與引導問題，**不給完整答案**。
7. **查無依據**：說「講義未提及／超出範圍」，**不編造**；不確定標「請老師確認」。

---

*這張索引可由 `teach-context` skill 蒸餾講義時順帶產生/更新；外部先備由 `teach-prereq` skill 盤點。*
