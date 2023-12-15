# usage: bash seda-scripts/sudo.sh -c "sedachain" -d "seda1hlqzp7ngss290yw6nlrdujp759ejrhlrkgwccq" -r "http://127.0.0.1:26657" -p seda1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3suc9lqj



source seda-scripts/common.sh


generated_array=$(generate_random_array_json 100000 8)



sudo_call '{"post_results":'${generated_array}'}' 2
