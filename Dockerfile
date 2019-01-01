FROM frolvlad/alpine-glibc:alpine-3.8
ARG NB_USER
ARG NB_UID

RUN echo ${NB_UID} && \
    echo $NB_UID && \
    echo ${NB_USER} && \
    echo $NB_USER

