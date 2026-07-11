# source-materials/ — 放你的原始教材（初始化的輸入）

把原始教材**照類型**丟進來（PDF／DOCX／MD／.tex 皆可）；初始化技能**掃描實際存在的檔案、有什麼生成什麼**——沒有的類型不用建資料夾、不會被追問。

```
source-materials/
├── syllabus/           # 課綱（PDF／DOCX／MD 皆可）
├── lecture-notes/      # 各單元講義
├── slides/             # 選用：投影片（作為講義的輔助來源，不另生成 slide markdown）
├── homework/           # 各作業（含附件）
├── exams/              # 選用：考古題
└── cases/              # 選用：case 教材
```

分不出類的檔案原樣放本資料夾根層（初始化會列入報告的待分類清單，不硬塞）。

- **疑似期末專案（project）的教材**：本 TA 範本不處理（另有專案 repo）——會列入 `INITIALIZATION-REPORT.md` 的未處理檔。
- **著作權與發布**：本資料夾是否隨學生版 repo 一起發布**由老師決定**（預設：private repo 保留；公開發布前可移除或加入 `.gitignore`）。
- 含解答的原始檔（如教師版考卷）可以放——初始化生成學生可見文件時**一律排除解答**。
