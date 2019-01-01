ARG NB_USER
ARG NB_UID

FROM frolvlad/alpine-glibc:alpine-3.8

RUN echo ${NB_UID} && \
    echo $NB_UID && \
    echo ${NB_USER} && \
    echo $NB_USER

