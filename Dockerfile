FROM docker.io/python:3.10.5 as develop


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# install python packages

# expose port

# command or entrypoint

