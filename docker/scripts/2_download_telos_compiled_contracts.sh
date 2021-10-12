#!/bin/bash

echo "-------- 2_download_telos_compiled_contracts ---------"
sleep 1;

get_wasm() {
    echo "----------------------------"
    echo "downloading $1..."
    mkdir -p "$1"
    cd "$1"
    cleos --url https://telos.caleos.io get code "$1" -c "$1.wasm" -a "$1.abi" --wasm
    cd ..
}




if [[ ! -d $HOME/telos_contracts ]]; then
    echo "mkdir $HOME/telos_contracts"
    mkdir $HOME/telos_contracts

    cd $HOME/telos_contracts

    get_wasm bancor.tbn
    get_wasm eth.swaps
    get_wasm eos.swaps
    get_wasm reward.swaps
    get_wasm tlosdx.swaps
    get_wasm eosio.amend  
    get_wasm eosio.saving 
    get_wasm eosio.msig   
    get_wasm eosio.token  
    get_wasm eosio.trail  
    get_wasm eosio.wrap   
    get_wasm telos.decide 

    cd $HOME
fi



