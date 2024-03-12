# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Recipes for MkDocs
#
# https://www.mkdocs.org/

# Build documentation
[no-cd]
build:
    @mkdocs build --strict

# Delete generated documentation
[no-cd]
clean:
    #!/usr/bin/env sh
    set -eu
    MKDOCS_OUTPUT_DIRS="site"
    echo "Removing generated MkDocs documentation..."
    for MKDOCS_DIR in $MKDOCS_OUTPUT_DIRS
    do
      rm -fr $MKDOCS_DIR
      echo "Removed $MKDOCS_DIR directory"
    done

# Run development server for documentation
[no-cd]
serve:
    @mkdocs serve
