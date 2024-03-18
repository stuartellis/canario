# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Configuration for the just task runner
#
# See https://just.systems

mod containers
mod docs
mod poetry
mod pre-commit
mod project

# List available recipes
help:
    @just --unstable --list

# Install tools and dependencies, then set up environment for development
bootstrap:
    @just --unstable install
    @just --unstable setup

# Build artifacts
build:
    @just --unstable poetry::export
    @just --unstable containers::build

# Delete generated files
clean:
    @just --unstable docs::clean
    @just --unstable poetry::clean
    @just --unstable project::clean
    @just --unstable containers::clean

# Run test coverage analysis
coverage:
    @just --unstable poetry::coverage

# Display documentation in a Web browser
doc:
    @just --unstable docs::serve

# Format code
fmt:
    @just --unstable pre-commit::run ruff-format

# Install project tools and dependencies
install:
    @just --unstable poetry::add

# Run all checks
lint:
    @just --unstable pre-commit::check

# Set up environment for development
setup:
    @just --unstable pre-commit::setup
    @just --unstable poetry::setup

# Run tests for project
test:
    @just --unstable lint
    @just --unstable poetry::test
