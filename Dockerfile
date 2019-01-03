FROM jupyter/scipy-notebook

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False

# Install pip dependencies
RUN pip install \
    jupyterlab-git \
    jupyterlab_github \
    jupyterlab_latex

# Install extensions
RUN jupyter labextension install @jupyterlab/google-drive && \
    jupyter labextension install @jupyterlab/git && \
    jupyter labextension install @jupyterlab/github && \
    jupyter labextension install @jupyterlab/latex && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install jupyterlab_bokeh
    
# Enable server extensions
RUN jupyter serverextension enable --py jupyterlab_git && \
    jupyter serverextension enable --sys-prefix jupyterlab_github && \
    jupyter serverextension enable --sys-prefix jupyterlab_latex
