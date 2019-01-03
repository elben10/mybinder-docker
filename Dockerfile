FROM jupyter/base-notebook

ARG NB_USER
ARG NB_UID

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

# Add conda deps
RUN conda env update -f environment.yml

# Enable extensions
RUN bash lab_extensions.sh && \
    bash server_extensions.sh

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False
