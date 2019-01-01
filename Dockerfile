# ARG NB_USER
# ARG NB_UID
# ARG BASE_CONTAINER=frolvlad/alpine-glibc:alpine-3.8
# FROM $BASE_CONTAINER

# ENV USER ${NB_USER}
# ENV HOME /home/${NB_USER}
# ENV CONDA_DIR="/opt/conda"
# ENV PATH="$CONDA_DIR/bin:$PATH"
# ENV CONDA_VERSION="latest"
# ENV CONDA_MD5="e1045ee415162f944b6aebfe560b8fee"

# # Install conda
# RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates bash && \
#     \
#     mkdir -p "$CONDA_DIR" && \
#     wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
#     echo "${CONDA_MD5}  miniconda.sh" | md5sum -c && \
#     bash miniconda.sh -f -b -p "$CONDA_DIR" && \
#     echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
#     rm miniconda.sh && \
#     \
#     conda update --all --yes && \
#     conda config --set auto_update_conda False && \
#     rm -r "$CONDA_DIR/pkgs/" && \
#     \
#     apk del --purge .build-dependencies && \
#     \
#     mkdir -p "$CONDA_DIR/locks" && \
#     chmod 777 "$CONDA_DIR/locks" && \
#     \
#     adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}
ARG NB_USER
ARG NB_UID
ARG BASE_CONTAINER=frolvlad/alpine-glibc:alpine-3.8
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

FROM $BASE_CONTAINER

# # Install bash

# # install the notebook package
# RUN pip install --no-cache --upgrade pip && \
#     pip install --no-cache notebook

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}
# WORKDIR ${HOME}
