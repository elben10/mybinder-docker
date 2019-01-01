FROM frolvlad/alpine-glibc:alpine-3.8
ARG NB_USER
ARG NB_UID

ENV CONDA_DIR="/opt/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

# Add user 
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Add system commands
RUN apk add --no-cache --virtual=.build-dependencies curl ca-certificates bash
