# 卒論 / 修論 用 スタイルファイル

某研究室卒論・修論用の LaTeX スタイルファイルです．
奥村氏の jsbook (デフォルトで付属, report オプションを指定してください)
に対して，スタイルの変更を加えます． 卒論・修論それぞれ以下のように用いてください.


```latex
\documentclass[dvipdfmx,report,disablejfam,nosetpagesize,12pt]{jsbook}
%% 卒論 bachelor, 修論は master を指定してください
\usepackage[bachelor]{ikelab-thesis}
\usepackage{その他必要なパッケージ...}
   
%% 論文タイトル
\title{2016年度 卒論/修論テンプレート}
%% 論文英語タイトル (修論のみ)
\etitle{The Template for Master Thesis}
%% 論文著者
\author{某研 太郎}
%% 学籍番号
\id{8XXXXXXX}
%% 指導教員名
\teacher{先生名称\hspace{1em}教授}
%% 所属
\department{何処かの大学院どれかの研究科何かしら専攻}
  
\begin{document}
\frontmatter
% 表紙用タイトルの出力
\maketitleforcover
% タイトルを出力
\maketitle
% 論文要旨（修論のみ）
\begin{abstract}
   ここに要旨を記述します
\end{abstract}
% 論文英語要旨（修論のみ）
\begin{eabstract}
   Abstract here ...
\end{eabstract}
% 目次を出力
\tableofcontents
% ページ番号を数字 1 から振り直す
\mainmatter
\chapter{序論}

論文本文を記述 ...

\end{document}
```

## このスタイルに関係のある LaTeX コマンド

### `\title{タイトル}`
論文のタイトルを指定します


### `\author{著者名}`
論文の著者名を指定します



### `\date{年月日}`
執筆年月日を変更します (デフォルトは「XXXX年XX月」)

## このスタイルで定義しているコマンド
### `\scoolyear{年度}`
表紙に表示される年度を変更する (過去の卒論・修論を出力したい時など)
```
\schoolyear{2015} % 年度を「2015 年度」に変更
```

### \thesis{卒業論文/修士論文} 
表紙に表示される「卒業論文」「修士論文」の文字列を変更
ikelab-thesis.sty のオプションで自動的に設定される文字を変更したい時に

    \thesis{卒業論文}

### \id{学籍番号}
表紙に表示される学籍番号を変更

    \id{8XXXXXXX}
  
### \department{所属名}
所属を変更．学事の指定どおり改行を入れたい時とか

    \department{慶應義塾大学理工学研究科\\総合デザイン工学専攻}

### \teacher{指導教員名}
指導教員．役職まで記述する

    \teacher{先生名称\hspace{1em}教授}


### \etitle{英語タイトル}
論文の英語タイトル (修論のみ)

    \etitle{This is the English Title}
