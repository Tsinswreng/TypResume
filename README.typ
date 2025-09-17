/* 
pandoc README.typ -o README.md
 */
= Chinese Résumé in Typst | 基于Typst語言的中文個人簡歷

= 構建

我的typst版本: `typst 0.13.1 (8ace67d9)`
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


= 將此簡歷作爲模板使用

直接按需改Main.typ和InfoReal.typ裏的內容即可

= 多版本編譯

針對不同崗位、此簡歷中有 C\#, Java, Mix三種版本。構建時需通過Cfg.typ配置版本

Cfg.typ:
```typst
#import "CfgItems.typ":* // 引用配置標誌

#let IsShowAvatar = true // 是否顯示頭像
#let IsReal = true // 是否使用真實信息
#let Tendency = TendCSharp // 選擇簡歷版本
#let Mode = ModeRelease // 發佈模式
```

正文中涉及條件編譯之處 舉例:
```typst
#if Tendency == TendMix{
	MixSkill
}else if Tendency == TendCSharp{
	CSharpSkill
}else if Tendency == TendJava{
	JavaSkill
}else{
	[=== Mix]
	MixSkill
	[=== CSharp]
	CSharpSkill
	[=== Java]
	JavaSkill
}
```