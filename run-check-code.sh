#!/bin/bash
#
# Capture and print stdout, since gofmt doesn't use proper exit codes
#
set -e
PYTHONPATH=${GOPATH}/src/github.hpe.com/GoP4Sim/clintsim/scripts
checktests=${PYTHONPATH}/pyclintsim/check_tests.py

exec 5>&1
output="$(PYTHONPATH=$PYTHONPATH python $checktests -l "$@" )"
[[ -z "$output" ]]
