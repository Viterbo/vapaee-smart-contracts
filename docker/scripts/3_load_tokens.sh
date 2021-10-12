#!/bin/bash

echo "-------- 2_load_tokens ---------"
sleep 1;

# cd $HOME/src/contracts/telos.contracts/contracts/eosio.token
if [[ ! -d $HOME/telos_contracts ]]; then
    ./2_download_telos_compiled_contracts.sh
fi

cd $HOME/telos_contracts/eosio.token

echo "-------- eosio.token (TLOS) ---------"
cleos set contract eosio.token $PWD eosio.token.wasm eosio.token.abi -p eosio.token@active
cleos push action eosio.token create '[ "token.issuer", "1000000000.0000 TLOS"]' -p eosio.token@active
cleos push action eosio.token create '[ "token.issuer", "2000000000.0000 TLOS"]' -p eosio.token@active
cleos push action eosio.token issue '["token.issuer", "1000000.0000 TLOS", "memo 1000000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "alice", "1000.0100 TLOS", "memo 1000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "alice", "1001.0000 TLOS", "memo 1001 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "bob", "10000.0000 TLOS", "memo 10000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "tom", "2000.0000 TLOS", "memo 2000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "viterbotelos", "2000.0000 TLOS", "memo 2000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "kate", "1010.0000 TLOS", "memo 1010 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "eosio", "1000.0000 TLOS", "memo 1000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "eosio", "1000.0000 TLOS", "memo 1000 TLOS"]' -p token.issuer@active
cleos push action eosio.token transfer '["token.issuer", "rampayer", "3000.0000 TLOS", "memo 3000 TLOS"]' -p token.issuer@active

echo "-------- acornaccount (ACORN) ---------"
cleos set contract acornaccount $PWD eosio.token.wasm eosio.token.abi -p acornaccount@active
cleos push action acornaccount create '[ "token.issuer", "461168601842738.0000 ACORN"]' -p acornaccount@active
cleos push action acornaccount issue '["token.issuer", "100000.0000 ACORN", "memo ACORN"]' -p token.issuer@active
cleos push action acornaccount transfer '["token.issuer", "alice", "4000.0200 ACORN", "memo ACORN"]' -p token.issuer@active
cleos push action acornaccount transfer '["token.issuer", "bob", "4000.0000 ACORN", "memo ACORN"]' -p token.issuer@active
cleos push action acornaccount transfer '["token.issuer", "tom", "4000.0000 ACORN", "memo ACORN"]' -p token.issuer@active
cleos push action acornaccount transfer '["token.issuer", "viterbotelos", "4000.0000 ACORN", "memo ACORN"]' -p token.issuer@active
cleos push action acornaccount transfer '["token.issuer", "kate", "4000.0000 ACORN", "memo ACORN"]' -p token.issuer@active

echo "-------- oliveaccount (OLIVE) ---------"
cleos set contract oliveaccount $PWD eosio.token.wasm eosio.token.abi -p oliveaccount@active
cleos push action oliveaccount create '[ "token.issuer", "461168601842738.0000 OLIVE"]' -p oliveaccount@active
cleos push action oliveaccount issue '["token.issuer", "1000.0000 OLIVE", "memo OLIVE"]' -p token.issuer@active
cleos push action oliveaccount transfer '["token.issuer", "alice", "100.0300 OLIVE", "memo OLIVE"]' -p token.issuer@active
cleos push action oliveaccount transfer '["token.issuer", "bob", "100.0000 OLIVE", "memo OLIVE"]' -p token.issuer@active
cleos push action oliveaccount transfer '["token.issuer", "tom", "100.0000 OLIVE", "memo OLIVE"]' -p token.issuer@active
cleos push action oliveaccount transfer '["token.issuer", "viterbotelos", "100.0000 OLIVE", "memo OLIVE"]' -p token.issuer@active
cleos push action oliveaccount transfer '["token.issuer", "kate", "100.0000 OLIVE", "memo OLIVE"]' -p token.issuer@active

echo "-------- revelation21 (HEART) ---------"
cleos set contract revelation21 $PWD eosio.token.wasm eosio.token.abi -p revelation21@active
cleos push action revelation21 create '[ "token.issuer", "2100000000.0000 HEART"]' -p revelation21@active
cleos push action revelation21 issue '["token.issuer", "1000.0000 HEART", "memo HEART"]' -p token.issuer@active
cleos push action revelation21 transfer '["token.issuer", "alice", "100.0400 HEART", "memo HEART"]' -p token.issuer@active
cleos push action revelation21 transfer '["token.issuer", "bob", "100.0000 HEART", "memo HEART"]' -p token.issuer@active
cleos push action revelation21 transfer '["token.issuer", "tom", "100.0000 HEART", "memo HEART"]' -p token.issuer@active
cleos push action revelation21 transfer '["token.issuer", "viterbotelos", "100.0000 HEART", "memo HEART"]' -p token.issuer@active
cleos push action revelation21 transfer '["token.issuer", "kate", "100.0000 HEART", "memo HEART"]' -p token.issuer@active

echo "-------- futboltokens (FUTBOL) ---------"
cleos set contract futboltokens $PWD eosio.token.wasm eosio.token.abi -p futboltokens@active
cleos push action futboltokens create '[ "token.issuer", "2100000000.0000 FUTBOL"]' -p futboltokens@active
cleos push action futboltokens issue '["token.issuer", "10000.0000 FUTBOL", "memo FUTBOL"]' -p token.issuer@active
cleos push action futboltokens transfer '["token.issuer", "alice", "1000.0500 FUTBOL", "memo FUTBOL"]' -p token.issuer@active
cleos push action futboltokens transfer '["token.issuer", "bob", "1000.0000 FUTBOL", "memo FUTBOL"]' -p token.issuer@active
cleos push action futboltokens transfer '["token.issuer", "tom", "1000.0000 FUTBOL", "memo FUTBOL"]' -p token.issuer@active
cleos push action futboltokens transfer '["token.issuer", "viterbotelos", "1000.0000 FUTBOL", "memo FUTBOL"]' -p token.issuer@active
cleos push action futboltokens transfer '["token.issuer", "kate", "1000.0000 FUTBOL", "memo FUTBOL"]' -p token.issuer@active

echo "-------- teloslegends (LEGEND) ---------"
cleos set contract teloslegends $PWD eosio.token.wasm eosio.token.abi -p teloslegends@active
cleos push action teloslegends create '[ "token.issuer", "12 LEGEND"]' -p teloslegends@active
cleos push action teloslegends issue '["token.issuer", "10 LEGEND", "memo LEGEND"]' -p token.issuer@active
cleos push action teloslegends transfer '["token.issuer", "alice", "1 LEGEND", "memo LEGEND"]' -p token.issuer@active
cleos push action teloslegends transfer '["token.issuer", "bob", "1 LEGEND", "memo LEGEND"]' -p token.issuer@active
cleos push action teloslegends transfer '["token.issuer", "tom", "1 LEGEND", "memo LEGEND"]' -p token.issuer@active
cleos push action teloslegends transfer '["token.issuer", "viterbotelos", "1 LEGEND", "memo LEGEND"]' -p token.issuer@active
cleos push action teloslegends transfer '["token.issuer", "kate", "1 LEGEND", "memo LEGEND"]' -p token.issuer@active

echo "-------- viitasphere1 (VIITA) ---------"
cleos set contract viitasphere1 $PWD eosio.token.wasm eosio.token.abi -p viitasphere1@active
cleos push action viitasphere1 create '[ "token.issuer", "10000000000.0000 VIITA"]' -p viitasphere1@active
cleos push action viitasphere1 issue '["token.issuer", "1000.0000 VIITA", "memo VIITA"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "alice", "100.0600 VIITA", "memo VIITA"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "bob", "100.0000 VIITA", "memo VIITA"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "tom", "100.0000 VIITA", "memo VIITA"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "viterbotelos", "100.0000 VIITA", "memo VIITA"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "kate", "100.0000 VIITA", "memo VIITA"]' -p token.issuer@active

echo "-------- viitasphere1 (VIICT) ---------"
cleos push action viitasphere1 create '[ "token.issuer", "500000 VIICT"]' -p viitasphere1@active
cleos push action viitasphere1 issue '["token.issuer", "1000 VIICT", "memo VIICT"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "alice", "107 VIICT", "memo VIICT"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "bob", "100 VIICT", "memo VIICT"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "tom", "100 VIICT", "memo VIICT"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "viterbotelos", "100 VIICT", "memo VIICT"]' -p token.issuer@active
cleos push action viitasphere1 transfer '["token.issuer", "kate", "100 VIICT", "memo VIICT"]' -p token.issuer@active

echo "-------- qubicletoken (QBE) ---------"
cleos set contract qubicletoken $PWD eosio.token.wasm eosio.token.abi -p qubicletoken@active
cleos push action qubicletoken create '[ "token.issuer", "100000000.0000 QBE"]' -p qubicletoken@active
cleos push action qubicletoken issue '["token.issuer", "1000.0000 QBE", "memo QBE"]' -p token.issuer@active
cleos push action qubicletoken transfer '["token.issuer", "alice", "100.0800 QBE", "memo QBE"]' -p token.issuer@active
cleos push action qubicletoken transfer '["token.issuer", "bob", "100.0000 QBE", "memo QBE"]' -p token.issuer@active
cleos push action qubicletoken transfer '["token.issuer", "tom", "100.0000 QBE", "memo QBE"]' -p token.issuer@active
cleos push action qubicletoken transfer '["token.issuer", "viterbotelos", "100.0000 QBE", "memo QBE"]' -p token.issuer@active
cleos push action qubicletoken transfer '["token.issuer", "kate", "100.0000 QBE", "memo QBE"]' -p token.issuer@active

# echo "-------- ednazztokens (EDNA) ---------"
# cleos set contract ednazztokens $PWD eosio.token.wasm eosio.token.abi -p ednazztokens@active
# cleos push action ednazztokens create '[ "token.issuer", "1300000000.0000 EDNA"]' -p ednazztokens@active
# cleos push action ednazztokens issue '["token.issuer", "1000.0000 EDNA", "memo EDNA"]' -p token.issuer@active
# cleos push action ednazztokens transfer '["token.issuer", "alice", "100.0900 EDNA", "memo EDNA"]' -p token.issuer@active
# cleos push action ednazztokens transfer '["token.issuer", "bob", "100.0000 EDNA", "memo EDNA"]' -p token.issuer@active
# cleos push action ednazztokens transfer '["token.issuer", "tom", "100.0000 EDNA", "memo EDNA"]' -p token.issuer@active
# cleos push action ednazztokens transfer '["token.issuer", "viterbotelos", "100.0000 EDNA", "memo EDNA"]' -p token.issuer@active
# cleos push action ednazztokens transfer '["token.issuer", "kate", "100.0000 EDNA", "memo EDNA"]' -p token.issuer@active

echo "-------- teachology14 (TEACH) ---------"
cleos set contract teachology14 $PWD eosio.token.wasm eosio.token.abi -p teachology14@active
cleos push action teachology14 create '[ "token.issuer", "10000000000.0000 TEACH"]' -p teachology14@active
cleos push action teachology14 issue '["token.issuer", "1000.0000 TEACH", "memo TEACH"]' -p token.issuer@active
cleos push action teachology14 transfer '["token.issuer", "alice", "100.1000 TEACH", "memo TEACH"]' -p token.issuer@active
cleos push action teachology14 transfer '["token.issuer", "bob", "100.0000 TEACH", "memo TEACH"]' -p token.issuer@active
cleos push action teachology14 transfer '["token.issuer", "tom", "100.0000 TEACH", "memo TEACH"]' -p token.issuer@active
cleos push action teachology14 transfer '["token.issuer", "viterbotelos", "100.0000 TEACH", "memo TEACH"]' -p token.issuer@active
cleos push action teachology14 transfer '["token.issuer", "kate", "100.0000 TEACH", "memo TEACH"]' -p token.issuer@active

echo "-------- proxibotstkn (ROBO) ---------"
cleos set contract proxibotstkn $PWD eosio.token.wasm eosio.token.abi -p proxibotstkn@active
cleos push action proxibotstkn create '[ "token.issuer", "1000000000.0000 ROBO"]' -p proxibotstkn@active
cleos push action proxibotstkn issue '["token.issuer", "1000.0000 ROBO", "memo ROBO"]' -p token.issuer@active
cleos push action proxibotstkn transfer '["token.issuer", "alice", "100.1100 ROBO", "memo ROBO"]' -p token.issuer@active
cleos push action proxibotstkn transfer '["token.issuer", "bob", "100.0000 ROBO", "memo ROBO"]' -p token.issuer@active
cleos push action proxibotstkn transfer '["token.issuer", "tom", "100.0000 ROBO", "memo ROBO"]' -p token.issuer@active
cleos push action proxibotstkn transfer '["token.issuer", "viterbotelos", "100.0000 ROBO", "memo ROBO"]' -p token.issuer@active
cleos push action proxibotstkn transfer '["token.issuer", "kate", "100.0000 ROBO", "memo ROBO"]' -p token.issuer@active

echo "-------- stablecarbon (TLOSD) ---------"
cleos set contract stablecarbon $PWD eosio.token.wasm eosio.token.abi -p stablecarbon@active
cleos push action stablecarbon create '[ "token.issuer", "1000000000.0000 TLOSD"]' -p stablecarbon@active
cleos push action stablecarbon issue '["token.issuer", "10000.0000 TLOSD", "memo TLOSD"]' -p token.issuer@active
cleos push action stablecarbon transfer '["token.issuer", "alice", "1000.1200 TLOSD", "memo TLOSD"]' -p token.issuer@active
cleos push action stablecarbon transfer '["token.issuer", "bob", "1000.0000 TLOSD", "memo TLOSD"]' -p token.issuer@active
cleos push action stablecarbon transfer '["token.issuer", "tom", "1000.0000 TLOSD", "memo TLOSD"]' -p token.issuer@active
cleos push action stablecarbon transfer '["token.issuer", "viterbotelos", "1000.0000 TLOSD", "memo TLOSD"]' -p token.issuer@active
cleos push action stablecarbon transfer '["token.issuer", "kate", "1000.0000 TLOSD", "memo TLOSD"]' -p token.issuer@active

echo "-------- telosdacdrop (TLOSDAC) ---------"
cleos set contract telosdacdrop $PWD eosio.token.wasm eosio.token.abi -p telosdacdrop@active
cleos push action telosdacdrop create '[ "token.issuer", "1000000000.0000 TLOSDAC"]' -p telosdacdrop@active
cleos push action telosdacdrop issue '["token.issuer", "500000.0000 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active
cleos push action telosdacdrop transfer '["token.issuer", "alice", "50000.1300 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active
cleos push action telosdacdrop transfer '["token.issuer", "bob", "50000.0000 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active
cleos push action telosdacdrop transfer '["token.issuer", "tom", "50000.0000 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active
cleos push action telosdacdrop transfer '["token.issuer", "viterbotelos", "50000.0000 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active
cleos push action telosdacdrop transfer '["token.issuer", "kate", "50000.0000 TLOSDAC", "memo TLOSDAC"]' -p token.issuer@active

echo "-------- stablecoin.z (EZAR) ---------"
cleos set contract stablecoin.z $PWD eosio.token.wasm eosio.token.abi -p stablecoin.z@active
cleos push action stablecoin.z create '[ "token.issuer", "1000000000.00 EZAR"]' -p stablecoin.z@active
cleos push action stablecoin.z issue '["token.issuer", "10000.00 EZAR", "memo EZAR"]' -p token.issuer@active
cleos push action stablecoin.z transfer '["token.issuer", "alice", "1000.14 EZAR", "memo EZAR"]' -p token.issuer@active
cleos push action stablecoin.z transfer '["token.issuer", "bob", "1000.00 EZAR", "memo EZAR"]' -p token.issuer@active
cleos push action stablecoin.z transfer '["token.issuer", "tom", "1000.00 EZAR", "memo EZAR"]' -p token.issuer@active
cleos push action stablecoin.z transfer '["token.issuer", "viterbotelos", "1000.00 EZAR", "memo EZAR"]' -p token.issuer@active
cleos push action stablecoin.z transfer '["token.issuer", "kate", "1000.00 EZAR", "memo EZAR"]' -p token.issuer@active

echo "-------- yanggangcoin (YANG) ---------"
cleos set contract yanggangcoin $PWD eosio.token.wasm eosio.token.abi -p yanggangcoin@active
cleos push action yanggangcoin create '[ "token.issuer", "1000000000.0000 YANG"]' -p yanggangcoin@active
cleos push action yanggangcoin issue '["token.issuer", "10000.0000 YANG", "memo YANG"]' -p token.issuer@active
cleos push action yanggangcoin transfer '["token.issuer", "alice", "1000.1500 YANG", "memo YANG"]' -p token.issuer@active
cleos push action yanggangcoin transfer '["token.issuer", "bob", "1000.0000 YANG", "memo YANG"]' -p token.issuer@active
cleos push action yanggangcoin transfer '["token.issuer", "tom", "1000.0000 YANG", "memo YANG"]' -p token.issuer@active
cleos push action yanggangcoin transfer '["token.issuer", "viterbotelos", "1000.0000 YANG", "memo YANG"]' -p token.issuer@active
cleos push action yanggangcoin transfer '["token.issuer", "kate", "1000.0000 YANG", "memo YANG"]' -p token.issuer@active

echo "-------- vapaeetokens (CNT) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "500000000.0000 CNT"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "1000000.0000 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "100000.1600 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "100000.0000 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "100000.0000 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "10000.0000 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "100000.0000 CNT", "memo CNT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "rampayer", "100000.0000 CNT", "memo CNT"]' -p token.issuer@active

echo "-------- vapaeetokens (BOX) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "500000000.0000 BOX"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "10000.0000 BOX", "memo BOX"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "1000.1700 BOX", "memo BOX"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "1000.0000 BOX", "memo BOX"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "1000.0000 BOX", "memo BOX"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "1000.0000 BOX", "memo BOX"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "1000.0000 BOX", "memo BOX"]' -p token.issuer@active

echo "-------- vapaeetokens (VPE) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "500000000.0000 VPE"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "10000.0000 VPE", "memo VPE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "1000.1800 VPE", "memo VPE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "1000.0000 VPE", "memo VPE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "1000.0000 VPE", "memo VPE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "1000.0000 VPE", "memo VPE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "1000.0000 VPE", "memo VPE"]' -p token.issuer@active

echo "-------- vapaeetokens (KOINE) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "50000000000.0000 KOINE"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "9000000000.0000 KOINE", "memo KOINE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "10000.1900 KOINE", "memo KOINE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "10000.0000 KOINE", "memo KOINE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "10000.0000 KOINE", "memo KOINE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "10000000.0000 KOINE", "memo KOINE"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "10000.0000 KOINE", "memo KOINE"]' -p token.issuer@active

echo "-------- vapaeetokens (TIPS) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "50000000000.000000 TIPS"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "9000000000.000000 TIPS", "memo TIPS"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "10000.200000 TIPS", "memo TIPS"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "10000.000000 TIPS", "memo TIPS"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "10000.000000 TIPS", "memo TIPS"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "100000000.000000 TIPS", "memo TIPS"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "10000.000000 TIPS", "memo TIPS"]' -p token.issuer@active

echo "-------- vapaeetokens (EUROT) ---------"
cleos set contract vapaeetokens $PWD eosio.token.wasm eosio.token.abi -p vapaeetokens@active
cleos push action vapaeetokens create '[ "token.issuer", "5000000000.00 EUROT"]' -p vapaeetokens@active
cleos push action vapaeetokens issue '["token.issuer", "900000000.00 EUROT", "memo EUROT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "alice", "10000.21 EUROT", "memo EUROT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "bob", "10000.00 EUROT", "memo EUROT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "tom", "10000.00 EUROT", "memo EUROT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "viterbotelos", "100000000.00 EUROT", "memo EUROT"]' -p token.issuer@active
cleos push action vapaeetokens transfer '["token.issuer", "kate", "10000.00 EUROT", "memo EUROT"]' -p token.issuer@active




echo "-------- cryptomulita (MULITA & FAKE) ---------"
cleos set contract cryptomulita $PWD eosio.token.wasm eosio.token.abi -p cryptomulita@active
cleos push action cryptomulita create '[ "token.issuer", "500000000.0000 MULITA"]' -p cryptomulita@active
cleos push action cryptomulita issue '["token.issuer", "10000.0000 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "alice", "1000.2200 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "bob", "1000.0000 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "tom", "1000.0000 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "viterbotelos", "1000.0000 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "kate", "1000.0000 MULITA", "memo MULITA"]' -p token.issuer@active
cleos push action cryptomulita create '[ "token.issuer", "500000000.0000 FAKE"]' -p cryptomulita@active
cleos push action cryptomulita issue '["token.issuer", "10000.0000 FAKE", "memo FAKE"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "alice", "1000.2300 FAKE", "memo FAKE"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "bob", "1000.0000 FAKE", "memo FAKE"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "tom", "1000.0000 FAKE", "memo FAKE"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "viterbotelos", "1000.0000 FAKE", "memo FAKE"]' -p token.issuer@active
cleos push action cryptomulita transfer '["token.issuer", "kate", "1000.0000 FAKE", "memo FAKE"]' -p token.issuer@active

cd $HOME