FROM frolvlad/alpine-glibc:alpine-3.8
ARG NB_USER
ARG NB_UID

ENV HOME /home/${NB_USER}
ENV CONDA_DIR="${HOME}/conda"
ENV PATH="${CONDA_DIR}/bin:${PATH}"
ENV CONDA_VERSION="latest"
ENV CONDA_MD5_CHECKSUM="e1045ee415162f944b6aebfe560b8fee"

# Add system commands
RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates bash

# Add user 
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
# Add working directory
WORKDIR ${HOME}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# list files
RUN ls ${HOME}

# Add conda
RUN mkdir -p "${CONDA_DIR}" && \
    wget --quiet -O miniconda.sh "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" && \
    bash miniconda.sh -f -b -p "${CONDA_DIR}" && \
    rm miniconda.sh

# Add to profile
USER root
RUN echo "export PATH=${CONDA_DIR}/bin:\${PATH}" > /etc/profile.d/conda.sh
USER ${NB_USER}

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False && \
    rm -r "${CONDA_DIR}/pkgs/"

# Add conda deps
RUN conda env update -f environment.yml

# Enable extensions
RUN jupyter labextension install @ryantam626/jupyterlab_black && \
    jupyter serverextension enable --py jupyterlab_black
