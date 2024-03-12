# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Recipes for pre-commit
#
# https://pre-commit.com/

# Check the project with pre-commit
check:
    @pre-commit run --all-files

# Install pre-commit tool
add:
    #!/usr/bin/env sh
    set -eu
    PIPX_TOOL_NAME=pre-commit
    PIPX_TOOL_VERSION=$(python3 -c "import tomllib; print(tomllib.load(open('pyproject.toml', 'rb'))['tool']['project']['utilities']['$PIPX_TOOL_NAME'])")
    pipx install --force $PIPX_TOOL_NAME==$PIPX_TOOL_VERSION

# Delete generated files for pre-commit
clean:
    #!/usr/bin/env sh
    set -eu
    PRE_COMMIT_CACHES=".pre-commit-trivy-cache"
    echo "Removing pre-commit caches..."
    for PRE_COMMIT_CACHE in $PRE_COMMIT_CACHES
    do
      rm -fr $PRE_COMMIT_CACHES
      echo "Removed $PRE_COMMIT_CACHE"
    done

# Run a specific pre-commit check on the project
run hook-id:
    @pre-commit run "{{ hook-id }}" --all-files

# Remove pre-commit tool
rm:
    @pipx uninstall pre-commit

# Setup pre-commit for use
setup:
    @pre-commit install
