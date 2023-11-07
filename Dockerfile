FROM julia:latest

RUN apt update -y &&\
    apt install -y git

