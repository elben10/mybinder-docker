FROM jupyter/base-notebook

ARG NB_USER
ARG NB_UID

ENV HOME /home/${NB_USER}


# Add user
USER root
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

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False && \
    rm -r "${CONDA_DIR}/pkgs/"

# Add conda deps
RUN conda env update -f environment.yml

# Enable extensions
RUN bash lab_extensions.sh && \
    bash server_extensions.sh
    
