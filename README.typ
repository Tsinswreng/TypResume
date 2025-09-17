/* 
pandoc README.typ -o README.md
 */
= Chinese Resumé in Typst | 基于Typst語言的中文個人簡歷

構建
```bash
cd Main
typst compile Main.typ
```

(源碼中皆用繁體中文。可結合Opencc命令行工具在構建時輸出簡體中文、此項目未提供。)

= 預覽圖

#image("assets/2025-09-17-13-20-30.png")

#image("assets/2025-09-17-13-21-08.png")

= 項目結構
```bash
293.jpg	# 頭像
Cfg.typ # 輸出配置
CfgCs.typ # C#版簡歷配置
CfgItems.typ # 配置項
CfgJava.typ # Java版簡歷配置
CfgMix.typ # 混合版簡歷配置
Code.typ # 樣式代碼
Info.typ # 個人信息
InfoFake.typ # 假信息
InfoKeys.typ # 個人信息字典鍵
InfoReal.typ # 真信息
Main.typ # 主文檔
```
