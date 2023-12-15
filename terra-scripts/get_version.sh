#!/usr/bin/env bash

# usage: bash terra-scripts/get_version.sh -c "pisco-1" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -r "https://pisco-rpc.terra.dev:443" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj


source terra-scripts/common.sh


smart_query '{"get_version":{}}'