FROM jupyter/base-notebook

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc

USER ${NB_USER} 

# Update packages
# RUN conda update --all --yes && \
#     conda config --set auto_update_conda False

# Add conda deps
RUN conda env update -f environment.yml

# Install extensions
RUN jupyter labextension install @jupyterlab/git

# Enable server extensions
RUN jupyter serverextension enable --py jupyterlab_git
