#!/usr/bin/env bash

# usage: bash juno-scripts/store.sh -c "uni-6" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -r "https://uni-rpc.reece.sh:443"

source juno-scripts/common.sh

# store_contract CONTRACT_NAME
store_contract(){

    OUTPUT="$(junod tx wasm store "./artifacts/$1.wasm" --node $RPC_URL --from $DEV_ACCOUNT --gas-prices 0.1ujunox --gas auto --gas-adjustment 1.6 -y --output json --chain-id $CHAIN_ID)"
    echo $OUTPUT

    TXHASH=$(echo $OUTPUT | jq -r '.txhash')
    echo $TXHASH

    sleep 10

    OUTPUT=$(junod query tx $TXHASH --node $RPC_URL --output json)
    echo $OUTPUT

    CODE_ID=$(echo "$OUTPUT" | jq -r '.events[] | select(.type=="store_code") | .attributes[] | select(.key=="code_id") | .value')
  
}




# Upload PoC contract
store_contract "poc_contract_v2"

POC_CODE_ID=$CODE_ID



echo "------------------------------------------"
echo "POC_CODE_ID:" $POC_CODE_ID
echo "------------------------------------------"



