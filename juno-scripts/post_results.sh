#!/usr/bin/env bash

# usage: bash juno-scripts/post_results.sh -c "uni-6" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -r "https://uni-rpc.reece.sh:443" -p juno14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9skjuwg8
# usage: bash juno-scripts/post_results.sh -c "testing" -d "juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua" -r "http://127.0.0.1:26657" -p juno14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9skjuwg8


source juno-scripts/common.sh


# Example usage: generate a random array of 5 strings, each with a length of 8
generated_array=$(generate_random_array_json 10 8)
# echo "Random Array: ${generated_array}"


# echo '{"post_results":'${generated_array}'}'
wasm_execute '{"post_results":'${generated_array}'}' 0
