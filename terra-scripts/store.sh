#!/usr/bin/env bash

# usage: bash terra-scripts/store.sh -c "pisco-1" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -r "https://pisco-rpc.terra.dev:443"

source terra-scripts/common.sh

# store_contract CONTRACT_NAME
store_contract(){
    BALANCE_BEFORE="$(terrad query bank balances $DEV_ACCOUNT --node $RPC_URL --output json | jq -r '.balances[].amount')"

    OUTPUT="$(terrad tx wasm store "./artifacts/$1.wasm" --node $RPC_URL --from $DEV_ACCOUNT --gas-prices 0.1uluna --gas auto --gas-adjustment 1.6 -y --output json --chain-id $CHAIN_ID)"
    echo $OUTPUT
    BALANCE_AFTER="$(terrad query bank balances $DEV_ACCOUNT --node $RPC_URL --output json | jq -r '.balances[].amount')"
    SPENT=$(($BALANCE_BEFORE - $BALANCE_AFTER))
    echo "store_contract() uluna spent: " $SPENT
    TXHASH=$(echo $OUTPUT | jq -r '.txhash')
    echo $TXHASH

    sleep 10

    OUTPUT=$(terrad query tx $TXHASH --node $RPC_URL --output json)
    echo $OUTPUT

    CODE_ID=$(echo "$OUTPUT" | jq -r '.events[] | select(.type=="store_code") | .attributes[] | select(.key=="code_id") | .value')
  
}




# Upload PoC contract
store_contract "poc_contract_v2"

POC_CODE_ID=$CODE_ID



echo "------------------------------------------"
echo "POC_CODE_ID:" $POC_CODE_ID
echo "------------------------------------------"



