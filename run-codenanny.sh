#!/bin/bash
#
# Capture and print stdout, since gofmt doesn't use proper exit codes
#
set -e

exec 5>&1
output="$(codenanny lint --list "$@" | tee /dev/fd/5)"
[[ -z "$output" ]]
