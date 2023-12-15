#!/usr/bin/env bash

# usage: bash juno-scripts/get_version.sh -c "uni-6" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -r "https://uni-rpc.reece.sh:443" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj


source juno-scripts/common.sh


smart_query '{"get_version":{}}'