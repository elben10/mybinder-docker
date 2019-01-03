FROM jupyter/scipy-notebook

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}

# Install system dependencies
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     {ADD PACKAGE HERE} && \
#     rm -rf /var/lib/apt/lists/

USER ${NB_USER} 

#Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False

# Add conda deps
RUN conda env update -f environment.yml

# Install extensions
RUN jupyter labextension install @jupyterlab/google-drive && \
    jupyter labextension install @jupyterlab/git && \
    jupyter labextension install @jupyterlab/github && \
    jupyter labextension install @jupyterlab/latex && \
    jupyter labextension install jupyterlab_bokeh && \
    jupyter labextension install jupyterlab/drawio

# Enable server extensions
RUN jupyter serverextension enable --py jupyterlab_git && \
    jupyter serverextension enable --sys-prefix jupyterlab_github && \
    jupyter serverextension enable --sys-prefix jupyterlab_latex
