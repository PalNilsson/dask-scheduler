# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Authors:
# - Paul Nilsson, paul.nilsson@cern.ch, 2023

ARG BASE_CONTAINER=condaforge/mambaforge:latest
FROM $BASE_CONTAINER

MAINTAINER Paul Nilsson
USER root

# Tag for selecting the dask version
ARG DASK_VERSION

# Tag for selecting a package to be pip installed (e.g. dask-ml[complete])
ARG PACKAGE

ARG python=3.9
ARG release

SHELL ["/bin/bash", "-c"]

ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=${python}

RUN mamba install -y \
    "mamba>=0.27.0" \
    python=${PYTHON_VERSION} \
    nomkl \
    cmake \
    dask=$DASK_VERSION \
    cachey \
    streamz \
    && mamba clean -tipy \
    && find /opt/conda/ -type f,l -name '*.a' -delete \
    && find /opt/conda/ -type f,l -name '*.pyc' -delete \
    && find /opt/conda/ -type f,l -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -type f,l -name '*.js' -not -name '*.min.js' -delete \
    && rm -rf /opt/conda/pkgs

COPY prepare.sh /usr/bin/prepare.sh
RUN mkdir /opt/app

# Activate the environment, and make sure it's activated:
RUN conda init bash
COPY environment.yml /opt/app/.
RUN conda env create -f /opt/app/environment.yml
RUN activate myenv

RUN chmod +x /usr/bin/prepare.sh

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/prepare.sh"]
