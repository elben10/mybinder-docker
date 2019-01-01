ARG NB_USER
ARG NB_UID

FROM FROM frolvlad/alpine-glibc:alpine-3.8

RUN echo ${NB_UID}

