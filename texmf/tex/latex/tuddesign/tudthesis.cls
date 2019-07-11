% tudreport is the report-class as described in the TUD-Design-Manual
% It is based on (makes heavy use of) the KOMA-Class scrreprt
% This class is provided "as is", the authors take no responsibility
% for any effects the style file has on the user, the user's life, family,
% pets, scientific or other career etc.
% 
% When making changes to this style file or the accompanying package files
% please notify the authors:
% tud-design@pro-kevin.de
% Good luck!

\def\fileversion{0.96}
\def\filedate{2009/05/15}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudthesis}
 [\filedate\space\fileversion\space 
   Joe Werner's TUD-Design-Manual package]

\newif\ifTUD@thesis@type \TUD@thesis@typefalse

\RequirePackage{xkeyval}
% Verarbeitung der Optionen

 \DeclareOptionX<\@currname>{type}{%
   \TUD@thesis@typetrue
   \PassOptionsToPackage{type=#1}{tudthess_title}}

 \DeclareOptionX<\@currname>{dr}{%
   \PassOptionsToPackage{dr=#1}{tudthess_title}}

 \DeclareOptionX*{%
   \ClassInfo{\@currname}{Unknown option '\CurrentOption`. Pass to tudreport class.}
   \PassOptionsToClass{\CurrentOption}{tudreport}}

\ProcessOptionsX<\@currname>
%\let\@classoptionslist\relax

\ifTUD@thesis@type\else
  \ClassError{\@currname}{Missing option 'type=<thesis type>` !}
\fi

% Load the KOMA-Class
\LoadClass{tudreport}
\RequirePackage{tudthess_title}

\date{%
  \ifcase\month%
    \or Januar%
    \or Februar%
    \or M\"arz%
    \or April%
    \or Mai%
    \or Juni%
    \or Juli%
    \or August%
    \or September%
    \or Oktober%
    \or November%
    \or Dezember%
  \fi\ \number\year%
}

\endinput
