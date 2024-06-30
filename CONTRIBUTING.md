<!--
SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>

SPDX-License-Identifier: MIT
-->

# Contributing to This Project

This project includes a [Dev Container](https://code.visualstudio.com/docs/devcontainers/containers) configuration to provide a development environment in Visual Studio Code. To use another type of environment, follow the instructions in the [section on preparing a development environment](#preparing-a-development-environment).

> *Tasks:* This project includes sets of tasks for the [Task](https://taskfile.dev/) tool. The Dev Container installs Task and uses it to prepare the development environment.

---

## Table of Contents

- [Preparing a Development Environment](#preparing-a-development-environment)
- [Using the Tasks](#using-the-tasks)
- [Using Container Images](#using-container-images)
- [Testing](#testing)
- [Commit Messages](#commit-messages)
- [Versioning](#versioning)
- [Licenses](#licenses)

## Preparing a Development Environment

### Requirements

You may develop this project with macOS or any Linux system, including a WSL environment. The system must have these tools installed:

- [Git](https://www.git-scm.com/)
- [Task](https://taskfile.dev/)
- [Python 3.12 or above](https://www.python.org/)
- [pipx](https://pipx.pypa.io/)

> *Microsoft Windows:* Use the Dev Container to develop this project on Microsoft Windows.

### Setting Up The Project

Once you have the necessary tools, run the task in this project to set up environments for development and tests:

```shell
task bootstrap
```

## Using the Tasks

This project includes sets of tasks. To see a list of the available tasks, type *task* in a terminal window:

```shell
task
```

### Standard Tasks

This project provides these tasks:

```shell
task: Available tasks for this project:
* bootstrap:               Set up environment for development      (aliases: setup)
* clean:                   Delete generated files for project
* docs:                    Run Website for project documentation
* fmt:                     Format code         (aliases: format)
* lint:                    Run all checks      (aliases: check)
* list:                    List available tasks
* test:                    Run tests
* update:                  Update project dependencies
```

Use the top-level tasks for normal operations. These call the appropriate tasks in the namespaces in the correct order.

### Tasks in the Namespaces

You may run a task in a namespace:

```shell
* py:lint:check:           Run ruff checks                             (aliases: py:lint:lint, py:lint:run)
* py:lint:fmt:             Run ruff formatter with import sorting      (aliases: py:lint:format)
* py:test:typehints:       Run mypy
* py:test:unit:            Run pytest
* venv:compile:            Compile Python requirements files
* venv:create:             Create Python virtual environment
* venv:delete:             Delete Python virtual environment
* venv:editable:           Install as editable to Python virtual environment
```

To run one of the tasks in a namespace, specify the namespace and the task, separated by *:* characters. For example, to run the *check* recipe in the *py:lint* namespace, enter this command:

```shell
task py:lint:check
```

To override the default value for a variable, specify the value after the recipe. For example, to specify the *IMAGE_ID* parameter for the *containers:run* recipe as *db*, enter this command:

```shell
task containers:run IMAGE_ID=db
```

## Testing

To run the tests for this project, use this command:

```shell
task test
```

This runs [pre-commit](https://pre-commit.com/) with the checks that are defined for the project before it runs the test suite.

To produce a test coverage report for this project, use this command:

## Using Container Images

To build a container image for this project, use this command:

```shell
task build
```

FIXME: Update containers tasks.

Use the *containers* recipes to perform other tasks:

```shell
just --list -f containers/mod.just
Available recipes:
    build IMAGE_ID="runner" # Build container image
    clean                   # Remove unused container images
    run IMAGE_ID="runner"   # Run container image
    shell IMAGE_ID="runner" # Open shell in container image
```

The *IMAGE_ID* specifies the entry for the image in the *tool.project.containers* table of the *pyproject.toml* file. By default, recipes use the *app* container image, which provides the main application.

For example, to run the *app* container image, use this command:

```shell
task containers:run
```

## Commit Messages

This project uses the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format for commit messages.

## Versioning

This project uses [Semantic Versioning 2.0](https://semver.org/spec/v2.0.0.html).

### Raising the Project Version

Use the *poetry version* subcommand to change the version of the project. For example, this bumps the version of the project by one minor release number:

```shell
poetry version minor
```

Once you have raised the project version, create a Git tag for the version from the *main* branch. For example, this creates a Git tag for version *0.2.0*:

```shell
git tag -am "Version 0.2.0" 0.2.0
```

## Licenses

This project is licensed under the [MIT](https://spdx.org/licenses/MIT.html) license © 2024-present Stuart Ellis.

Some configuration files in this project are licensed under the [Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) license. Each of these files has the [SPDX](https://spdx.dev) license identifier *CC0-1.0* either at the top of the file or in a *.license* file that has the same name as the file to be licensed.

This project is compliant with [version 3.0 of the REUSE Specification](https://reuse.software/spec/).
