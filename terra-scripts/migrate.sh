#!/usr/bin/env bash

# usage: bash terra-scripts/migrate.sh -c "pisco-1" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj -r "https://pisco-rpc.terra.dev:443" -i 4


source terra-scripts/common.sh


migrate_call $POC_CONTRACT_ADDRESS $CODE_ID '{"target_version":"2.0.0"}'