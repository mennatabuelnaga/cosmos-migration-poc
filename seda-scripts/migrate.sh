#!/usr/bin/env bash

# usage: bash seda-scripts/migrate.sh -c "sedachain" -d "seda1gs52z88gmek3ex73urxnf3p8jflywkd4e5ky2w" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj -r "http://127.0.0.1:26657" -i 4


source seda-scripts/common.sh


migrate_call $POC_CONTRACT_ADDRESS $CODE_ID '{"target_version":"2.0.0"}'