#!/bin/bash
set -e
set -x

#
# Local Single-node Setup

BIN=terrad

$BIN tendermint unsafe-reset-all
rm -rf ~/.terra
$BIN init node0 --chain-id testing

cat $HOME/.terra/config/genesis.json | jq '.app_state["gov"]["voting_params"]["voting_period"]="30s"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
# cat $HOME/.terra/config/genesis.json | jq '.app_state["gov"]["params"]["voting_period"]="30s"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
cat $HOME/.terra/config/genesis.json | jq '.app_state["gov"]["params"]"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
cat $HOME/.terra/config/genesis.json | jq '.consensus["params"]["validator"]["pub_key_types"]=["secp256k1"]' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json

$BIN keys add satoshi
ADDR=$($BIN keys show satoshi -a)
$BIN genesis add-genesis-account $ADDR 100000000000000000seda
$BIN genesis gentx satoshi 10000000000000000seda --chain-id testing

$BIN keys add acc1
ADDR=$($BIN keys show acc1 -a)
$BIN genesis add-genesis-account $ADDR 100000000000000000seda

$BIN genesis collect-gentxs
$BIN start --log_level debug
