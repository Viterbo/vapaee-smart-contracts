#!/bin/bash

echo "-------- 3_load_telos_decide ---------"
sleep 1;

# cd $HOME/src/contracts/telos.contracts/contracts/eosio.token
if [[ ! -d $HOME/telos_contracts ]]; then
    ./2_download_telos_compiled_contracts.sh
fi

cd $HOME/telos_contracts/telos.decide

echo "-------- loading telos.decide ---------"
cleos set contract telos.decide $PWD telos.decide.wasm telos.decide.abi -p telos.decide@active

echo "-------- set telos.decide config ---------"

cleos push action telos.decide init '["v2.0.2"]' -p telos.decide
cleos push action telos.decide init '["v2.0.2+"]' -p telos.decide
cleos get table telos.decide telos.decide config
sleep 1

echo "-------- set telos.decide newtreasury VOTE ---------"

cleos push action eosio.token transfer '["eosio", "telos.decide", "1000.0000 TLOS", "deposit"]' -p eosio@active
cleos push action telos.decide newtreasury '["eosio","10000000000.0000 VOTE","public"]' -p eosio
cleos get table telos.decide telos.decide treasuries

echo "pause..."
sleep 1

echo "-------- registering voters ---------"

cleos push action telos.decide regvoter '["telosbookdex","4,VOTE","telosbookdex"]' -p telosbookdex
cleos push action telos.decide regvoter '["alice", "4,VOTE", "alice"]' -p alice
cleos push action telos.decide regvoter '["bob", "4,VOTE", "bob"]' -p bob
cleos push action telos.decide regvoter '["kate", "4,VOTE", "kate"]' -p kate
cleos push action telos.decide regvoter '["tom", "4,VOTE", "tom"]' -p tom
cleos get table telos.decide telosbookdex voters
sleep 1

cleos push action telos.decide mint '["bob", "1000.0000 VOTE", ""]' -p eosio
cleos push action telos.decide mint '["alice", "1001.0000 VOTE", ""]' -p eosio
cleos push action telos.decide mint '["tom", "2000.0000 VOTE", ""]' -p eosio
cleos push action telos.decide mint '["kate", "1000.0000 VOTE", ""]' -p eosio

cleos get currency balance eosio.token bob TLOS
cleos get currency balance eosio.token alice TLOS
cleos get currency balance eosio.token tom TLOS
cleos get currency balance eosio.token kate TLOS

echo "pause..."
sleep 1

