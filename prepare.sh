#!/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Authors:
# - Paul Nilsson, paul.nilsson@cern.ch, 2021

# Note: this file must be executable

set -x

if [ -e "/opt/app/environment.yml" ]; then
    echo "environment.yml found. Installing packages"
    /opt/conda/bin/conda env update -f /opt/app/environment.yml
    conda init bash
    activate myenv
else
    echo "no environment.yml"
fi

if [[ -z "$PACKAGE" ]] ; then
  echo "No additional package"
else
  python -m pip install --no-cache-dir $PACKAGE
fi

echo "starting dask scheduler"
dask-scheduler --idle-timeout 900
echo "finished dask scheduler"
