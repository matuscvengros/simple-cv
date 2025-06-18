% Author:
% Matus Cvengros

% ---------------------------------------------------------------
%	Class Settings
% ---------------------------------------------------------------
\ProvidesClass{simple-cv}[2025-06-16 v1.0.0]
\NeedsTeXFormat{LaTeX2e}

\RequirePackage{keyval}

\newif\ifcv@sourcesanspro
\cv@sourcesansprofalse

\DeclareOption{font=sourcesanspro}{\cv@sourcesansprotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

\LoadClass{article}

% ---------------------------------------------------------------
%	Packages
% ---------------------------------------------------------------
\input{glyphtounicode}
\pdfgentounicode=1
\RequirePackage[english]{babel}								% language typography
\RequirePackage[utf8]{inputenc}								% input encoding
\RequirePackage[T1]{fontenc}								% output encoding
% Conditionally load Source Sans Pro
\ifcv@sourcesanspro
	\RequirePackage[default]{sourcesanspro}					% Source Sans Pro
	\newcommand*{\fontlight}{\fontseries{l}\selectfont}		% definition of Source Sans Pro Light
	\RequirePackage{sansmath}								% Sans Serif in math (close approximate)
	\sansmath												% enable for the math environment
\else
	\RequirePackage{lmodern} 								% use a bit nicer version of Computer Modern
\fi
\RequirePackage{geometry}									% for layout settings
\RequirePackage{fancyhdr}									% for ehader and footer settings
\RequirePackage{lastpage} 									% for page numbering
\RequirePackage{xcolor}										% to define custom colors
\RequirePackage{fontawesome5}								% for icons
\RequirePackage[
	colorlinks=true,
	urlcolor=linkcolor
]
{hyperref}													% links
\RequirePackage{csquotes}									% quotation marks
\RequirePackage{changepage}									% for adjustwidth
\RequirePackage{array}										% for some table manipulation commands
\RequirePackage{enumitem}									% to change line spacings between itemize items
\setlist[itemize]{
	itemsep=0.1em,
	topsep=0.1em
}
\RequirePackage{xifthen}									% to add if-else statements
\RequirePackage{ragged2e}									% to use \justifying inside tabular* cells
\RequirePackage{graphicx}									% images
\RequirePackage{mwe}										% includes example-image, example-image-a
\RequirePackage{xparse}										% parsing for multi-optional commands

% ---------------------------------------------------------------
%	Layout Configuration
% ---------------------------------------------------------------
% Configure page margins with geometry
\geometry{left=1.5cm, top=1cm, right=1.5cm, bottom=2cm, footskip=1.0 cm}
% Use fancy for all pages globally
\pagestyle{fancy}
% Clear all header & footer fields
\fancyhf{}

% ---------------------------------------------------------------
%	Colors
% ---------------------------------------------------------------
\definecolor{lightgray}{gray}{0.4}
\definecolor{darkgray}{gray}{0.2}
\definecolor{linkcolor}{RGB}{0, 79, 144}

% ---------------------------------------------------------------
%	Styles for the CV Elements
% ---------------------------------------------------------------
% Header separation of social media links
\newcommand*{\headersocialsep}{\quad\textbar\quad}

% Footer text
\newcommand*{\footerstyle}[1]{{\footnotesize\scshape\color{lightgray} #1}}

% Style intended for experience and education entries
\newcommand*{\companystyle}[1]{\normalsize\bfseries #1}
\newcommand*{\locationstyle}[1]{\normalsize\fontlight #1}
\newcommand*{\rolestyle}[1]{\small\normalfont\color{darkgray}\scshape #1}
\newcommand*{\datestyle}[1]{\small\normalfont\color{darkgray}\itshape #1}

% ---------------------------------------------------------------
%	Class Variables
% ---------------------------------------------------------------
% First and last name
\newcommand*{\@firstname}{}
\newcommand*{\@lastname}{}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\printname}{\@firstname~\@lastname}
% Define other personal info
\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\address}[1]{\def\@address{#1}}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\github}[1]{\def\@github{#1}}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}
% Quote
\renewcommand*{\quote}[1]{\def\@quote{#1}}

% ---------------------------------------------------------------
%	Utilities Configuration
% ---------------------------------------------------------------
% Definition for the width of the main entry text
\newlength{\entrywidth}
\setlength{\entrywidth}{\dimexpr\textwidth - 0.5cm\relax}

% Column types in tabular environments
\newcolumntype{L}[1]{>{\normalsize\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{C}[1]{>{\normalsize\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]{>{\normalsize\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

% ---------------------------------------------------------------
%	Header Configuration
% ---------------------------------------------------------------
% Remove horizontal offset for header and footer
\fancyhfoffset{0em}
% Remove header rule
\renewcommand{\headrulewidth}{0pt}

% Create header command
\newcommand*{\makecvheader}{%
	\centering%
	{\Huge\@firstname~\bfseries\@lastname}\\[0.5em]%
	{\scshape\@position}\\[0.5em]%
	{\footnotesize\color{darkgray}\textit\@address}\\[0.25em]%
	{\footnotesize%
		\faMobile~\@mobile
		\headersocialsep
		\href{mailto:\@email}{\color{black}\faEnvelope~\@email}
		\headersocialsep
		\href{https://www.github.com/\@github}{\color{black}\faGithub~\@github}
		\headersocialsep
		\href{https://www.linkedin.com/in/\@linkedin}{\color{black}\faLinkedin~\@linkedin}
	}\\[0.5cm]%
	{\color{darkgray}\textit\@quote}\\[0.5cm]%
}

% ---------------------------------------------------------------
%	Footer Configuration
% ---------------------------------------------------------------
\newcommand*{\makecvfooter}{%
	\fancyfoot{}%
	\fancyfoot[L]{\footerstyle{\today}}%
	\fancyfoot[C]{\footerstyle{\printname~~~$\cdot$~~~Curriculum Vitae}}%
	\fancyfoot[R]{\footerstyle{\thepage~of~\hypersetup{linkcolor=lightgray}\pageref{LastPage}}}%
}

% ---------------------------------------------------------------
%	Section Configurations
% ---------------------------------------------------------------
% Definition of horizontal rule for a section title
\newcommand*{\sectionrulefill}[2][\textwidth]{%
	\noindent
	\makebox[#1][l]{\textbf{#2}~\leaders\hrule height 0.8pt \hfill}
}

% Section definition
\newcommand*{\cvsection}[1]{%
	\vspace*{1.5em}%
	\phantomsection%
	\raggedright%
	\sectionrulefill{\normalfont\bfseries\large #1}%
	\vspace*{-1em}%
}

% Subsection definition
\newcommand*{\cvsubsection}[1]{%
	\vspace*{1em}%
	\phantomsection%
	\raggedright%
	{\raggedright\mdseries\normalsize\scshape #1}%
}

% ---------------------------------------------------------------
%	Configuration of Environments for the Main Body of Text
% ---------------------------------------------------------------
\newenvironment{cventries}{%
	\vspace*{0em}%
	\normalfont%
	\small\fontlight%
	\begin{adjustwidth}{0.25cm}{0.25cm}%
}{\end{adjustwidth}}

% ---------------------------------------------------------------
%	Configuration of CV Entry Descriptors
% ---------------------------------------------------------------
% Main entry, intended for experience and education
% Usage: \cvcommonentry{<company>}{<role>}{<location>}{<date>}
\newcommand*{\cvcommonentry}[4]{%
	\vspace*{1em}%
	\setlength\tabcolsep{0pt}%
	\setlength{\extrarowheight}{0pt}%
	\begin{tabular*}{\entrywidth}{@{\extracolsep{\fill}} l r}
		\ifthenelse{\isempty{#1#3}}{%
			\rolestyle{#2} & \datestyle{#4}\\
		}{%
			\companystyle{#1} & \locationstyle{#3}\\
			\rolestyle{#2} & \datestyle{#4}\\
		}%
	\end{tabular*}%
	\\%
}

% Highlight entry
% Usage: \cvhighlightentry{<company>}{<role>}{<location>}{<date>}
\newcommand{\cvhighlightentrytrim}[7]{%
	\cvcommonentry{#3}{#4}{#5}{#6}%
	\vspace*{0.5em}
	\ifthenelse{\isempty{#1}}{%
		\noindent
		\begin{minipage}[t]{\entrywidth}%
			#7
		\end{minipage}%
	}{%
		\noindent%
		\begin{minipage}[c]{0.6\entrywidth}%
			#7
		\end{minipage}%
		\hfill%
		\begin{minipage}[c]{\dimexpr 0.4\entrywidth - \columnsep\relax}%
			\centering
			\includegraphics[width=\linewidth, height=3cm, keepaspectratio, clip, trim=#2]{#1}
		\end{minipage}%
	}%
}
\DeclareDocumentCommand{\cvhighlightentry}{O{} O{0 0 0 0} m m m m m}{%
	\cvhighlightentrytrim{#1}{#2}{#3}{#4}{#5}{#6}{#7}
}

% Simple entry intended for date and description text
% Usage: \cvsimpleentry{<date>}{<item>}{<description>}
\newcommand*{\cvsimpleentry}[3]{%
	\vspace*{0.5em}%
	\setlength\tabcolsep{0pt}%
	\setlength{\extrarowheight}{0pt}%
	\begin{tabular*}{\entrywidth}{R{0.1\entrywidth} C{0.02\entrywidth} L{0.88\entrywidth}}
		{\small\normalfont #1} & & {\justifying\small\mdseries #2} -- {\small\fontlight #3}\\
	\end{tabular*}%
	\\%
}

% Entry for achievements and awards
% Usage: \cvawardentry{<date>}{<award>}{<location>}{<description>}
\newcommand*{\cvawardentry}[4]{%
	\vspace*{0.5em}%
	\setlength\tabcolsep{0pt}%
	\setlength{\extrarowheight}{0pt}%
		\begin{tabular*}{\entrywidth}{R{0.1\entrywidth} C{0.02\entrywidth} L{0.66\entrywidth} C{0.02\entrywidth} R{0.2\entrywidth}}
		{\small\normalfont #1} & & {\justifying\small\mdseries #2} -- {\small\fontlight #4} & & \locationstyle{\small#3}\\
	\end{tabular*}%
	\\%
}

% Entry for skills
% Usage: \cvskillentry{<category>}{<details>}
\newcommand*{\cvskillentry}[2]{%
	\vspace*{0.5em}%
	\setlength\tabcolsep{0pt}%
	\setlength{\extrarowheight}{0pt}%
	\begin{tabular*}{\entrywidth}{R{0.2\entrywidth} C{0.02\entrywidth} L{0.78\entrywidth}}
		{\small\bfseries #1} & & {\small\fontlight #2}\\
	\end{tabular*}%
	\\%
}