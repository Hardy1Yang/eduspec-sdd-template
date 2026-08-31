---
name: teach-animation
description: 用 manim（3Blue1Brown 的數學動畫引擎）製作數學/經濟教學動畫——走 SDD（規格→manim scene→render 出影片）。要做「動畫影片」（如中央極限定理、曲線位移、幾何證明）時使用。互動網頁請改用 teach-sim。
license: CC-BY-NC-SA-4.0
metadata:
  author: EduSpec
  version: "1.0"
---

# teach-animation — 用 manim 做教學動畫

**觸發**：`用「teach-animation」這個 skill，我想做一個 ____ 的動畫。`

動畫是「**跑出來的影片**」（mp4），和 `teach-sim` 的「互動網頁」不同：動畫適合**線性講解一個過程**（如樣本平均如何趨近常態），互動網頁適合**讓學生自己拉**。動畫**是程式**，走完整 SDD。

> **依賴（選用）**：需要 `manim` 與 `ffmpeg`（見 `../../SETUP.md`）。沒裝也能先寫規格與 scene，之後再 render。

## 1. 確認要教什麼

到 `course-context/`（套件根的工作區，或助教資料夾內的 `lecture-notes/`——以實際放講義的那份為準） 確認概念。想清楚這動畫**要讓學生看到什麼過程**（不是塞一堆東西）。

> **選用·定位**：若有課綱檔（助教資料夾根的 `syllabus.md`），參考主題在課程中的定位，讓動畫扣緊課程重點。沒有就照常。

## 2. 寫規格（Spec）

只寫「要什麼、成功長什麼樣」：這動畫分幾幕（act）、每幕呈現什麼、時間長度、**可打勾驗收清單**（如「n 越大，樣本平均分布越集中且趨常態」方向要對）。規格裡不寫程式碼。

> **閘門一（規格寫完就停）**：印出規格檔的**完整路徑**，請使用者打開看、哪裡不對直接改字（純 Markdown），回「**繼續**」（或 OK）才往下。**停下等回覆，不要先寫 scene。**
>
> **閘門二（design 與 tasks 寫完再停）**：寫程式前，先寫兩個檔（與規格檔同資料夾）——**`design.md`**（逐幕規劃：每幕一節，要做什麼、對應規格哪一幕、大約幾秒；即 SDD 心法裡的「計畫」那格）與 **`tasks.md`**（可打勾清單：寫 scene → render → 對驗收清單逐項驗）。印出兩檔路徑，請使用者確認**逐幕順序合不合教學直覺、沒有超出規格範圍**，回「**go**」才開始寫 manim 程式與 render。動畫 render 要跑很久，先停這兩次反而省時間與額度。

## 3. 寫 manim scene（Python）

一個 `Scene` 類別，`construct()` 裡用動畫語言描述：
- 常用物件：`Axes`（座標軸）、`Text`/`MathTex`（中文/LaTeX 文字）、`Rectangle`（長條）、`Dot`、`Line`。
- 常用動畫：`Write`、`Create`、`FadeIn/Out`、`Transform`、`GrowFromEdge`、`LaggedStart`（依序）。
- **中文標籤**、字夠大；一幕一幕 `self.play(...)` + `self.wait(...)`。

## 4. Render（渲染出影片）

直接下指令：`python3 -m manim -qm scenes/<檔>.py <SceneClass>`（-qm 中畫質；快速預覽用 -ql）。manim 產出 mp4；可再用 ffmpeg 加 `+faststart`（適合網頁串流）並抽一張封面。**順手也產出一個 `render.sh`**（把上面那行包起來、加一段「確認 manim/ffmpeg 有裝」的檢查），讓老師之後一鍵重跑——這個 `render.sh` 是你這次要**生出來**的檔，不是套件內建。

## 5. 開影片驗（能跑 ≠ 正確）

播放產出的 mp4，**對照規格驗收清單**：過程對不對、方向對不對、標籤清不清楚。不對就回規格改該幕，重 render。**實作若偏離規格（如片長、分幕），要回頭把規格改一致**——規格是之後重跑的依據。

## 6. 用進課堂 / 產使用手冊
> 欄位照 [`templates/usage-manual-template.md`](../../templates/usage-manual-template.md)（老師端：重生成／課堂使用／發布；學生端：取得／使用；審核紀錄）——所有教材的手冊長一樣。


- 課堂投影 mp4，或貼進投影片。
- 產一份 `使用手冊-animation.md`（帶教材類型後綴）：老師如何 render/播放/發布；（若給學生）如何取得。

---

## manim 速查

| 想做 | 用什麼 |
|------|--------|
| 座標軸＋函數圖 | `Axes(...)`、`axes.plot(lambda x: ...)` |
| 中文/公式 | `Text("中文", font_size=...)`、`MathTex(r"\\bar X")` |
| 長條/直方圖 | `Rectangle(...)` 放到 `axes.c2p(x, y)` |
| 依序出現 | `LaggedStart(*anims, lag_ratio=0.1)` |
| 變形 | `Transform(a, b)` |
| 渲染 | `python3 -m manim -qm scene.py ClassName`（-ql 預覽、-qh 高畫質） |

官方文件（以官方為準）：<https://docs.manim.community>

---

規則：
- 繁體中文、台灣用語；數學符號用 LaTeX（`MathTex`）保留原文。
- **manim / ffmpeg 是選用依賴**；沒裝先寫規格與 scene，裝好再 render。
- 「能跑 ≠ 正確」；render 出來要**親手看過**動畫方向與過程對不對。
- 若公開分享，揭露「本動畫由 AI 協助生成，經授課教師審核」。
- 一個概念一個 scene，別塞太多；先寫規格再寫 scene。
