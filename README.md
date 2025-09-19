# Chinese Résumé in Typst \| 基于Typst語言的中文個人簡歷

Typst 是用于排版的 可編程 標記語言、擁有變量, 函數與包管理等
現代編程語言的特性、注重于科學寫作。定位與 LaTeX 相似。支持編譯爲PDF。

此項目是本人的簡歷、使用Typst語言撰寫。

此項目支持

-   多版本編譯

-   真僞信息分離

# 爲甚麼使用Typst?

-   可編程。支持變量、函數、包管理等、更加靈活

-   源碼爲純文本,
    便于版本控制、易于調整樣式(Word直接顯示排版效果、不方便視察與修改內部的樣式邏輯)

-   格式與內容分離、便于製作模板

-   語法簡潔、易于學習。不需要複雜功能時完全能當Markdown用

-   編譯速度快、支持實時預覽、實時預覽時支持源碼與效果頁雙向定位跳轉

-   支持數學公式, 圖片, 表格, 佈局等

# 構建

我的typst版本: `typst 0.13.1 (8ace67d9)`

``` bash
cd Main
typst compile Main.typ
```

(源碼中個人習慣皆用繁體中文。可結合Opencc命令行工具在構建時輸出簡體中文、此項目未提供。)

# 預覽圖

![](assets/2025-09-17-13-20-30.png)

![](assets/2025-09-17-13-21-08.png)

# 項目結構

``` bash
293.jpg # 頭像
Cfg.typ # 編譯配置
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

# 將此簡歷作爲模板使用

直接按需改Main.typ等文件裏的內容即可。最好有一定typst基礎。

# 多版本編譯

此簡歷項目支持以下功能:

-   針對不同崗位、編譯不同版本(此簡歷中有 C#, Java, Mix三種版本)

-   一真一假兩套個人信息獨立存儲
    無侵入主文檔。真實信息用于現實中實際投遞等、假信息用于在網絡上展示等。

通過`Cfg.typ`文件來配置版本:

以下是`Cfg.typ`講解:

``` typst
#import "CfgItems.typ":* // 引用可選的配置標誌

#let IsShowAvatar = true // 是否顯示頭像
#let IsReal = true // 是否使用真實信息
#let Tendency = TendCSharp // 選擇簡歷版本
#let Mode = ModeRelease // 發佈模式。ModeDebug模式下會按不同顏色突顯示不同版本簡歷的差異、ModeRelease模式則統一正文顏色。
```

正文中涉及條件編譯之處 舉例:

``` typst
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

# 關鍵效果解析

## 列表中多項合入一行

列舉技能要點等場景時、首先會想到使用Typst內置的列表。如:

``` typst
#[
    - 精通面向對象編程, 掌握SOLID原則及常用設計模式; 熟悉MVC架構; 了解領域驅動設計(DDD)架構
    - 熟悉ASP.NET, Springboot, Express.js等後端技術
    - 瞭解HTML, CSS, Vue3, 等Web前端技術
    - 熟練編寫SQL語句, 瞭解事務, 索引, 範式, 鎖等概念; 熟悉PostgreSql, Sqlite, Redis等數據庫
    - 熟悉EF Core, Mybatis-plus等ORM
    - 熟悉Avalonia, WPF等GUI框架, 掌握MVVM模式
]
```

效果: ![](assets/2025-09-19-21-55-10.png)

有的行
右側空白較多。當**有壓縮空間的需求**時、可以用以下辦法來做一個假的
支持行內多項的列表:

``` typst
#[
    //列表項
    #let I(doc)={//•
        text()[・]+doc
    }

    //行內多個無序列表之間隔
    #let InLineSpace = h(0.8em)

    #set par(spacing: 0.5em) //段落間隔
    
    //換行後之縮進
    #set par(hanging-indent: 1em)

    #I[精通面向對象編程, 掌握SOLID原則及常用設計模式; 熟悉MVC架構; 了解領域驅動設計(DDD)架構]

    #I[熟悉ASP.NET, Springboot, Express.js等後端技術]
    #InLineSpace #I[瞭解HTML, CSS, Vue3, 等Web前端技術]

    #I[熟練編寫SQL語句, 瞭解事務, 索引, 範式, 鎖等概念; 熟悉PostgreSql, Sqlite, Redis等數據庫]
    
    #I[熟悉EF Core, Mybatis-plus等ORM]
    #InLineSpace
    #I[熟悉Avalonia, WPF等GUI框架, 掌握MVVM模式]

]

```

效果: ![](assets/2025-09-19-21-57-14.png)

## 色底白字 帶下分隔綫的一級標題

![](assets/2025-09-19-22-07-59.png)

文字外圍的色塊使用`rect`函數繪製。分隔綫使用`box`函數、將高度設置爲一像素。

使用`grid`佈局將標題塊與分隔線分別置于左右兩側。

``` typst
#[
    //主題色
    #let MainColor = red

    //一級標題函數
    #let H(doc)={
        //段距
        set par(spacing: 0em)
        
        //標題下方ʹ分隔綫
        let Line = box(height: 1pt, width: 53em, fill: MainColor)

        //白字函數
        let White(doc)={
            set text(white)
            doc
        }

        //字ˇ繞ʹ白塊。使用左右的grid佈局
        let Box = grid(
            columns: (auto, 1fr)//左邊設爲auto讓他佔據儘量小的空間
            ,rect(fill: MainColor)[#White(doc)]//左邊爲標題塊
            ,align(bottom)[#box(height: 1pt, width: 50.5em, fill: MainColor)] //右邊爲低部分隔綫
        )

        //標題無文字時只顯示分隔綫
        if doc != [] {
            [= #Box]
        }else{
            Line
        }
    }

    #H[專業技能]
]
```

## 字體粗細問題

(參照了`"@preview/cuti:0.2.1"`包的實現)

Typst的加粗依賴字體族中提供的粗號字體。若使用的字體族中不包含粗號字體則需用文字描邊(stroke)模擬實現

如

``` typst
#[
    #set text(font: "STSong")
    一二三四

    *一二三四*
]
```

效果爲: ![](assets/2025-09-19-21-23-50.png) 第二行字並沒有加粗效果。

此時可爲需加粗的文字設置stroke:

``` typst
#[
    #set text(font: "STSong")
    
    一二三四

    #text(stroke: 0.1em)[一二三四]
]
```

效果:

![](assets/2025-09-19-21-25-20.png)

使用stroke設置基字體粗細時、
stroke默認下給文字添加的描邊爲黑色。當文字本身爲其他顏色時、添加的黑色描邊會影響效果。如

``` typst
#[
    #set text(stroke: 0.04em)

    黑色字

    #text(fill: red)[紅色字]
]
```

![](assets/2025-09-19-21-31-25.png) 可見「紅色字」被描上了黑邊。

爲解決此問題、可結合show規則、在傳入的函數中通過`context`獲取文字本身的顏色並設爲描邊顏色

``` typst
#[
    #let BaseStroke = 0.04em //基字體粗細
    #let FnBaseStroke(doc, ..params)={
        context{
            if(text.stroke == none){//只針對未設置過stroke的文字、降低優先級 防止覆蓋
                set text(
                    stroke: BaseStroke+text.fill//加粗旹 把描邊顏色設成和原色 一致
                )
                doc
            }else{
                doc
            }
        }
    }

    #show text: it=>FnBaseStroke(it) //不能用show: FnBaseStroke

    黑色字

    #text(fill: red)[紅色字]

    
]
```

效果: ![](assets/2025-09-19-21-32-54.png)
