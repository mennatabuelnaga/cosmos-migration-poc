# usage: bash juno-scripts/sudo.sh -c "uni-6" -d "seda1hlqzp7ngss290yw6nlrdujp759ejrhlrkgwccq" -r "https://uni-rpc.reece.sh:443" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj



source juno-scripts/common.sh


generated_array=$(generate_random_array_json 1000000 8)


sudo_call '{"infinite":'{}'}' 2
