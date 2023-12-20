#!/usr/bin/env bash


# usage: bash terra-scripts/deploy.sh -c "pisco-1" -d terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy -r "https://pisco-rpc.terra.dev:443" 

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

# instantiate_contract CODE_ID INSTANTIATE_MSG LABEL
instantiate_contract() {
    BALANCE_BEFORE="$(terrad query bank balances $DEV_ACCOUNT --node $RPC_URL --output json | jq -r '.balances[].amount')"

    OUTPUT=$(terrad tx wasm instantiate $1 $2 --from $DEV_ACCOUNT --admin $DEV_ACCOUNT --node $RPC_URL --label "$3$1" --gas-prices 0.025uluna --gas auto --gas-adjustment 2 -y --output json --chain-id $CHAIN_ID)
    echo $OUTPUT
    BALANCE_AFTER="$(terrad query bank balances $DEV_ACCOUNT --node $RPC_URL --output json | jq -r '.balances[].amount')"
    SPENT=$(($BALANCE_BEFORE - $BALANCE_AFTER))
    echo "store_contract() uluna spent: " $SPENT
    TXHASH=$(echo "$OUTPUT" | jq -r '.txhash')

    sleep 10


    OUTPUT="$(terrad query tx $TXHASH --node $RPC_URL --output json)"
    echo $OUTPUT

    CONTRACT_ADDRESS=$(echo "$OUTPUT" | jq -r '.events[] | select(.type=="instantiate") | .attributes[] | select(.key=="_contract_address") | .value')


}


# Upload PoC contract
store_contract "poc_contract_v1"
# store_contract "poc_contract_v2"

POC_CODE_ID=$CODE_ID

# Instantiate PoC
LABEL=poc
INSTANTIATE_MSG='{}'
instantiate_contract $POC_CODE_ID $INSTANTIATE_MSG $LABEL
POC_CONTRACT_ADDRESS=$CONTRACT_ADDRESS



echo "------------------------------------------"
echo "POC_CODE_ID:" $POC_CODE_ID

echo "------------------------------------------"
echo "POC_CONTRACT_ADDRESS: " $POC_CONTRACT_ADDRESS

echo "------------------------------------------"



