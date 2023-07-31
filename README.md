# dask-scheduler
Docker image scripts for a Dask scheduler.

This image can be used to start a Dask scheduler. It is based on the continuumio/miniconda3:4.8.2 image and installs Dask version 2021.7.2.

## Build instructions

1. <code>docker build -t dask-scheduler:latest .</code>
2. <code>docker push < docker username >/dask-scheduler:latest</code>

The python and dask versions can explicitly be set. E.g.
<code>docker build -t dask-scheduler . --build-arg PYTHON_VERSION=3.9 --build-arg DASK_VERSION=2023.4.1</code>
