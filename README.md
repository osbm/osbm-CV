# my resume

[![Build and publish documents](https://github.com/osbm/osbm-CV/actions/workflows/build_publish_documents.yml/badge.svg?branch=main)](https://github.com/osbm/osbm-CV/actions/workflows/build_publish_documents.yml)

You can view the latest version of my resume [here](https://osbm.github.io/osbm-CV/resume.pdf)

When I update this [Dockerfile](https://github.com/osbm/osbm-CV/blob/main/Dockerfile), the repository automatically updates the [docker image on dockerhub](https://hub.docker.com/r/osbm/osbm-cv) with github actions. Isn't it awesome. :)

---

Build using docker

```
docker build -t osbm-cv .
docker run --rm -i -v $(pwd):/data osbm-cv xelatex main.tex
```

Or you could just copy `resume.tex` file and `resume-class.cls` files to [Overleaf](https://www.overleaf.com/) and build it on the browser. 