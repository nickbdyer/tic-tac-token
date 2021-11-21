#!/usr/bin/env bash

set -eo pipefail

# import the deployment helpers
. $(dirname $0)/common.sh

# Deploy.
TTTAddr=$(deploy TicTacToken "$ADMIN" "$PLAYERX" "$PLAYERO")
log "TicTacToken deployed at:" $TTTAddr
