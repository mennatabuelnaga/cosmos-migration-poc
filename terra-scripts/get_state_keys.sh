#!/usr/bin/env bash

# usage: bash terra-scripts/get_state_keys.sh -c "pisco-1" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -r "https://pisco-rpc.terra.dev:443"


source terra-scripts/common.sh


smart_query '{"get_state_keys":{}}'