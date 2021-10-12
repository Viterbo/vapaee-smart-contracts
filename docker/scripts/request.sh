#!/bin/bash
INCLUDE_DIR=$HOME/include

echo "-------- request ---------"
sleep 1;

echo "create market"
cleos push action telosbookdex newmarket '["TLOS", "CNT"]' -p rampayer
# The commodity and currency are purposefully inverted. It must always be interpreted canonically.

cleos get table telosbookdex telosbookdex markets
# {
#   "rows": [{
#       "id": 0,
#       "commodity": "CNT",
#       "currency": "TLOS"
#     },{
#       "id": 1,
#       "commodity": "TLOS",
#       "currency": "CNT"
#     }
#   ],
#   "more": false,
#   "next_key": ""
# }


cleos get currency balance vapaeetokens rampayer CNT 
cleos get currency balance eosio.token rampayer TLOS

cleos push action vapaeetokens transfer '["rampayer", "telospooldex","10000.0000 CNT","fund,TLOS/CNT"]' -p rampayer@active

cleos get table telospooldex rampayer fundattempts

cleos get currency balance vapaeetokens rampayer CNT 

cleos push action eosio.token transfer  '["rampayer", "telospooldex","100.0000 TLOS","fund,TLOS/CNT"]' -p rampayer@active

cleos get currency balance vapaeetokens rampayer CNT 
cleos get currency balance eosio.token rampayer TLOS

echo "  FIN !!"