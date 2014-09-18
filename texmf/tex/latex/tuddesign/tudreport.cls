% tudreport is the report-class as described in the TUD-Design-Manual
% It is based on (makes heavy use of) the KOMA-Class scrreprt (scrbook)
% This class is provided "as is", the authors take no responsibility
% for any effects the style file has on the user, the user's life, family,
% pets, scientific or other career etc.
% 
% When making changes to this style file or the accompanying package files
% please notify the authors:
% tuddesign@pro-kevin.de
% Good luck!

\def\fileversion{1.13}
\def\filedate{2009/11/17}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudreport}
 [\filedate\space\fileversion\space 
   Clemens von Loewenich's and Joe Werner's TUD-Design package]

\newif\ifTUD@noresetcounter \TUD@noresetcounterfalse
\newif\ifTUD@longdoc \TUD@longdocfalse

\RequirePackage{xkeyval}
\RequirePackage{ifthen}

% speichere Klassenoptionen f"ur KOMA-Script classen und setze scrreport als Standard
\let\TUD@scr@options\@empty
\newcommand{\TUD@scr@addoptions}[1]{\ifx\TUD@scr@options\@empty\edef\TUD@scr@options{#1}\else\edef\TUD@scr@options{\TUD@scr@options,#1}\fi}
\def\TUD@scr@class{scrreprt}

% Verarbeitung der Optionen
  \DeclareOptionX<\@currname>{book}{%
    \def\TUD@scr@class{scrbook}}

  \DeclareOptionX<\@currname>{accentcolor}{%
    \PassOptionsToPackage{accentcolor=#1}{tudcolours}}

  \DeclareOptionX<\@currname>{colortitle}{%
    \PassOptionsToPackage{colortitle}{tudreprt_title}}

  \DeclareOptionX<\@currname>{colorback}{%
    \PassOptionsToPackage{colorback}{tudreprt_title}}

  \DeclareOptionX<\@currname>{colorbacktitle}{%
    \PassOptionsToPackage{colorbacktitle}{tudreprt_title}}

  \DeclareOptionX<\@currname>{inverttitle}{%
    \PassOptionsToPackage{inverttitle}{tudreprt_title}}

  \DeclareOptionX<\@currname>{inverttitlerule}{%
    \PassOptionsToPackage{inverttitlerule}{tudreprt_title}}

  \DeclareOptionX<\@currname>{blackrule}{%
    \PassOptionsToPackage{blackrule}{tudpage}}

  \DeclareOptionX<\@currname>{longdoc}{%
    \TUD@longdoctrue
    \TUD@scr@addoptions{twoside,openright}}

  \DeclareOptionX<\@currname>{pagingbar}{%
    \PassOptionsToPackage{pagingbar}{tudpage}}

  \DeclareOptionX<\@currname>{nopartpage}{%
    \PassOptionsToPackage{nopartpage}{tudheading}%
    \PassOptionsToPackage{nopartpage}{tudreprt_title}}

  \DeclareOptionX<\@currname>{nochapterpage}{%
    \ClassWarning{\@currname}{Option 'nochapterpage` not supported.\MessageBreak Use article instead!}}

  \DeclareOptionX<\@currname>{bigchapter}{%
    \PassOptionsToPackage{bigchapter}{tudheading}}
  
  \DeclareOptionX<\@currname>{paper}{%
    \ifthenelse{\equal{#1}{a4}\or\equal{#1}{a4report}}{%
      \ClassInfo{\@currname}{Option `paper=a4report' selected.}
      \PassOptionsToPackage{paper=a4report}{tudpage}
      \PassOptionsToPackage{a4}{tudreprt_fonts}}{%
    \ifthenelse{\equal{#1}{a5}\or\equal{#1}{a5report}}{%
      \ClassInfo{\@currname}{Option `paper=a5report' selected.}
      \PassOptionsToPackage{paper=a5report}{tudpage}
      \PassOptionsToPackage{a5}{tudreprt_fonts}}{%
    \ClassWarning{\@currname}{Option `paper=#1' ignored!}%
  }}}

  \DeclareOptionX<\@currname>{landscape}{%
      \PassOptionsToPackage{landscape}{tudpage}}

  \DeclareOptionX<\@currname>{noresetcounter}{%
    \AtEndOfClass{%
      \@ifclassloaded{scrartcl}{}{%
        \@removefromreset{equation}{chapter}%
        \@removefromreset{footnote}{chapter}%
        \@removefromreset{figure}{chapter}%
        \@removefromreset{table}{chapter}%
    }}}

  \DeclareOptionX<\@currname>{noheadingspace}{%
    \PassOptionsToPackage{noheadingspace}{tudheading}}
 
  \DeclareOptionX<\@currname>{article}{%
    \PassOptionsToPackage{nopartpage}{tudheading}%
    \PassOptionsToPackage{nopartpage}{tudreprt_title}%
    \PassOptionsToPackage{noheadingspace}{tudheading}%
    \def\TUD@scr@class{scrartcl}}

  \DeclareOptionX<\@currname>{noresetequation}{%
    \ClassError{\@currname}{Option 'noresetequation` replaced by option 'noresetcounter`!}}
  \DeclareOptionX<\@currname>{noresetfootnote}{%
    \ClassError{\@currname}{Option 'noresetfootnote` replaced by option 'noresetcounter`!}}

  \DeclareOptionX<\@currname>{firstlineindent}{%
    \PassOptionsToPackage{firstlineindent}{tudheading}}

  \DeclareOptionX<\@currname>{numbersubsubsec}{%
    \PassOptionsToPackage{numbersubsubsec}{tudheading}}

  \DeclareOptionX<\@currname>{linedtoc}{%
    \PassOptionsToPackage{linedtoc}{tudheading}}

  \DeclareOptionX<\@currname>{8pt}{%
    \PassOptionsToPackage{9.5pt}{tudreprt_fonts}}

  \DeclareOptionX<\@currname>{9.5pt}{%
    \PassOptionsToPackage{9.5pt}{tudreprt_fonts}}

  \DeclareOptionX<\@currname>{10pt}{%
    \PassOptionsToPackage{10pt}{tudreprt_fonts}}

  \DeclareOptionX<\@currname>{11pt}{%
    \PassOptionsToPackage{11pt}{tudreprt_fonts}}

  \DeclareOptionX<\@currname>{12pt}{%
    \PassOptionsToPackage{12pt}{tudreprt_fonts}}

  \DeclareOptionX<\@currname>{marginparwidth}{%
    \AtEndOfClass{\TUD@setmarginpar{#1}}}

  \DeclareOptionX*{%
    \ClassInfo{\@currname}{Unknown option '\CurrentOption`. Pass to KOMA-Script class.}
    \TUD@scr@addoptions{\CurrentOption}
    }

\ExecuteOptionsX<\@currname>{paper=a4report}
\ProcessOptionsX<\@currname>

% needed to fix koma-script v2.95
\let\TUD@classoptionslist\@classoptionslist
\let\@classoptionslist\relax

% Load the KOMA-Class
\PassOptionsToClass{\TUD@scr@options}{\TUD@scr@class}
\LoadClass{\TUD@scr@class}

% needed to fix koma-script v2.95
\let\@classoptionslist\TUD@classoptionslist

% Used to prevent the reset of the equation and footnote counter
% if specified in class-options
%\if@TUD@load@remreset
% \RequirePackage{remreset}
%\fi
% LaTeX includes a command \@addtoreset that is used to declare that
% a counter should be reset every time a second counter is incremented.
% This lines defines |\@removefromreset| which just undoes the effect
% of \@addtorest. So for example
% \@removefromreset{footnote}{chapter}
\def\@removefromreset#1#2{{%
  \@definecounter{#1}
  \expandafter\let\csname c@#1\endcsname\@removefromreset
  \def\@elt##1{%
    \expandafter\ifx\csname c@##1\endcsname\@removefromreset
    \else
      \noexpand\@elt{##1}%
    \fi}%
  \expandafter\xdef\csname cl@#2\endcsname{%
    \csname cl@#2\endcsname}}}

% Include "niceties"
\RequirePackage{calc}

% Load the TUD-colourscheme
\RequirePackage{tudcolours}

% Waehle die TUD-Standardschriftarten
\RequirePackage{tudreprt_fonts}

%  Separator zwischen Kopfzeite bzw. Fusszeile und Text
\newskip\TUD@headfootsep
  \TUD@headfootsep \baselineskip

% Load pagestyle (bars, papersize, margins)
\RequirePackage{tudpage}

% Load headingstyle for chapter, section etc.
\RequirePackage{tudheading}
 
% Load redefinitions
\RequirePackage{tudredef}

%make sure we do not break the horizontal raster
\flushbottom

% definiert das Aussehen der Titleseite
\RequirePackage{tudreprt_title}

%%% Unterdrueckt Hurenkinder und Schusterjungen %%%
    \clubpenalty = 10000            % 10000 schlie"st Schusterjungen aus
    \widowpenalty = 10000           % 10000 schlie"st Hurenkinder aus
    \displaywidowpenalty = 10000    % f"ur Formeln
%%% ENDE %%% Unterdueckt Hurenkinder und Schusterjungen %%%

%% modified text-breaking parameters, intended for German language
    % Since German words usually are longer than English ones we allow longer 
    % interword spaces as well. A line now may have a badness up to 2500, over
    % 1500 a warning is to be given. Furthermore penalties for hyphenation are
    % lowered because narrow typesetting is preferred against few hyphenations
  \tolerance2500\relax\hbadness1500\relax\doublehyphendemerits50000\relax%
  \finalhyphendemerits25000\relax\adjdemerits50000\relax%
%%% END %%% modified text-breaking parameters, intended for German language

\if@twocolumn\setcapindent{0pt}\fi

% Jetzt setze den Seitenstil
\AtBeginDocument{\ifTUD@longdoc\pagestyle{headings}\else\pagestyle{plain}\fi}

\endinput
