#!/usr/bin/env bash

set -o errexit # Error on any command error
set -o nounset # Fail if variable unbound

# Welcome message to the user
echo "Provision SDK File Indentation Utility 2.0"

# Check the file was provided as a parameter
if [ $# -eq 0 ] ; then
    echo "No file was specified. Please specify at least 1 file as command line argument for this script."
    exit -1
fi


# Check that uncrustify is installed and is the right version
UNCRUSTIFY=$(which uncrustify)
if [ -z "${UNCRUSTIFY}" ] ; then
    echo "Error: couldn't find uncrustify"
    exit -1
else
    VERSION_MAJOR=$(uncrustify --version | cut -f2 -d' ' | cut -f1 -d.)
    VERSION_MINOR=$(uncrustify --version | cut -f2 -d' ' | cut -f2 -d.)
    VERSION_NUMBER=$(echo $(( ($VERSION_MAJOR << 8) | $VERSION_MINOR )))
    if [ $VERSION_NUMBER -lt 59 ] ; then
        echo "Error: your uncrustify is too old (${VERSION_MAJOR}.${VERSION_MINOR}), version 0.59 is required as minimum"
        exit -1
    fi
    echo "Uncrustitfy is as ${UNCRUSTIFY}";
fi


# Perform style correction
ROOT=$(git rev-parse --show-toplevel)

while [ $# -ne 0 ] ; do
    ${UNCRUSTIFY} -c "${ROOT}/tools/uncrustify/coding-style.cfg" --replace --no-backup $1 && rc=$? || rc=$?

    # Check for the correct exit status of uncrustify
    if [ ${rc} != 0 ] ; then
        echo "Error with exit status $? while trying to indent the file '$1'."
        echo "Please make sure you environment is configured properly."
    fi
    shift
done
