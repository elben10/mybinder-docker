ARG BASE_CONTAINER=frolvlad/alpine-glibc:alpine-3.8
FROM $BASE_CONTAINER

ENV CONDA_DIR="/opt/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"
ENV CONDA_VERSION="latest"
ENV CONDA_MD5="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"

RUN echo "Downloading Miniconda3\n Version: ${CONDA_VERSION}"
