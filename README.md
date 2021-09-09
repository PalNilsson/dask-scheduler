# dask-scheduler
Docker image scripts for a Dask scheduler.

This image can be used to start a Dask scheduler. It is based on the continuumio/miniconda3:4.8.2 image and installs Dask version 2021.7.2.

Note: currently there's a number of other tools installed as well, that should be removed..

## Build instructions

1. docker build -t dask-worker:latest .
2. Identify the < build tag > at the bottom of the stdout from the previous step
3. docker tag < build tag > < docker username >/dask-worker:latest
4. docker push < docker username >/dask-worker:latest
