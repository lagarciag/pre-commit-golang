#!/bin/bash
#
# Capture and print stdout, since gofmt doesn't use proper exit codes
#
set -e
PYTHONPATH=${GOPATH}/src/github.hpe.com/GoP4Sim/clintsim/scripts
checkcode=${PYTHONPATH}/pyclintsim/code_checks.py

exec 5>&1
output="$(PYTHONPATH=$PYTHONPATH $checkcode -l "$@" )"
[[ -z "$output" ]]
