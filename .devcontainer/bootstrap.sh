#!/usr/bin/env sh

# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT

# Bootstrap Dev Container environment
#
# This installs just and immediately runs the bootstrap recipe.
#
# Example:
#
# sh .devcontainer/bootstrap.sh
#
# Website for just: https://just.systems

set -eu

BIN_DIR=$HOME/.local/bin
JUST_VERSION=$(python3 -c "import tomllib; print(tomllib.load(open('pyproject.toml', 'rb'))['tool']['project']['utilities']['just'])")

# Install just
sh ./.devcontainer/install-just.sh --to "$BIN_DIR" --tag "$JUST_VERSION" --force
just --completions bash >> "$HOME/.bashrc"

# Run just recipe
just bootstrap
