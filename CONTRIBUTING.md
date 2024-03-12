# Contributing to This Project

This project includes a [Dev Container](https://code.visualstudio.com/docs/devcontainers/containers) configuration to provide a development environment in Visual Studio Code. To use another type of environment, follow the instructions in the [section on preparing a development environment](#preparing-a-development-environment).

> *just:* This project includes sets of tasks as [just](https://just.systems) recipes. The Dev Container installs *just* and uses it to prepare the development environment.

---

## Table of Contents

- [Preparing a Development Environment](#preparing-a-development-environment)
- [Using the just Recipes](#using-the-just-recipes)
- [Testing](#testing)
- [Commit Messages](#commit-messages)
- [Versioning](#versioning)
- [Using Container Images](#using-container-images)
- [License](#license)

## Preparing a Development Environment

### Requirements

You may develop this project with macOS or any Linux system, including a WSL environment. The system must have these tools installed:

- [Git](https://www.git-scm.com/)
- [just 1.19.0 or above](https://just.systems/)
- [Python 3.11 or above](https://www.python.org/)
- [pipx](https://pipx.pypa.io/)

You must also set an environment variable *JUST_UNSTABLE* with the value *true*. This project currently requires the environment variable *JUST_UNSTABLE* because it uses [modules](https://just.systems/man/en/chapter_54.html), which are not yet covered by the API stability guarantee for *just*.

To set this variable for the Bash shell, add this to your shell configuration:

```shell
export JUST_UNSTABLE=true
```

To set this variable for the [fish](https://fishshell.com/) shell, add this to your *fish.config* file:

```shell
set -gx JUST_UNSTABLE true
```

> *Microsoft Windows:* Use the Dev Container to develop this project on Microsoft Windows.

### Setting Up The Project

Use *pipx* to install [Poetry](https://python-poetry.org/) and [pre-commit](https://pre-commit.com/). If you do not already have these tools, run the *just* recipe in this project to install them:

```shell
just install
```

Once you have the necessary tools, run the *just* recipe in this project to set up environments for development and tests:

```shell
just setup
```

## Using the just Recipes

This project includes sets of tasks as [just](https://just.systems) recipes. To see a list of the available recipes, type *just* in a terminal window:

```shell
just
```

The list shows you the top-level recipes, and then the recipes in *just* submodules.

### Standard Recipes

This project provides these top-level recipes:

```shell
bootstrap # Install tools and dependencies, then set up environment for development
build     # Build artifacts
clean     # Delete generated files
coverage  # Run test coverage analysis
doc       # Display documentation in a Web browser
fmt       # Format code
help      # List available recipes
install   # Install project tools and dependencies
lint      # Run all checks
setup     # Set up environment for development
test      # Run tests for project
```

Use the top-level recipes for normal operations. These call the appropriate recipes in the submodules in the correct order.

### Recipes in the Submodules

You may run a recipe in a *just* submodule. If a recipe accept parameters, the recipes list shows the default value of the parameter:

```shell
containers:
        build image-id="runner" # Build container image
        clean                   # Remove unused container images
        run image-id="runner"   # Run container image
        shell image-id="runner" # Open shell in container image
```

To run one of the tasks in a submodule, specify the submodule and the task, separated by *::* characters. For example, to run the *clean* recipe in the  *containers* submodule, enter this command:

```shell
just containers::clean
```

To override the default value for a parameter, specify the value after the recipe. For example, to specify the *image-id* parameter for the *containers::run* recipe as *db*, enter this command:

```shell
just containers::run db
```

## Testing

To run the tests for this project, use this command:

```shell
just test
```

This runs [pre-commit](https://pre-commit.com/) with the checks that are defined for the project before it runs the test suite.

To produce a test coverage report for this project, use this command:

```shell
just coverage
```

## Commit Messages

This project uses the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format for commit messages.

## Versioning

This project uses [Semantic Versioning 2.0](https://semver.org/spec/v2.0.0.html).

## Using Container Images

To build a container image for this project, use this command:

```shell
just build
```

Use the *containers* recipes to perform other tasks:

```shell
just --list -f containers/mod.just
Available recipes:
    build image-id="runner" # Build container image
    clean                   # Remove unused container images
    run image-id="runner"   # Run container image
    shell image-id="runner" # Open shell in container image
```

The *image-id* specifies the entry for the image in the *tool.project.containers* table of the *pyproject.toml* file. By default, recipes use the *app* container image, which provides the main application.

For example, to run the *app* container image, use this command:

```shell
just containers::run
```

## License

[MIT](https://spdx.org/licenses/MIT.html) © 2024-present Stuart Ellis.
