# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Recipes for Poetry
#
# https://python-poetry.org/

# Display information about the Poetry tool
about:
    @poetry about

# Delete generated files for Python and Poetry
clean:
    #!/usr/bin/env sh
    set -eu
    PY_CACHES=".coverage .mypy_cache .pytest_cache .ruff_cache */**/__pycache__"
    echo "Removing Python caches..."
    for PY_CACHE in $PY_CACHES
    do
      rm -fr $PY_CACHE
      echo "Removed $PY_CACHE"
    done

# Run test coverage analysis in Poetry environment
coverage:
    @poetry run coverage run -m pytest

# Export project dependencies to requirements.txt
export:
    @poetry export --quiet --output=requirements.txt

# Install Poetry dependencies into project
setup:
    @poetry install

# Run tests in the Poetry environment
test:
    @poetry run pytest
