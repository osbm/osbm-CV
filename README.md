# osbm-CV
CV builder

[![Build the pdf](https://github.com/osbm/osbm-CV/actions/workflows/publish.yml/badge.svg)](https://github.com/osbm/osbm-CV/actions/workflows/publish.yml)

You can download the latest version of my resume [here](https://github.com/osbm/osbm-CV/raw/build/main.pdf)

Helpful articles
https://towardsdatascience.com/three-ways-to-create-dockernized-latex-environment-2534163ee0c4
https://medium.com/@kombustor/vs-code-docker-latex-setup-f84128c6f790

---

Build using docker
```
docker build -t osbm-cv .
docker run --rm -i -v $(pwd):/data osbm-cv pdflatex main.tex
```
