#!/usr/bin/env bash

# usage: bash seda-scripts/store.sh -c "sedachain" -d "seda1gs52z88gmek3ex73urxnf3p8jflywkd4e5ky2w" -r "http://127.0.0.1:26657"

source seda-scripts/common.sh

# store_contract CONTRACT_NAME
store_contract(){

    OUTPUT="$(seda-chaind tx wasm store "./artifacts/$1.wasm" --node $RPC_URL --from $DEV_ACCOUNT  --keyring-backend test --gas-prices 0.1aseda --gas auto --gas-adjustment 1.6 -y --output json --chain-id $CHAIN_ID)"
    echo $OUTPUT

    TXHASH=$(echo $OUTPUT | jq -r '.txhash')
    echo $TXHASH

    sleep 10

    OUTPUT=$(seda-chaind query tx $TXHASH --node $RPC_URL --output json)
    echo $OUTPUT

    CODE_ID=$(echo "$OUTPUT" | jq -r '.events[] | select(.type=="store_code") | .attributes[] | select(.key=="code_id") | .value')
  
}




# Upload PoC contract
store_contract "poc_contract_v2"

POC_CODE_ID=$CODE_ID



echo "------------------------------------------"
echo "POC_CODE_ID:" $POC_CODE_ID
echo "------------------------------------------"



