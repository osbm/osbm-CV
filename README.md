# osbm-CV

CV builder

[![Build and publish documents](https://github.com/osbm/osbm-CV/actions/workflows/build_publish_documents.yml/badge.svg?branch=main)](https://github.com/osbm/osbm-CV/actions/workflows/build_publish_documents.yml)

You can view the latest version of my resume [here](https://osbm.github.io/osbm-CV/resume.pdf)

Helpful articles
https://towardsdatascience.com/three-ways-to-create-dockernized-latex-environment-2534163ee0c4
https://medium.com/@kombustor/vs-code-docker-latex-setup-f84128c6f790

When I update this [Dockerfile](https://github.com/osbm/osbm-CV/blob/main/Dockerfile), the repository automatically updates the [docker image on dockerhub](https://hub.docker.com/r/osbm/osbm-cv) with github actions. Isn't it awesome. :)

---

Build using docker

```
docker build -t osbm-cv .
docker run --rm -i -v $(pwd):/data osbm-cv xelatex main.tex
```
