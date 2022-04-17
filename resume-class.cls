% Class 
\ProvidesClass{resume-class}[2022/04/17 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e} 

\usepackage{titlesec} % to reformat sections

%---------------- Show page layout. Don't use in a real document!
\usepackage{showframe}
\renewcommand\ShowFrameLinethickness{0.15pt}
\renewcommand*\ShowFrameColor{\color{red}}
%---------------------------------------------------------------%


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

\newcommand{\footer}{
    \normalsize
    \begin{center}
        This document is written in \LaTeX.
        $\odot$ 
        Last update \today
    \end{center}
}