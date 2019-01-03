FROM jupyter/scipy-notebook

USER root

# Install R and Rstudio Server dependencies
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	libapparmor1 \
	libedit2 \
	libssl1.0.0 \
	lsb-release \
	psmisc \
	r-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install Rstudio Server
RUN export RSTUDIO_PKG=rstudio-server-$(wget -qO- https://download2.rstudio.org/current.ver)-amd64.deb && \
    wget http://download2.rstudio.org/${RSTUDIO_PKG} && \
    dpkg -i ${RSTUDIO_PKG} && \
    rm ${RSTUDIO_PKG}

USER $NB_USER

# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False

# Install pip dependencies
RUN pip install \
    jupyterlab-git \
    jupyterlab_github \
    jupyterlab_latex \
    https://github.com/elben10/jupyterlab-rstudio

# Install extensions
RUN jupyter labextension install @jupyterlab/google-drive && \
    jupyter labextension install @jupyterlab/git && \
    jupyter labextension install @jupyterlab/github && \
    jupyter labextension install @jupyterlab/latex && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install jupyterlab_bokeh && \
    jupyter labextension install jupyterlab-server-proxy
    
# Enable server extensions
RUN jupyter serverextension enable --py jupyterlab_git && \
    jupyter serverextension enable --sys-prefix jupyterlab_github && \
    jupyter serverextension enable --sys-prefix jupyterlab_latex
