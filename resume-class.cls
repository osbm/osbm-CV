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


\usepackage[default,scale=0.9]{opensans} % open sans font throughout the document
\usepackage[T1]{fontenc}


\usetikzlibrary{calc,positioning,backgrounds,matrix}



%---------------- Show page layout. Don't use in a real document!
\usepackage{showframe}
\renewcommand\ShowFrameLinethickness{0.15pt}
\renewcommand*\ShowFrameColor{\color{red}}
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




\newcommand{\drawsidebar}{
    \begin{tikzpicture}[remember picture,overlay]
        \fill[sidecolor] (current page.north west)
        rectangle ++(\sidewidth+2\margin,-\paperheight);
    \end{tikzpicture}
}



%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	%------------------------------------------------

	\begin{textblock}{5}(0.5, 0.2)
			
		%------------------------------------------------
		\blindtext[1]
		
        \begin{center}
            \begin{tikzpicture}[x=\imagescale,y=-\imagescale]
                \clip (600/2, 567/2) circle (567/2);
                \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
            \end{tikzpicture}
        \end{center}
    

	\end{textblock}
}


% set footer

\pagestyle{fancy}                               % set the pagestyle to fancy to include headers and footers
\fancyhf{}                                      % clear the header and footer
\fancyfoot[C]{This document is written in \LaTeX. $\odot$ Last update \today}                         % add page number to the footer

