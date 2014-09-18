% tudbeamer is the latex-beamer-class as described in the TUD-Design-Manual
% It is based on (makes heavy use of) the latex-beamer-Class beamer
% This class is provided "as is", the authors take no responsibility
% for any effects the style file has on the user, the user's life, family,
% pets, scientific or other career etc.
%
% When making changes to this style file or the accompanying package files
% please notify the authors:
% tud-style@pro-kevin.de
% Good luck!

\def\fileversion{1.1}
\def\filedate{2009/07/14}
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{tudbeamer}
 [\filedate\space\fileversion\space
   Joe Werner's and Clemens v. Loewenich's TUD-Design-Manual package]

\PassOptionsToClass{t,hyperref={pdfpagelabels=false,plainpages=false}}{beamer}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{beamer}
  \PassOptionsToPackage{\CurrentOption}{beamerthemeTUD}}
\ProcessOptions

% Load the latex-beamer class
\PassOptionsToClass{10pt}{beamer}
\LoadClass{beamer}

% Some adjustments
\setlength\parskip{0pt}
\setlength\parindent{0pt}

% Load the TUD theme
\AtEndOfClass{%
  \usetheme{TUD}%
  \@input{\jobname.len}%
  \@starttoc{len}%
  \let\accentfont\normalfont%
}

\newenvironment{titleframe}%
{\setbeamertemplate{headline}[TUD title]
 \begin{frame}[t]%
   \advance\textheight-\TUD@titleboxcomplete%
   \advance\textheight\TUD@frametitleboxheight%
   \vspace*{-\TUD@frametitleboxheight}%
   \vspace*{\TUD@titleboxcomplete}%
}
{\end{frame}%
 \setbeamertemplate{headline}[TUD theme]%
}

\endinput

\newenvironment{titleframe}%
{\setbeamertemplate{headline}[TUD title]
% \advance\headheight-\TUD@frametitleboxheight
% \advance\headheight\TUD@titleboxcomplete
% \advance\textheight-\TUD@titleboxcomplete
 \headheight0pt%
 \pagestyle{plain}
 \begin{frame}[t]
 \textheight\paperheight%
 \advance\textheight-2ex%
 \vspace*{-3ex}%
 \fboxsep0pt%
 \fbox{%
 \begin{minipage}[t][\textheight][t]{\TUD@rulelength}
   \vspace*{-2ex}%
   \usebeamertemplate{headline}
%   \rule{1em}{\textheight}
   \the\headheight%
   \vfill%
 \fboxsep0pt%
 \fbox{%
   \begin{minipage}[b][\footheight][b]{\TUD@rulelength}
     \nointerlineskip%
     \tudrule\\%
     \usebox{\frameauthorbox}%
   \end{minipage}
   }
   \end{minipage}
 }}%
{%\end{minipage}%
  \end{frame}\setbeamertemplate{headline}[TUD theme]}
