#!/usr/bin/env bash

# usage: bash seda-scripts/get_state_keys.sh -c "sedachain" -d "seda1gs52z88gmek3ex73urxnf3p8jflywkd4e5ky2w" -r "http://127.0.0.1:26657"


source seda-scripts/common.sh


smart_query '{"get_state_keys":{}}'