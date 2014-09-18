% tudletter is the letter-class as described in the TUD-Design-Manual
% It is based on (makes heavy use of) the KOMA-Class scrlttr2
% This class is provided "as is", the authors take no responsibility
% for any effects the style file has on the user, the user's life, family,
% pets, scientific or other career etc.
%
% When making changes to this style file or the accompanying package files
% please notify the authors:
% tuddesign@pro-kevin.de
% Good luck!

\def\fileversion{1.4}
\def\filedate{2009/08/11}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudletter}
 [\filedate\space\fileversion\space
   Clemens von Loewenich's and Joe Werner's TUD-Design package]

\gdef\TUD@adr@file{}
\edef\TUD@currname{\@currname}

\RequirePackage{xkeyval}
\RequirePackage{ifthen}

% Verarbeitung der Optionen
  \DeclareOptionX<\@currname>{accentcolor}{%
    \PassOptionsToPackage{accentcolor=#1}{tudcolours}}

  \DeclareOptionX<\@currname>{blackrule}{%
    \PassOptionsToPackage{blackrule}{tudcolours}}

  \DeclareOptionX<\@currname>{adr}{%
    \gdef\TUD@adr@file{#1}}

  \DeclareOptionX<\@currname>{nologo}{%
      \PassOptionsToPackage{nologo}{tudlettr_page}}

  \DeclareOptionX<\@currname>{logo}{%
    \ifthenelse{\equal{#1}{false}}{%
      \PassOptionsToPackage{nologo}{tudlettr_page}%
    }{%
      \PassOptionsToPackage{logo}{tudlettr_page}%
      \PassOptionsToClass{twoside=false}{scrlttr2}%
    }%
  }

  \DeclareOptionX<\@currname>{twoside}{%
    \ifthenelse{\equal{#1}{false}}{%
      \PassOptionsToClass{twoside=false}{scrlttr2}%
    }{%
      \PassOptionsToPackage{nologo}{tudlettr_page}%
      \PassOptionsToClass{twoside=true}{scrlttr2}%
    }%
  }

  \DeclareOptionX<\@currname>{fontsize}{%
    \ClassWarning{\@currname}{Option `fontsize=#1' not supported!}}

  \DeclareOptionX<\@currname>{paper}{%
    \ClassWarning{\@currname}{Option `paper=#1' not supported!}}

  \DeclareOptionX<\@currname>{landscape}{%
    \ClassWarning{\@currname}{Option `landscape' not supported!}}

  \DeclareOptionX*{%
    \ClassInfo{\@currname}{Unknown option `\CurrentOption'. Pass to scrreprt class.}
    \PassOptionsToClass{\CurrentOption}{scrlttr2}}

\ExecuteOptionsX<\@currname>{logo=true}
\ProcessOptionsX<\@currname>
\let\@classoptionslist\relax


% Load the KOMA-Class
%\PassOptionsToClass{paper=a4}{scrlttr2}
\PassOptionsToClass{parskip=false}{scrlttr2}
\LoadClass{scrlttr2}
%\KOMAoptions{paper=a4}

% Load the TUD-colourscheme
\RequirePackage{tudcolours}

% Waehle die TUD-Standardschriftarten
\RequirePackage{tudlettr_fonts}

% Load pagestyle (bars, papersize) 
\RequirePackage{tudlettr_page}

%make sure we do not break the horizontal raster
\flushbottom

\AtBeginDocument{%
  \InputIfFileExists{\TUD@currname.adr}{%
    \ClassInfo{\TUD@currname}{Use global address file `\TUD@currname.adr'.}%
  }{%
    \ClassInfo{\TUD@currname}{No global address file `\TUD@currname.adr' found.}%
  }%
  \ifx\TUD@adr@file\@empty\else%
    \InputIfFileExists{\TUD@adr@file}{%
      \ClassInfo{\TUD@currname}{Use address file  form option `adr=\TUD@adr@file'.}%
    }{%
      \InputIfFileExists{\TUD@adr@file.adr}{%
        \ClassInfo{\TUD@currname}{Use address file form option `adr=\TUD@adr@file'.}%
      }{%
        \ClassError{\TUD@currname}{No address file from option `adr=\TUD@adr@file' found.}%
      }%
    }%
  \fi%
  \InputIfFileExists{\jobname.adr}{%
    \ClassInfo{\TUD@currname}{Use local address file `\jobname.adr'.}%
  }{%
    \ClassInfo{\TUD@currname}{No local address file `\jobname.adr' found.}%
  }%
}

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

\endinput
