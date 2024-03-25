# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT

"""
Runner module for the Canario application.

This module provides the runner for the application.
"""

from canario import config


def run() -> None:
    """
    Print a dummy value.

    Parameters
    ----------
    None

    Returns
    -------
    None
        Does not return a value.

    Raises
    ------
    None

    """
    settings = config.Settings()
    print(settings.model_dump())
