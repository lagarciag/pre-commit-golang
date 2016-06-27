#!/bin/bash
#
# Capture and print stdout, since gofmt doesn't use proper exit codes
#
set -e

exec 5>&1
echo "$@" > debug.out 
output="$(codenanny lint --list "$@" | tee /dev/fd/5)"
echo $output > debug2.out
[[ -z "$output" ]]