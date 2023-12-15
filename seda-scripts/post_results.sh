#!/usr/bin/env bash

# usage: bash seda-scripts/post_results.sh -c "sedachain" -d "seda1gs52z88gmek3ex73urxnf3p8jflywkd4e5ky2w" -r "http://127.0.0.1:26657" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj


source seda-scripts/common.sh


# Example usage: generate a random array of 5 strings, each with a length of 8
generated_array=$(generate_random_array_json 10 8)
# echo "Random Array: ${generated_array}"


# echo '{"post_results":'${generated_array}'}'
wasm_execute '{"post_results":'${generated_array}'}' 0
