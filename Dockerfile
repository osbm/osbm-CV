FROM ubuntu:latest

# to prevent tzdata from asking questions
ENV DEBIAN_FRONTEND noninteractive 

# 5 gb is too much
RUN apt-get update && apt-get install -qy \
    texlive-full

WORKDIR /data
VOLUME [ "/data" ]