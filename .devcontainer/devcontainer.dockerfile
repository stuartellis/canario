# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Builds Dev Container image for project
#

ARG VARIANT="bookworm"
FROM mcr.microsoft.com/devcontainers/base:1-${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get upgrade -qy
