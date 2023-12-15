# usage: bash terra-scripts/sudo.sh -c "pisco-1" -d "seda1hlqzp7ngss290yw6nlrdujp759ejrhlrkgwccq" -r "https://pisco-rpc.terra.dev:443" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj



source terra-scripts/common.sh


generated_array=$(generate_random_array_json 100000 8)



sudo_call '{"post_results":'${generated_array}'}' 2
