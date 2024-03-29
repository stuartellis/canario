# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Builds container image for a Python application with Poetry
#

ARG APP_PATH=/opt/app
ARG DEBIAN_FRONTEND=noninteractive
ARG BASE_IMAGE

## Base stage

FROM ${BASE_IMAGE} as core

ARG DEBIAN_FRONTEND

RUN apt-get update -q && \
    apt-get upgrade -qy

FROM core as poetry

ARG APP_NAME
ARG APP_PATH
ARG DEBIAN_FRONTEND
ARG PYTHON_VERSION
ARG POETRY_VERSION

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1
ENV \
    POETRY_VERSION=$POETRY_VERSION \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1

RUN apt-get install --no-install-recommends -qy \
        curl \
        build-essential

RUN curl -sSL curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

# Import our project files
WORKDIR $APP_PATH
COPY ./poetry.lock ./pyproject.toml ./README.md ./
COPY ./src/${APP_NAME} ./src/${APP_NAME}

## Builder stage

FROM poetry AS app_builder

ARG APP_PATH

WORKDIR $APP_PATH
RUN poetry build --format wheel

## Runner stage

FROM core as runner
ARG APP_NAME
ARG APP_PATH

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1


ENV \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

RUN rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 appusers \
  && useradd --uid 1000 --gid appusers --shell /bin/sh --create-home appuser

RUN mkdir -p ${APP_PATH} && chown appuser:appusers ${APP_PATH}

WORKDIR ${APP_PATH}
USER appuser

COPY --from=app_builder ${APP_PATH}/dist/*.whl ./
RUN pip install --user ./${APP_NAME}*.whl

HEALTHCHECK NONE

CMD ["python3", "-m", "canario"]
