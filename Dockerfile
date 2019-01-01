FROM frolvlad/alpine-glibc:alpine-3.8
ARG NB_USER
ARG NB_UID

ENV CONDA_DIR="${HOME}/conda"
ENV PATH="${CONDA_DIR}/bin:${PATH}"
ENV CONDA_VERSION="latest"
ENV CONDA_MD5_CHECKSUM="e1045ee415162f944b6aebfe560b8fee"

# Add user 
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Add system commands
RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates bash

# Add conda
RUN mkdir -p "${CONDA_DIR}" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "${CONDA_MD5_CHECKSUM}  miniconda.sh" | md5sum -c && \
    bash miniconda.sh -f -b -p "${CONDA_DIR}" && \
    echo "export PATH=${CONDA_DIR}/bin:\${PATH}" > /etc/profile.d/conda.sh && \
    rm miniconda.sh

