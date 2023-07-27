FROM ubuntu:latest as init
RUN apt update
RUN apt install curl -y
RUN curl -sSL https://rover.apollo.dev/nix/latest | sh
RUN mkdir graph
COPY ./graph/build.sh .
RUN ["chmod", "+x", "/build.sh"]
CMD ./build.sh