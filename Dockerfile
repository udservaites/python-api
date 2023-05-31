ARG PIP_INDEX_URL
ARG ACE_DT_VERSION=v1.1.0
FROM reg.git.act3-ace.com/ace/data/tool/ace-dt:${ACE_DT_VERSION} as acedt

#########################################################################################
# develop stage contains base requirements. Used as base for all other stages.
#
#   (1) APT Install deps for the base development only - i.e. items for running code
#   (2) Install the repository requirements
#   (3) logs file created
#
#########################################################################################

FROM docker.io/python:3.10.5 as develop

# Re-declare ARGs
ARG PIP_INDEX_URL

ENV PIP_NO_CACHE_DIR=off \
    # Poetry version
    POETRY_VERSION=1.3.0 \
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # paths
    # this is where our requirements + virtual environment will live
    WORKDIR="/opt/project" \
    VENV_PATH="/opt/project/.venv"

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install poetry
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=${POETRY_HOME} POETRY_VERSION=${POETRY_VERSION} python3 - && \
    /usr/local/bin/python -m pip install --upgrade pip

# Test that it is installed correctly
RUN poetry --version

# set work dir
WORKDIR ${WORKDIR}

#########################################################################################
# Python package installs 
#########################################################################################
FROM develop as poetry_install

COPY . .
ENV PATH="${PATH}:${WORKDIR}/python_api"

RUN poetry install --without test,docs,lint,server

#########################################################################################
# Build stage packages from the source code
#########################################################################################
FROM poetry_install as build
ENV ROOT=/opt/libpython-api
ARG PIP_INDEX_URL

RUN poetry build && pip install --no-cache-dir dist/*.whl && mv dist/ "${ROOT}"

#########################################################################################
# Stage to create server image for deployement
#########################################################################################
FROM develop as development_server

ENV FASTAPI_ENV=development

# copy in poetry and venv
COPY --from=poetry_install $POETRY_HOME $POETRY_HOME
COPY --from=poetry_install $WORKDIR $WORKDIR

RUN poetry install --only server

WORKDIR ${WORKDIR}/python_api

EXPOSE 8000
ENV SHELL=/bin/bash
CMD [ "uvicorn", "main:app", "--reload", "--host=0.0.0.0", "--port=8000" ]

#########################################################################################
# Stage to create production server
#########################################################################################
FROM develop as production_server

COPY --from=poetry_install $WORKDIR $WORKDIR
WORKDIR ${WORKDIR}/python_api

CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "main:app"]

#########################################################################################
# the package stage contains everything required to install the project from another container build
#########################################################################################
FROM scratch as package
ENV ROOT=/opt/libpython-api
COPY --from=build ${ROOT} ${ROOT}

#########################################################################################
# the CI/CD pipeline uses the last stage by default so set your stage for CI/CD here with FROM your_ci_cd_stage as cicd
# this image should be able to run and test your source code
# python CI/CD jobs assume a python executable will be in the PATH to run all testing, documentation, etc.
#########################################################################################
FROM develop as cicd

# add ace-dt
COPY --from=acedt /ko-app/ace-dt /usr/local/bin/ace-dt

COPY --from=poetry_install $WORKDIR $WORKDIR

RUN poetry install --only test,docs,lint
