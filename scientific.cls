%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% scientific.cls
%%
%% author: Andreas Landgraf <andreas.landgraf@edu.campus02.at>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\newcommand{\scientificDate}{2015/12/05} % version date
\ProvidesClass{scientific}[\scientificDate\space LaTeX template for scientific documents]

%% begin class defaults ---------------------------------------------
% language: english
% draft mode: false
\newcommand{\scientific@Language}{english}
\newcommand{\scientific@Draft}{false}
%% end class defaults ---------------------------------------------

%% begin class options ---------------------------------------------
\DeclareOption{english}{\renewcommand{\scientific@Language}{english}}
\DeclareOption{german}{\renewcommand{\scientific@Language}{german}}
\DeclareOption{draft}{\renewcommand{\scientific@Draft}{true}}
\DeclareOption*{\ClassWarning{scientific}{Unknown document option "\CurrentOption"}}
\ProcessOptions
%% end class options ---------------------------------------------

\RequirePackage{ifthen}

\ifthenelse{\equal{\scientific@Language}{german}}
{\newcommand{\scientific@DocumentLanguage}{ngerman}}{\newcommand{\scientific@DocumentLanguage}{\scientific@Language}}

%% Document Class (Koma Script) -----------------------------------------
%% Doc: mirrors.ctan.org/macros/latex/contrib/koma-script/doc/scrguien.pdf
\LoadClass[
   draft=\scientific@Draft, % draft mode (no images, layout errors shown)
   %%% --- Paper Settings ---
   paper=a4,
   pagesize=auto,
   %%% --- Base Font Size ---
   fontsize=10pt,
   %%% --- Koma Script Version ---
   version=last,
   %%% --- Global Package Options ---
   \scientific@DocumentLanguage, % language (passed to babel and other packages)
]{scrreprt}

\RequirePackage{atveryend} % must be loaded before etoolbox. (bugfix for pageslts)
\RequirePackage{templatetools}
\RequirePackage[utf8]{inputenc} % UTF8 input encoding
\RequirePackage{morewrites}
\RequirePackage{etex}
\reserveinserts{28}
\RequirePackage{cmap} % Make PDF files searchable and copyable
\RequirePackage[T1]{fontenc} % T1 font encoding
\RequirePackage{fontspec} % Support Opentype fonts
\setmainfont{Arial}
\RequirePackage{calc} % Calculation with LaTeX 
\RequirePackage[austrian,english]{babel} % Multi Language support for LaTeX
\RequirePackage{translator} % Support automatic translations
\RequirePackage[dvipsnames,table,hyperref,fixinclude]{xcolor}
\RequirePackage{graphicx} % Support for graphics in LaTeX
\RequirePackage{epstopdf}
\RequirePackage{ragged2e}
\RequirePackage{marginnote}
\RequirePackage{scrhack}
\RequirePackage{marginfix}
\RequirePackage{xspace}
\RequirePackage{relsize} % Set the font size relative to the current font size
\RequirePackage[gen]{eurosym} % The European Currency Symbol
\RequirePackage{booktabs}
\RequirePackage{multirow, bigstrut}
\ExecuteAfterPackage{hyperref}{\RequirePackage{ltxtable}}
\RequirePackage{tabu}
\ExecuteAfterPackage{babel}{\RequirePackage[xspace]{ellipsis}}
\RequirePackage[normalem]{ulem} 
\RequirePackage{url}
\ExecuteAfterPackage{setspace}{\RequirePackage[bottom,stable,perpage,ragged,multiple]{footmisc}}
\RequirePackage{varioref}
\ExecuteAfterPackage{hyperref}{\RequirePackage{cleveref}}
\RequirePackage{xr-hyper} 
\RequirePackage{enumitem}
\RequirePackage{abstract}
\RequirePackage[babel,german=quotes,english=british]{csquotes}
\RequirePackage[style=numeric-comp,natbib=true,backend=biber,bibwarn=true,texencoding=auto,bibencoding=auto]{biblatex}  
\RequirePackage{wrapfig}   
\RequirePackage{flafter}
\RequirePackage[section]{placeins}
\RequirePackage{floatrow}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage[top]{mcaption}
\RequirePackage[figuresright]{rotating}
\ExecuteAfterPackage{hyperref}{
  \RequirePackage[translate=true,hyperfirst=true,numberline,section=section,numberedsection=false,nonumberlist,counter=page,sort=standard,acronym,shortcuts]{glossaries}
}
\RequirePackage{multicol}
\RequirePackage{setspace}
\RequirePackage[automark,komastyle,nouppercase]{scrpage2}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage[tocindentauto,tocgraduated,tocbreaksstrict,toctextentriesleft]{tocstyle}
\RequirePackage{pdfpages}
\ifpdf
  \RequirePackage{microtype}
\fi
\RequirePackage[backref=page,pagebackref=false,hyperindex=true,hyperfootnotes=false,bookmarks=true,pdfpagelabels=true]{hyperref}
\IfNotDraft{
  \RequirePackage{bookmark}
}
\RequirePackage[htt]{hyphenat}
\RequirePackage{todonotes}
\RequirePackage{datetime}
\RequirePackage{lastpackage}

% ---- date related functions

\showdowfalse % suppress day-of-week

\newcommand*{\@modifydate}[4]{
  \@namedef{date@#1@d}{#2}
  \@namedef{date@#1@m}{#3}
  \@namedef{date@#1@y}{#4}
}

\newdate{scientific@date}{\the\day}{\the\month}{\the\year}
\renewcommand{\date}[3]{ % e.g.: \date{13}{11}{2015}
  \@modifydate{scientific@date}{#1}{#2}{#3}
}

\newcommand{\scientific@GetDateDay}{\getdateday{scientific@date}}
\newcommand{\scientific@GetDateMonth}{\getdatemonth{scientific@date}}
\newcommand{\scientific@GetDateYear}{\getdateyear{scientific@date}}
\newcommand{\scientific@DisplayDate}{\displaydate{scientific@date}}
\newcommand{\scientific@TitleDate}{\monthname[\getdatemonth{scientific@date}] \getdateyear{scientific@date}}

% ---- misc functions

\newcommand*{\@supervisor}{}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@secondreviewer}{}
\newcommand{\secondreviewer}[1]{\gdef\@secondreviewer{#1}}
\newcommand*{\@institute}{}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand*{\@university}{}
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@id}{}
\newcommand{\id}[1]{\gdef\@id{#1}}
\newcommand*{\@city}{}
\newcommand{\city}[1]{\gdef\@city{#1}}
\newcommand*{\@logo}{}
\newcommand{\logo}[1]{\gdef\@logo{#1}}

\newcommand{\makeabstract}[2]{
  \clearpage
  \thispagestyle{empty}
  \subsection*{Abstract}
  #1
  \clearpage
  \thispagestyle{empty}
  \subsection*{Zusammenfassung}
  #2
}

\newcommand{\makedeclaration}{
  \clearpage
  \thispagestyle{empty}
  \vspace*{2cm}
  \subsection*{Statutory Declaration}
  \noindent
  \textit{
  I declare that I have authored this thesis independently, that I have
  not used other than the declared sources / resources, and that I have
  explicitly marked all material which has been quoted either literally
  or by content from the used sources.
  }

  \vspace{1cm}

  \begin{flushleft}
  \begin{tabular}{lclcl}
  \underline{\@city, \hspace*{4cm}} & ~\hfill & \hspace*{3cm} & ~\hfill &  \underline{\hspace*{5cm}} \\
  \multicolumn{1}{c}{Place, Date}  & ~ &   & ~ &  \multicolumn{1}{c}{Signature}   \\
  \end{tabular}
  \end{flushleft}


  \vspace{3cm}
  \selectlanguage{german}
  \subsection*{Eidesstattliche Erkl{\"a}rung}
  \noindent
  \textit{
  Ich erkl{\"a}re an Eides statt, dass ich die vorliegende Arbeit
  selbstst{\"a}ndig verfasst, andere als die angegebenen Quellen/Hilfsmittel
  nicht benutzt, und die den benutzten Quellen w{\"o}rtlich und inhaltlich
  entnommene Stellen als solche kenntlich gemacht habe.
  }

  \vspace{1cm}

  \begin{flushleft}
  \begin{tabular}{lclcl}
  \underline{\@city, am\hspace*{3.6cm}} & ~\hfill & \hspace*{3cm} & ~\hfill &  \underline{\hspace*{5cm}} \\
  \multicolumn{1}{c}{Ort, Datum}  & ~ &   & ~ &  \multicolumn{1}{c}{Unterschrift}   \\
  \end{tabular}
  \end{flushleft}
  \selectlanguage{english}
}

\renewcommand*{\maketitle}{
  \clearpage
  \thispagestyle{empty}
  \null
  \begin{center}
    \ifx\@subject\@empty\else
      {\subject@font \@subject \par}
      \vskip 7em
    \fi
    {\hrule\vskip 2em \titlefont\huge\@title\vspace*{1em}\hrule\vspace*{2em}\par}
    \vskip 3.5em
    \ifthenelse{\equal{\scientific@Language}{german}}
    {ausgeführt an der \par}
    {accomplished at \par}
    \vskip 1em
    {\parbox[c]{14em}{\includegraphics[width=14em]{\@logo}} \par}
    \vskip .2em
    {\@university \par}
    \vskip 2em
    {\@institute \par}
    \vskip 2em
    \ifthenelse{\equal{\scientific@Language}{german}}
    {von \par}
    {by \par}
    {\Large \textbf{\@author} \par}
    \ifx\@id\@empty
      \vskip 2em
    \else
      {\@id \par}
    \fi
    \vskip 2em
    \ifthenelse{\equal{\scientific@Language}{german}}
    {betreut und begutachtet von \par}
    {supervised and reviewed by \par}
    \ifx\@supervisor\@empty
      \vskip 2em 
    \else
      {\normalsize \@supervisor \par}
    \fi
    \vfill
    \ifthenelse{\equal{\scientific@Language}{german}}
    {
      \begin{flushleft}
        \begin{tabular}{lclcl}
          {\@city, im \scientific@TitleDate} & ~\hfill & \hspace*{3cm} & ~\hfill &  \underline{\hspace*{5cm}} \\
          ~\hfill & ~ &   & ~ &  \multicolumn{1}{c}{Unterschrift}   \\
        \end{tabular}
      \end{flushleft}
    }
    {
      \begin{flushleft}
        \begin{tabular}{lclcl}
          {\@city, \scientific@TitleDate} & ~\hfill & \hspace*{3cm} & ~\hfill &  \underline{\hspace*{5cm}} \\
          ~\hfill & ~ &   & ~ &  \multicolumn{1}{c}{Signature}   \\
        \end{tabular}
      \end{flushleft}
    }
  \end{center}
  \par
}

% define bibliography categories used by \MakeBibliography
\ifthenelse{\equal{\scientific@Language}{german}}
{
  \newcommand{\@bibtitle}{Quellenverzeichnis}
  \newcommand{\@bibtitleLiteratur}{Literatur}
  \newcommand{\@bibtitleAvmedia}{Filme und audiovisuelle Medien}
  \newcommand{\@bibtitleOnline}{Online-Quellen}
}
{
  \newcommand{\@bibtitle}{References}
  \newcommand{\@bibtitleLiteratur}{Literature}
  \newcommand{\@bibtitleAvmedia}{Movies and audio-visual Media}
  \newcommand{\@bibtitleOnline}{Online Sources}
}

\defbibfilter{literature}{
	not ( type=movie or type=video or type=music or type=audio or 
		  type=online or type=electronic or type=www or type=software )}

\defbibfilter{avmedia}{
	( type=movie or type=video or type=music or type=audio or type=software )}

\defbibfilter{online}{
	( type=online or type=electronic or type=www )}

\defbibheading{noheader}[]{}

\newcommand{\addbibfile}[1]{
	\addbibresource{#1}
}

\newenvironment{bibhyphenation}
	{\hyphenpenalty=2
	 \tolerance=9999
	 \exhyphenpenalty=2
	 \linepenalty=1
	 \setlength{\emergencystretch}{3em}}
	{}

% \makebibliography ... creates a reference section with subsections (default)
% \makebibliography[nosplit] ... creates a single reference section
\newcommand{\makebibliography}[1][] {
	% opt. arg (#1): optional argument "nosplit"
	\ifthenelse{\equal{#1}{nosplit}}%
		{% create a single bibliography with all entries:
			\printbibheading[heading=bibintoc,title={\@bibtitle}]
			\begin{bibhyphenation}	
			\printbibliography[heading=noheader]
			\end{bibhyphenation}
		}
		{% split the bibliography using the predefined categories:
			\printbibheading[heading=bibintoc,title={\@bibtitle}]
			\begin{bibhyphenation}
			\printbibliography[filter=literature,heading=subbibintoc,title={\@bibtitleLiteratur}]
			\printbibliography[filter=avmedia,heading=subbibintoc,title={\@bibtitleAvmedia}]
			\printbibliography[filter=online,heading=subbibintoc,title={\@bibtitleOnline}]
			\end{bibhyphenation}
		}
}

% suppress 'in:' within journal article references 
\renewbibmacro{in:}{
	\ifentrytype{article}{}{
	\printtext{\bibstring{in}\intitlepunct}}}

% ---- language switch

\newenvironment{english}
{\begin{otherlanguage}{english}}
{\end{otherlanguage}}

\newenvironment{german}
{\begin{otherlanguage}{ngerman}}
{\end{otherlanguage}}
