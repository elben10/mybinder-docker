FROM jupyter/base-notebook

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False

# Add conda deps
RUN conda env update -f environment.yml

# Enable extensions
RUN bash lab_extensions.sh && \
    bash server_extensions.sh
    
