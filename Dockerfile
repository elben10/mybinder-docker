FROM jupyter/base-notebook

RUN whoami
RUN ls

# Add conda deps
RUN conda env update -f environment.yml

# Enable extensions
RUN bash lab_extensions.sh && \
bash server_extensions.sh

# Update packages
RUN conda update --all --yes && \
    conda config --set auto_update_conda False
