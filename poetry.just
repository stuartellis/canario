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

# Install the Poetry tool and plug-ins
add:
    #!/usr/bin/env sh
    set -eu
    PIPX_TOOL_NAME=poetry
    PIPX_TOOL_VERSION=$(python3 -c "import tomllib; print(tomllib.load(open('pyproject.toml', 'rb'))['tool']['project']['utilities']['$PIPX_TOOL_NAME'])")
    pipx install --force $PIPX_TOOL_NAME==$PIPX_TOOL_VERSION
    pipx inject --force $PIPX_TOOL_NAME poetry-plugin-export

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

# Remove the Poetry tool and plug-ins
rm:
    @pipx uninstall poetry

# Install Poetry dependencies into project
setup:
    @poetry install

# Run tests in the Poetry environment
test:
    @poetry run pytest
