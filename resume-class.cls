% Class 
\ProvidesClass{resume-class}[2022/04/18 resume class]
\LoadClass[11pt]{article}
\NeedsTeXFormat{LaTeX2e} 

\usepackage{blindtext}   % lorem impsum
\usepackage{calc}        % to use complex node combinations (e.g. fractions of node coordinates)
\usepackage{tikz}
\usepackage{titlesec}    % to reformat sections
\usepackage{fontspec}    % load external fonts
\usepackage{fancyhdr}    % headers and footers
\RequirePackage[absolute,overlay]{textpos}
\usepackage{fontawesome5}
\RequirePackage{hyperref}


\definecolor{urlcolor}{HTML}{0000EE}

\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=urlcolor,
    pdftitle=Resume of Osman F. Bayram,
    pdfauthor=Osman F. Bayram,
    pdfpagemode=FullScreen,
}


\usepackage[default,scale=0.9]{opensans} % open sans font throughout the document
%\usepackage[T1]{fontenc}


\usetikzlibrary{calc,positioning,backgrounds,matrix}



%---------------- Show page layout. Don't use in a real document!
% \usepackage{showframe}
% \renewcommand\ShowFrameLinethickness{0.15pt}
% \renewcommand*\ShowFrameColor{\color{red}}
%---------------------------------------------------------------%

% define colors
\definecolor{sidecolor}{HTML}{E7E7E7}


% define length
\newlength\margin
\setlength\margin{1cm}

\newlength\sidewidth
\setlength\sidewidth{0.3\paperwidth-\margin}

\newlength\mainwidth
\setlength\mainwidth{\paperwidth-4\margin-\sidewidth}

\setlength{\parindent}{0pt} % Disable paragraph indentation

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}



% set a4paper width minimal options
\RequirePackage[
    left=\sidewidth+3\margin, 
    top=0.1cm,
    right=1cm,
    bottom=2cm,
    nohead
]{geometry}

\renewcommand{\headrulewidth}{0pt}



% reformat the \section
\titleformat{\section}
{\huge\bfseries\lowercase}
{}
{0em}
{}
 
% reformat the \subsection
\titleformat{\subsection}
{\Large\bfseries\lowercase}
{}
{0em}
{}

% define commands

\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\name}[1]{\renewcommand{\name}{#1}}
%\newcommand{\nameIPA}[1]{\renewcommand{\nameIPA}{#1}}
\newcommand{\jobtitle}[1]{\renewcommand{\jobtitle}{#1}}
%\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}

\newcommand{\website}[1]{\renewcommand{\website}{#1}}
\newcommand{\email}[1]{\renewcommand{\email}{#1}}
\newcommand{\github}[1]{\renewcommand{\github}{#1}}
\newcommand{\kaggle}[1]{\renewcommand{\kaggle}{#1}}
\newcommand{\linkedin}[1]{\renewcommand{\linkedin}{#1}}



\newcommand{\drawsidebar}{
    \begin{tikzpicture}[remember picture,overlay]
        \fill[sidecolor] (current page.north west)
        rectangle ++(\sidewidth+2\margin,-\paperheight);
    \end{tikzpicture}
}



%----------------------------------------------------------------------------------------
%     SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
    \begin{tikzpicture}[remember picture,overlay]
           \node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
    \end{tikzpicture}

    %------------------------------------------------

    \begin{textblock}{5}(0.5, 0.2)
            
        %------------------------------------------------
        
        \begin{center}
            \begin{tikzpicture}[x=\imagescale,y=-\imagescale]
                \clip (600/2, 567/2) circle (567/2);
                \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
            \end{tikzpicture}
        \end{center}
        
        \huge{\name}


        \begin{center}
            \Large{\jobtitle}
        \end{center}

        % -------------------------- contact info --------------------------
        
        \large
        \begin{itemize}
            \item[\faIcon{envelope}] \href{mailto:\email}{\underline{\email}}
            \item[\faIcon{globe}] \href{https://\website}{\underline{\website}}
            \item[\faIcon{github}] \href{https://github.com/\github}{\underline{github.com/\github}}
            \item[\faIcon{kaggle}] \href{https://kaggle.com/\kaggle}{\underline{kaggle.com/\kaggle}}
            \item[\faIcon{linkedin}] \href{https://linkedin.com/in/\linkedin}{\underline{linkedin.com/in/\linkedin}}
        \end{itemize}
        
        %------------------------------------------------
        %\section{About me}
        %\aboutme

        \section{skills}

    \end{textblock}
}


\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
    \end{tabular*}
}

\newcommand{\twentyitem}[4]{%
    #1&\parbox[t]{0.83\textwidth}{%
        \textbf{#2}%
        \hfill%
        {\footnotesize#3}\\%
        #4\vspace{\parsep}%
    }\\
}


\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
	}\\
}



% set footer

\pagestyle{fancy}                               % set the pagestyle to fancy to include headers and footers
\fancyhf{}                                      % clear the header and footer
\fancyfoot[C]{This document is written in \LaTeX. $\odot$ Last update \today}                         % add page number to the footer
