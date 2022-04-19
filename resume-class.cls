% Class 
\ProvidesClass{resume-class}[2022/04/18 resume class]
\LoadClass[11pt]{article}
\NeedsTeXFormat{LaTeX2e} 

\usepackage{blindtext}   % lorem impsum
\usepackage{calc}        % to use complex node combinations (e.g. fractions of node coordinates)
\usepackage{tikz}
\usepackage{titlesec}    % to reformat sections
\usepackage{fontspec}    % load external fonts
\usepackage{textpos}     % to use textpos

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


% set a4paper width minimal options
\usepackage[left=\sidewidth, top=1cm, bottom=1cm, right=1cm, nohead, nofoot]{geometry}



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


\pagestyle{empty} % to get rid of page number
\setlength{\parindent}{0pt} % Disable paragraph indentation

% define more lengths
\newlength\sidewidth
\setlength\sidewidth{0.3\paperwidth-\margin}

\newlength\mainwidth
\setlength\mainwidth{\paperwidth-4\margin-\sidewidth}

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

	\begin{textblock}{6}(0.5, 0.2)
			
		%------------------------------------------------
		
		
        \begin{center}
            \begin{tikzpicture}[x=\imagescale,y=-\imagescale]
                \clip (600/2, 567/2) circle (567/2);
                \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
            \end{tikzpicture}
        \end{center}
    

		%------------------------------------------------

		{\Huge\color{mainblue}\cvname}

		%------------------------------------------------

		{\Large\color{black!80}\cvjobtitle}

		%------------------------------------------------

		\renewcommand{\arraystretch}{1.6}
		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
			{\textsc{\Large\icon{\Info}} & \cvdate\\}
			{\textsc{\Large\icon{\Letter}} & \cvaddress\\}
			{\textsc{\Large\icon{\Telefon}} & \cvnumberphone\\}
			{\textsc{\Large\icon{\Mundus}} & \cvsite\\}
			{\textsc{\large\icon{@}} & \href{mailto:\cvmail}{\cvmail}}
		\end{tabular}

		%------------------------------------------------
		
		\ifthenelse{\equal{\aboutme}{}}{}{
			\profilesection{About me}
			\begin{flushleft}
				\aboutme
			\end{flushleft}
		}

		%------------------------------------------------

		\profilesection{Skills}

		\skills
		\skillstext
		\scriptsize
		(*)[The skill scale is from 0 (Fundamental Awareness) to 6 (Expert).]
			
		%------------------------------------------------
			
	\end{textblock}
}




\newcommand{\footer}{
    \normalsize
    \begin{center}
        This document is written in \LaTeX.
        $\odot$ 
        Last update \today
    \end{center}
}