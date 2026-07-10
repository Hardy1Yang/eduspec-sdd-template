---
name: teach-agent
description: 給定「課名＋授課教師＋對象」，從空白骨架（agent/）一步步生成一個完整的學生端 24h 助教——填 AGENT／知識圖、產 Claude Code 指令與子代理、產 README 與使用手冊。要做課程助教時使用。
license: MIT
metadata:
  author: EduSpec
  version: "1.0"
---

# teach-agent — 從零生成課程助教（含指令互動與使用手冊）

**觸發**：`用「teach-agent」這個 skill，課名：____，授課教師：____，對象：____。`

## 1. 備妥課程素材（可從零、指向一個資料夾）

兩種方式擇一：
- **從零、指向資料夾（推薦）**：老師只有一個裝滿課程檔的資料夾（講義＋課綱＋作業＋考古題＋案例＋專案）時，**先照步驟 2 複製空白骨架**，再用 **`teach-context`** 指向資料夾——它會**自動分類蒸餾進骨架**：講義→`agent/course-context/`、其餘→`agent/supplementary/`（受評素材只留題目不留解答）。
- **手動**：老師已自行把講義精華放進 `course-context/`（一單元一檔），講義以外的放進 `supplementary/`。

**查無任何內容時，請老師先放素材或指定資料夾，不要臆造課程內容。**

## 2. 複製空白骨架

把套件內的空白骨架 `agent/` 複製成一個新資料夾（例如 `<課程代碼>-ta-agent/`）。它已含：`AGENT.md`、`knowledge-graph.md`、`references/`、`course-context/index.md`、`.claude/commands/ta.md`、`.claude/agents/course-ta.md`、`.codex/`、`ACCEPTANCE-CHECKLIST.md`、`README.md`、`deploy/`。

## 3. 填 AGENT.md（大腦）

把 `{{課程名稱}}`、`{{授課教師}}`、`{{授課教師教學口吻描述}}`、`{{課本慣用例子}}`、`{{已載入的週次清單}}` 換成真實內容。**保留三條預設規則**：據講義作答不編造、遇作業只給提示、不確定標「請老師確認」。

> 骨架 AGENT.md 已內建「**二之二、資料來源與行為政策**」＋ index 的來源路由——只要 `supplementary/` 有填，助教就會**依來源類型行為**（課綱據實答、作業/考試只給提示、考古題帶複習）。沒放 supplementary 就刪該段與空檔。

## 4. 填 knowledge-graph.md

依講義列出概念先備依賴（`A ← B`）並標主幹（沒打好會連環崩盤的節點）。

## 5. 產工具轉接頭（Claude 與 Codex 各一套，皆委派 AGENT.md）

**原則：一個大腦、多個薄轉接頭**——真正的規則在 `AGENT.md`，轉接頭只把各工具導向它（不要把規則複製進轉接頭）。**兩套轉接頭的 workflow 都要委派 `AGENT.md` 的「〇、先讀」完整載入清單（含 `references/`、`course-context/index.md`、`supplementary/README.md`）與行為政策——不要寫死「只從 course-context 作答」**（否則 supplementary 不會被用到）。**同時產這兩套並填好 `{{ }}`（課名、代碼、主題）**：

- **Claude Code**：`.claude/commands/ta.md`（`/ta` 指令）＋`.claude/agents/course-ta.md`（子代理）。
- **Codex**：把 `.codex/skills/course-ta-agent/` 資料夾**改名為 `<課程代碼>-ta-agent`**，填好 `SKILL.md`（frontmatter `name`／`description`、workflow 委派 AGENT.md）與 `agents/openai.yaml`（display_name／default_prompt）。

**路徑一律相對於助教資料夾**（`AGENT.md`、`course-context/`、`references/`），老師把資料夾當專案打開時，Claude 的 `/ta`／子代理與 Codex 的 `$<name>` 就都能直接用。

## 6. 產 README（含指令使用說明）

README 要有「**怎麼用**」段落，並列**兩種工具的呼叫法**：Claude Code 打 `/ta <問題>` 或叫子代理；Codex 用 `Use $<課程代碼>-ta-agent to answer …`。附預期行為（觀念題答、作業題只給提示、超綱題不編造），並註明「一個大腦 `AGENT.md`、多個轉接頭」。

## 7. 產 `使用手冊.md`（老師端＋學生端）

在助教資料夾產一份 `使用手冊.md`：
- **老師端**：怎麼生成（本流程）、怎麼在課堂用、怎麼加新單元、怎麼發布給學生。
- **學生端**：怎麼取得（clone/連結）、怎麼載入、怎麼問（含「作業題只會給提示」的預期）。

## 8. 自查

- [ ] 佔位符全部填完、runtime 檔**無殘留 `{{ }}`**（runtime 檔＝`AGENT.md`、`knowledge-graph.md`、`README.md`、`course-context/`、`supplementary/`、`references/teaching-style.md`、`.claude/`、`.codex/`）。**例外，不必歸零**：`HOW-TO-FILL.md`／`GETTING-STARTED.md`／`ACCEPTANCE-CHECKLIST.md`（填空指南，保留範例佔位符）與 `references/first-person-calibration.md`（**設計上由老師實測後親填**，生成時保留 `{{ }}`）。
- [ ] `/指令` 與子代理實測能依規則回答（觀念題答、作業題只給提示、超綱不編造）。
- [ ] README 有指令使用說明；`使用手冊.md` 老師端與學生端步驟齊備。

---

規則：
- 繁體中文、台灣用語；例子用台灣脈絡。
- AI 產草稿，你審學科正確性；產出需人工審核才算完成。
- 助教據講義作答、不編造；遇作業只給提示；不確定標「請老師確認」。
- 不含學生個資；發布前確認講義著作權與來源標示。
