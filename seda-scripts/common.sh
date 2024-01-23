while getopts ":c:d:r:p:i:" opt; do  
case $opt in
    c) CHAIN_ID=$OPTARG;;  
    d) DEV_ACCOUNT=$OPTARG;;  
    r) RPC_URL=$OPTARG;;  
    p) POC_CONTRACT_ADDRESS=$OPTARG;;  
    i) CODE_ID=$OPTARG;;  
    *) usage  
esac  
done  

# wasm_execute <EXECUTE_MSG> <AMOUNT>
wasm_execute() {

    OUTPUT="$(seda-chaind tx wasm execute $POC_CONTRACT_ADDRESS $1 --from $DEV_ACCOUNT --node $RPC_URL  --keyring-backend test --gas-prices 0.025aseda --gas auto --gas-adjustment 1.5 -y --output json --chain-id $CHAIN_ID --amount "$2"seda)"
    echo $OUTPUT

    TXHASH=$(echo "$OUTPUT" | jq -r '.txhash')
    echo $TXHASH

    sleep 10
}

# sudo_call <SUDO_MSG>
sudo_call() {

    OUTPUT="$(seda-chaind tx wasm submit-proposal sudo-contract $POC_CONTRACT_ADDRESS $1 --from $DEV_ACCOUNT --keyring-backend test --node $RPC_URL --gas-prices 0.025aseda --gas auto --gas-adjustment 1.3 -y --output json --chain-id $CHAIN_ID --title "sudo-execute"  --summary "post_results" --deposit "$2"seda)"
    echo $OUTPUT

    TXHASH=$(echo "$OUTPUT" | jq -r '.txhash')
    echo $TXHASH

    sleep 10
}

# migrate_call <OLD_CONTRACT_ADDRESS> <NEW_CODE_ID> <MIGRATION_MSG>
migrate_call() {
    echo "address" $1
    echo "id" $2
    echo "msg" $3
    OUTPUT="$(seda-chaind tx wasm migrate $1 $2 $3 --node $RPC_URL --output json --from $DEV_ACCOUNT --keyring-backend test --node $RPC_URL --gas-prices 0.025aseda --gas auto --gas-adjustment 1.3 -y --output json --chain-id $CHAIN_ID)"
    echo $OUTPUT

    sleep 10
}






# smart_query <QUERY_MSG>
smart_query() {

    OUTPUT="$(seda-chaind query wasm contract-state smart $POC_CONTRACT_ADDRESS $1 --node $RPC_URL --output json)"
    echo $OUTPUT

    sleep 10
}

# raw_query
raw_query_contract() {

    OUTPUT="$(seda-chaind query wasm contract-state raw $POC_CONTRACT_ADDRESS 636F6E74726163745F696E666F --node $RPC_URL --output json | jq  -r .data | base64 -d | jq)"
    echo $OUTPUT

    sleep 10
}



# Function to generate a random array of strings as JSON
generate_random_array_json() {
    local array_size=$1
    local string_length=$2

    # Check if array size and string length are provided
    if [ -z "$array_size" ] || [ -z "$string_length" ]; then
        echo "Usage: generate_random_array_json <array_size> <string_length>"
        return 1
    fi

    # Generate random strings and populate the array
    local random_array=()
    for ((i = 0; i < array_size; i++)); do
        random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c $string_length)
        random_array+=("$random_string")
    done

    # Convert the array to JSON format
    json_output='{"results":['
    for ((i = 0; i < ${#random_array[@]}; i++)); do
        json_output+="\"${random_array[i]}\""
        if [ $i -lt $(( ${#random_array[@]} - 1 )) ]; then
            json_output+=','
        fi
    done
    json_output+=']}'

    echo "$json_output"
}
