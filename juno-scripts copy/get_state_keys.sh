#!/usr/bin/env bash

# usage: bash juno-scripts/get_state_keys.sh -c "uni-6" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -r "https://uni-rpc.reece.sh:443"


source juno-scripts/common.sh


smart_query '{"get_state_keys":{}}'