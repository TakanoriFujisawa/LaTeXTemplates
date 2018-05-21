%-------------------------------------------------------------------------------
%              SIP Symposium 向けクラスファイル (sips.sty の代用)
%-------------------------------------------------------------------------------
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{ikelab-sips}
  [2015/09/08 Fujisawa
 Standard pLaTeX class (Modified for SIP Symposium)]

%-------------------------------------------------------------------------------
% 文字サイズ他クラスオプションの処理
%-------------------------------------------------------------------------------
\newcounter{@paper}
\newcommand{\@ptsize}{}
\newif\if@landscape \@landscapefalse
\newif\if@stysize \@stysizefalse
%
\newif\ifOnlyEnglish \OnlyEnglishfalse
%
\hour\time \divide\hour by 60\relax
\@tempcnta\hour \multiply\@tempcnta 60\relax
\minute\time \advance\minute-\@tempcnta
%
%
%
\setcounter{@paper}{1}
\setlength\paperheight {297mm}
\setlength\paperwidth  {210mm}
%
%
\DeclareOption{10pt}{\renewcommand{\@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand{\@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand{\@ptsize}{2}}
%
%
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
%
%
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
%
% sips.sty より．英語論文を投稿するときにこのオプションを入れる
\DeclareOption{english}{\OnlyEnglishtrue}
\DeclareOption{japanese}{\OnlyEnglishfalse}
%
\ExecuteOptions{10pt,oneside,twocolumn,japanese}
%
\ProcessOptions\relax
%
%-------------------------------------------------------------------------------
% 用紙，文字の設定
%-------------------------------------------------------------------------------
%
% jsize10.clo からではなく jsarticle からサイズ設定を引用する
%\input{jsize1\@ptsize.clo}
%
%
% ~~~~~ jsarticle 引用部１ (フォント，間隔調整，用紙パラメータ関連) ~~~~~
%
\DeclareFontShape{JY1}{mc}{m}{n}{<-> s * [0.961] jis}{}
\DeclareFontShape{JY1}{gt}{m}{n}{<-> s * [0.961] jisg}{}
\DeclareFontShape{JT1}{mc}{m}{n}{<-> s * [0.961] tmin10}{}
\DeclareFontShape{JT1}{gt}{m}{n}{<-> s * [0.961] tgoth10}{}
\DeclareFontShape{JY1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{m}{sl}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sl}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{sl}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{sl}{<->ssub*gt/m/n}{}
\DeclareRobustCommand\rmfamily
        {\not@math@alphabet\rmfamily\mathrm
         \romanfamily\rmdefault\kanjifamily\mcdefault\selectfont}
\DeclareRobustCommand\sffamily
        {\not@math@alphabet\sffamily\mathsf
         \romanfamily\sfdefault\kanjifamily\gtdefault\selectfont}
\DeclareRobustCommand\ttfamily
        {\not@math@alphabet\ttfamily\mathtt
         \romanfamily\ttdefault\kanjifamily\gtdefault\selectfont}
\def\textmc#1{\relax\ifmmode\hbox\fi{\mcfamily #1}}
\def\textgt#1{\relax\ifmmode\hbox\fi{\gtfamily #1}}
%
\def\@setfontsize#1#2#3{%
  \ifx\protect\@typeset@protect
    \let\@currsize#1%
  \fi
  \fontsize{#2}{#3}\selectfont
  \ifdim\parindent>\z@
    \ifOnlyEnglish
      \parindent=1em
    \else
      \parindent=1zw
    \fi
  \fi
  \kanjiskip=0zw plus .1zw minus .01zw
  \ifdim\xkanjiskip>\z@
    \xkanjiskip=0.25em plus 0.15em minus 0.06em
  \fi}
\emergencystretch 3zw
%
%
%
\newif\ifnarrowbaselines
% 英語文章の行間を狭くする
\ifOnlyEnglish
  \narrowbaselinestrue
\fi
\def\narrowbaselines{%
  \narrowbaselinestrue
  \skip0=\abovedisplayskip
  \skip2=\abovedisplayshortskip
  \skip4=\belowdisplayskip
  \skip6=\belowdisplayshortskip
  \@currsize\selectfont
  \abovedisplayskip=\skip0
  \abovedisplayshortskip=\skip2
  \belowdisplayskip=\skip4
  \belowdisplayshortskip=\skip6\relax}
\def\widebaselines{\narrowbaselinesfalse\@currsize\selectfont}
\renewcommand{\normalsize}{%
  \ifnarrowbaselines
    \@setfontsize\normalsize\@xpt\@xiipt
  \else
    \@setfontsize\normalsize\@xpt{16}%
  \fi
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayskip 9\p@ \@plus3\p@ \@minus4\p@
  \belowdisplayshortskip \belowdisplayskip
  \let\@listi\@listI}
\normalsize
\setbox0\hbox{\char\euc"A1A1}%"
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}
\def\small{%
  \ifnarrowbaselines
    \@setfontsize\small\@ixpt{11}%
  \else
    \@setfontsize\small\@ixpt{13}%
  \fi
  \abovedisplayskip 9\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip  \z@ \@plus3\p@
  \belowdisplayskip \abovedisplayskip
  \belowdisplayshortskip \belowdisplayskip
  \def\@listi{\leftmargin\leftmargini
              \topsep \z@
              \parsep \z@
              \itemsep \parsep}}
\def\footnotesize{%
  \ifnarrowbaselines
    \@setfontsize\footnotesize\@viiipt{9.5}%
  \else
    \@setfontsize\footnotesize\@viiipt{11}%
  \fi
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus3\p@
  \abovedisplayshortskip  \z@ \@plus2\p@
  \belowdisplayskip \abovedisplayskip
  \belowdisplayshortskip \belowdisplayskip
  \def\@listi{\leftmargin\leftmargini
              \topsep \z@
              \parsep \z@
              \itemsep \parsep}}
\def\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\def\tiny{\@setfontsize\tiny\@vpt\@vipt}
\def\large{\@setfontsize\large\@xiipt{16}}
\def\Large{\@setfontsize\Large\@xivpt{21}}
\def\LARGE{\@setfontsize\LARGE\@xviipt{25}}
\def\huge{\@setfontsize\huge\@xxpt{28}}
\def\Huge{\@setfontsize\Huge\@xxvpt{33}}
\def\HUGE{\@setfontsize\HUGE{30}{40}}
%
%
%
\setlength\columnsep{2zw}
\setlength\columnseprule{0\p@}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\setlength\lineskiplimit{1\p@}
\setlength\normallineskiplimit{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip{0\p@}
\setlength\parindent{1\Cwd}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setlength\topskip{10\p@}
\setlength\headheight{2\topskip}
\setlength\footskip{0.03367\paperheight}
\ifdim\footskip<\baselineskip
  \setlength\footskip{\baselineskip}
\fi
\setlength\headsep{\footskip}
\addtolength\headsep{-\topskip}
\setlength\maxdepth{.5\topskip}
\newdimen\fullwidth
\setlength\fullwidth{0.76\paperwidth}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
%
% jarticle よりも大量に図を詰め込めるようにしているらしい
\setcounter{topnumber}{9}
\renewcommand{\topfraction}{.85}
\setcounter{bottomnumber}{9}
\renewcommand{\bottomfraction}{.8}
\setcounter{totalnumber}{20}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.8}
\setcounter{dbltopnumber}{9}
\renewcommand{\dbltopfraction}{.8}
\renewcommand{\dblfloatpagefraction}{.8}
%
%
% ~~~~~ jsarticle.cls 引用部その１おわり ~~~~~
%
%
%
% sips.sty の設定値を絶対値で決め打ち
\setlength{\textwidth}{176mm}
\setlength{\textheight}{244mm}
\setlength{\topmargin}{-36pt}
\setlength{\oddsidemargin}{-23pt}
\setlength{\evensidemargin}{-23pt}
\setlength{\columnsep}{5mm}
%-------------------------------------------------------------------------------
% タイトルのフォーマット
%-------------------------------------------------------------------------------
\def\jtitle#1{\gdef\@jtitle{#1}}        % Japanese Title
\def\jauthor#1{\gdef\@jauthor{#1}}      % Japanese Authors
\def\jaddress#1{\gdef\@jaddress{#1}}    % Japanese Address
\def\etitle#1{\gdef\@etitle{#1}}        % English Title
\def\eauthor#1{\gdef\@eauthor{#1}}      % English Authors
\def\eaddress#1{\gdef\@eaddress{#1}}    % English Address
\def\p@thanks#1{\footnotemark
  \protected@xdef\@thanks{\@thanks
    \protect{\noindent$\m@th^\thefootnote$~#1\protect\par}}}
%
\newcommand{\maketitle}{\par
\twocolumn[
\begin{center}%
\ifOnlyEnglish%
  {\large \bfseries \@etitle \par} \vskip 1.5em%    % ETitle
  {\large \lineskip .5em \begin{tabular}[t]{c} \@eauthor \end{tabular}\par\@eaddress \par}%
\else% OnlyEnglish
  {\LARGE \bfseries\@jtitle \par} \vskip 0.0em%    % JTitle
  {\large \bfseries \@etitle \par} \vskip 1.5em%    % ETitle
  {\large \lineskip .5em \begin{tabular}[t]{c} \@jauthor \end{tabular}\par\@jaddress \par}\vskip 1.5em%
  {\large \lineskip .5em \begin{tabular}[t]{c} \@eauthor \end{tabular}\par\@eaddress \par}%
\fi% OnlyEnglish
\end{center} \par%
\vskip 3em
]
\sloppy \flushbottom
\parindent 1.0em 
\leftmargini 2.6em \leftmargin\leftmargini
\leftmarginv .5em \leftmarginvi .5em
}
%
%-------------------------------------------------------------------------------
% アブストラクト・セクションのフォーマット
%-------------------------------------------------------------------------------
\newenvironment{abstract}{\noindent\textbf{\abstractname}\hskip1pc}{\par}
\newenvironment{summary}{\abstract}{\endabstract}
%
\setcounter{secnumdepth}{3}
%
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
%
\renewcommand{\thesection}{\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{\thesubsection.\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{\thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{\theparagraph.\@arabic\c@subparagraph}
%
\newcommand{\section}{\@startsection{section}{1}{\z@}%
   {1.5ex plus 0.5ex minus .2ex}{1.0ex plus 0.3ex minus .2ex}{\reset@font\normalsize\bfseries}}
\newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
   {1.5ex plus 0.2ex minus .2ex}{0.8ex plus .2ex}{\reset@font\normalsize\bfseries\raggedright}}
\newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
   {1ex plus 0.5ex minus .2ex}{0.8ex plus .2ex}{\reset@font\normalsize\bfseries\raggedright}}
\newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}{-1em}{\reset@font\normalsize\bfseries}}
\newcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}{-1em}{\reset@font\normalsize\bfseries}}
%
\newcommand{\appendix}{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\presectionname{\appendixname}%
  \gdef\postsectionname{}%
  \gdef\thesection{\presectionname\@Alph\c@section\postsectionname}%
  \gdef\thesubsection{\@Alph\c@section.\@arabic\c@subsection}}
%
%-------------------------------------------------------------------------------
% itemize, enumerate, description のフォーマット
%-------------------------------------------------------------------------------
\setlength\leftmargini  {2zw}
\setlength\leftmarginii {2zw}
\setlength\leftmarginiii{2zw}
\setlength\leftmarginiv {2zw}
\setlength\leftmarginv  {1zw}
\setlength\leftmarginvi {1zw}
\setlength\labelsep     {0.5zw} % .5em
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{\z@} % {2\p@ \@plus 1\p@ \@minus 1\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{\inhibitglue（\theenumii）\inhibitglue}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi\inhibitglue（\theenumii）}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
%
%
\renewenvironment{enumerate}
  {\ifnum \@enumdepth >\thr@@\@toodeep\else
   \advance\@enumdepth\@ne
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
      \iftdir
         \ifnum \@listdepth=\@ne \topsep.5\normalbaselineskip
           \else\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw \labelsep.3zw
         \ifnum \@enumdepth=\@ne \leftmargin1zw\relax
           \else\leftmargin\leftskip\fi
         \advance\leftmargin 1zw
      \fi
         \usecounter{\@enumctr}%
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}
%
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\renewenvironment{itemize}
  {\ifnum \@itemdepth >\thr@@\@toodeep\else
   \advance\@itemdepth\@ne
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \expandafter
   \list{\csname \@itemitem\endcsname}{%
      \iftdir
         \ifnum \@listdepth=\@ne \topsep.5\normalbaselineskip
           \else\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw \labelsep.3zw
         \ifnum \@itemdepth =\@ne \leftmargin1zw\relax
           \else\leftmargin\leftskip\fi
         \advance\leftmargin 1zw
      \fi
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}
%
\newenvironment{description}{%
  \list{}{%
    \labelwidth=\leftmargin
    \labelsep=1zw
    \advance \labelwidth by -\labelsep
    \let \makelabel=\descriptionlabel}}{\endlist}
\newcommand*\descriptionlabel[1]{\normalfont\bfseries #1\hfil}
%
\newenvironment{verse}{%
  \let \\=\@centercr
  \list{}{%
    \itemsep \z@
    \itemindent -2zw % 元: -1.5em
    \listparindent\itemindent
    \rightmargin \z@
    \advance\leftmargin 2zw}% 元: 1.5em
  \item\relax}{\endlist}
\newenvironment{quotation}{%
  \list{}{%
    \listparindent\parindent
    \itemindent\listparindent
    \rightmargin \z@}%
  \item\relax}{\endlist}
\newenvironment{quote}%
  {\list{}{\rightmargin\z@}\item\relax}{\endlist}
\def\@begintheorem#1#2{\trivlist\labelsep=1zw
   \item[\hskip \labelsep{\headfont #1\ #2}]}
\def\@opargbegintheorem#1#2#3{\trivlist\labelsep=1zw
      \item[\hskip \labelsep{\headfont #1\ #2（#3）}]}

%
%-------------------------------------------------------------------------------
% figure, table のフォーマット
%-------------------------------------------------------------------------------
\newcounter{figure}
\renewcommand{\thefigure}{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
%
%
\newcounter{table}
\renewcommand{\thetable}{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{5\p@} % 元: 10\p@
\setlength\belowcaptionskip{5\p@} % 元: 0\p@
%
%
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \iftdir\sbox\@tempboxa{#1\hskip1zw#2}%
    \else\sbox\@tempboxa{#1: #2}%
  \fi
  \ifdim \wd\@tempboxa >\hsize
    \iftdir #1\hskip1zw#2\relax\par
      \else #1: #2\relax\par\fi
  \else
    \global \@minipagefalse
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
%
%
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\DeclareRobustCommand{\mathmc}{%
  \@latex@error{Command \noexpand\mathmc invalid with\space
     `disablejfam' class option.}\@eha
}
\DeclareRobustCommand{\mathgt}{%
  \@latex@error{Command \noexpand\mathgt invalid with\space
     `disablejfam' class option.}\@eha
}
%
%
%-------------------------------------------------------------------------------
% 参考文献リストのフォーマット
%-------------------------------------------------------------------------------
%
% BiBTeX 使用時のフォーマットを指定
\ifOnlyEnglish
  \bibliographystyle{ieicetr}
\else
  \bibliographystyle{sieicej}
\fi
%
\newdimen\bibindent
\setlength\bibindent{2zw}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\newenvironment{thebibliography}[1]
{\section*{\refname\@mkboth{\refname}{\refname}}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}
\let\@openbib@code\@empty
\newcommand{\@idxitem}{\par\hangindent 40\p@}
\newcommand{\subitem}{\@idxitem \hspace*{20\p@}}
\newcommand{\subsubitem}{\@idxitem \hspace*{30\p@}}
\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\newcommand\@makefntext[1]{\parindent 1em
  \noindent\hbox to 1.8em{\hss\@makefnmark}#1}
%
%-----------------------------------------------------------------
% 数式を左寄せに (オリジナル sips.sty より)
% amsmath パッケージを入れる場合は fleqn オプションをつけること
%-----------------------------------------------------------------
\def\[{\relax\ifmmode\@badmath\else
\parsep 4pt plus 2pt minus 1pt 
\topsep 8pt plus 2pt minus 4pt 
\itemsep 4pt plus 2pt minus 1pt
\begin{trivlist}\item[]\leavevmode
 \hbox to\linewidth\bgroup$ \displaystyle
 \hskip\mathindent\bgroup\fi}
\def\]{\relax\ifmmode \egroup $\hfil \egroup \end{trivlist}\else \@badmath \fi}

\def\equation{\refstepcounter{equation}
\parsep 4pt plus 2pt minus 1pt 
\topsep 8pt plus 2pt minus 4pt 
\itemsep 4pt plus 2pt minus 1pt
\trivlist \item[]\leavevmode
 \hbox to\linewidth\bgroup $ \displaystyle
\hskip\mathindent}
\def\endequation{$\hfil \displaywidth\linewidth\@eqnnum\egroup \endtrivlist}
\def\@eqnnum{(\theequation)\hspace*{3mm}}
%-----------------------------------------------------------------
% 複数エントリを入力可能な \cite コマンド (オリジナル sips.sty より)
% どのみち cite.sty を入れると思うのであまり意味が無い
%-----------------------------------------------------------------
\newcount\@minsofar
\newcount\@min
\newcount\@cite@temp
\def\@citex[#1]#2{%
\if@filesw \immediate \write \@auxout {\string \citation {#2}}\fi
\@tempcntb\m@ne \let\@h@ld\relax \def\@citea{}%
\@min\m@ne%
\@cite{%
  \@for \@citeb:=#2\do {\@ifundefined {b@\@citeb}%
    {\@h@ld\@citea\@tempcntb\m@ne{\bfseries ?}%
    \@warning {Citation `\@citeb ' on page \thepage \space undefined}}%
{\@minsofar\z@ \@for \@scan@cites:=#2\do {%
  \@ifundefined{b@\@scan@cites}%
    {\@cite@temp\m@ne}
    {\@cite@temp\number\csname b@\@scan@cites \endcsname \relax}%% <
\ifnum\@cite@temp > \@min% select the next one to list
    \ifnum\@minsofar = \z@
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\else
    \ifnum\@cite@temp < \@minsofar %% >
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\fi\fi\fi}\@tempcnta\@min %% <
  \ifnum\@minsofar > \z@ % some more
    \advance\@tempcnta\@ne
    \@min\@minsofar
    \ifnum\@tempcnta=\@minsofar %   Number follows previous--hold on to it
      \ifx\@h@ld\relax
        \edef \@h@ld{\@citea\csname b@\@scan@copy\endcsname}%
      \else
       \edef\@h@ld{\ifmmode{]-[}\else]--[\fi\csname b@\@scan@copy\endcsname}%
       \fi
    \else \@h@ld\@citea\csname b@\@scan@copy\endcsname
          \let\@h@ld\relax
  \fi % no more
\fi}%
\def\@citea{],\penalty\@highpenalty\,[}}\@h@ld}{#1}}
%
%-------------------------------------------------------------------------------
% その他
%-------------------------------------------------------------------------------
%
% (非推奨コマンドの定義) どうしても必要ならコメント解除して下さい
%\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
%\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
%\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
%\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
%\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
%\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
%\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
%\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
%\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
%\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
%\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}
%
%
\newcommand{\refname}{\ifOnlyEnglish References\else 参考文献\fi}
\newcommand{\figurename}{\ifOnlyEnglish Fig.\else 図\fi}
\newcommand{\tablename}{\ifOnlyEnglish Table\else 表\fi}
\newcommand{\appendixname}{\ifOnlyEnglish Appendix\else 付 録\fi}
\newcommand{\abstractname}{\ifOnlyEnglish Abstract\else アブストラクト\fi}
%
\pagestyle{empty}
\pagenumbering{arabic}
%
\hyphenation{ado-be post-script ghost-script phe-nom-e-no-log-i-cal man-u-script}
%
\raggedbottom
%
\if@twocolumn
  \twocolumn
  \sloppy
\else
  \onecolumn
\fi
%
\if@twoside
  \@mparswitchtrue
\else
  \@mparswitchfalse
\fi
%-----------------------------------------------------------------
% End
%-----------------------------------------------------------------
\endinput

