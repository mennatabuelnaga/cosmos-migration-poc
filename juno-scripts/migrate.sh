#!/usr/bin/env bash

# usage: bash juno-scripts/migrate.sh -c "uni-6" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj -r "https://uni-rpc.reece.sh:443" -i 4


source juno-scripts/common.sh


migrate_call $POC_CONTRACT_ADDRESS $CODE_ID '{}'