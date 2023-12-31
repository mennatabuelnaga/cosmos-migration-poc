#!/usr/bin/env bash

# usage: bash terra-scripts/post_results.sh -c "pisco-1" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -r "https://pisco-rpc.terra.dev:443" -p juno14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9skjuwg8
# usage: bash terra-scripts/post_results.sh -c "testing" -d "terra1y2znmjp9vqqvhyjlc9aj4g6256halp4c29nfgy" -r "http://127.0.0.1:26657" -p juno14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9skjuwg8


source terra-scripts/common.sh


# Example usage: generate a random array of 5 strings, each with a length of 8
generated_array=$(generate_random_array_json 2000 8)
# echo "Random Array: ${generated_array}"


# echo '{"post_results":'${generated_array}'}'
wasm_execute '{"post_results":'${generated_array}'}' 0
