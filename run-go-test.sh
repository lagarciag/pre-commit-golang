#!/bin/bash
set -e -u -o pipefail # Fail on error
#gometalinter --deadline=60s --vendor --cyclo-over=20 --dupl-threshold=100 ./...

GORACE="halt_on_error=1" LD_LIBRARY_PATH=/usr/local/lib go test -v -race github.hpe.com/GoP4Sim/clintsim/tests
