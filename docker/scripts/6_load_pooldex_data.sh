#!/bin/bash
INCLUDE_DIR=$HOME/include

echo "-------- 6_load_pooldex_data ---------"
sleep 1;

exit 0

echo "create market"
cleos push action telosbookdex order '["alice", "sell", "10.00000000 TLOS", "0.04000000 CNT",0]' -p alice
cleos get table telosbookdex telosbookdex markets

echo "create pool by direct fund"
cleos get currency balance vapaeetokens rampayer CNT 
cleos get currency balance eosio.token rampayer TLOS
cleos push action vapaeetokens transfer '["rampayer", "telospooldex","1.0000 CNT","directfund,0"]' -p rampayer@active
cleos push action eosio.token  transfer '["rampayer", "telospooldex","1.0000 TLOS","directfund,0"]' -p rampayer@active
cleos get table telospooldex telospooldex pools
cleos get table telospooldex telospooldex fundattempts


echo "create pool by fundattempts"
cleos push action vapaeetokens transfer '["rampayer", "telospooldex","10000.0000 CNT","fund,0"]' -p rampayer@active
cleos push action eosio.token transfer  '["rampayer", "telospooldex","1000.0000 TLOS","fund,0"]' -p rampayer@active


echo "  FIN !!"