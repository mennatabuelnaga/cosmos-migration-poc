#!/usr/bin/env bash

# usage: bash seda-scripts/post_results.sh -c "sedachain" -d "seda1gs52z88gmek3ex73urxnf3p8jflywkd4e5ky2w" -r "http://127.0.0.1:26657" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj


source seda-scripts/common.sh


# echo '{"post_results":'${generated_array}'}'
wasm_execute '{"post_results":{"results":"my_string","times_to_loop":"100","modify_state":false}}' 0
