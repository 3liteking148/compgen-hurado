#!/bin/bash

set -e

pycommand=$1

if [ -z "$pycommand" ]; then
    pycommand=python3
fi

echo "Installing using python command '$pycommand'"
echo

if [ ! -x "$(command -v $pycommand)" ]; then
    echo "Command '$pycommand' not found!"
    exit 1
fi


# ensure pip is present
if ! $pycommand -m ensurepip; then
    echo "Can't run ensurepip. It is now your responsibility to ensure that $pycommand -m pip is present!!!"
    echo "Try: 'wget https://bootstrap.pypa.io/get-pip.py && $pycommand get-pip.py'"
fi

# install setuptools, pip, and kg
$pycommand -m pip install --upgrade setuptools
$pycommand -m pip install --upgrade pip
$pycommand -m pip install .
$pycommand setup.py clean --all

echo
activate-global-python-argcomplete && echo "AUTOCOMPLETE READY" || echo "Skipping autocomplete"
echo "DONE"
