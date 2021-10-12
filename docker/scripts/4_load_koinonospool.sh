#!/bin/bash
INCLUDE=$HOME/include
echo "-------- 3_load_koinonospool ---------"
sleep 1;

if [[ $1 == "prod" ]] ; then
   NET="--url https://telos.eosrio.io"
fi

echo "-------- koinonospool ---------"
KPOOL_CONTRACT_DIR=$HOME/contracts/koinonospool
KPOOL_WASM_FILE=build/koinonospool.wasm
cd $KPOOL_CONTRACT_DIR
if [[ error.hpp         -nt $KPOOL_WASM_FILE ||
      koinonospool.cpp  -nt $KPOOL_WASM_FILE ||
      koinonospool.hpp  -nt $KPOOL_WASM_FILE ||
      utils.hpp         -nt $KPOOL_WASM_FILE ||
      $force == true ]]; then

   mkdir build
   echo "compiling..."
   eosio-cpp -o $KPOOL_WASM_FILE -I $INCLUDE koinonospool.cpp --abigen
fi
echo "KPOOL_WASM_FILE = $KPOOL_WASM_FILE"
echo "cleos $NET set contract koinonospool $PWD/build koinonospool.wasm koinonospool.abi -p koinonospool@active"
cleos $NET set contract koinonospool $PWD/build koinonospool.wasm koinonospool.abi -p koinonospool@active


echo "-------- koinonospool.initpool ---------"
cleos push action koinonospool initpool '["koinonospool","vapaeetokens","6,TIPS"]' -p koinonospool
cleos push action koinonospool initpool '["koinonospool","vapaeetokens","2,EUROT"]' -p koinonospool
cleos push action koinonospool initpool '["koinonospool","vapaeetokens","4,KOINE"]' -p koinonospool
cleos get table koinonospool koinonospool pools 

echo "-------- koinonospool.fund pools ---------"
# Tips = 0,001 vs EuroT
# Koine= 0,01 vs EuroT
cleos push action vapaeetokens transfer '["viterbotelos","koinonospool","198021.527740 TIPS","fund"]' -p viterbotelos
cleos push action vapaeetokens transfer '["viterbotelos","koinonospool","10211.02 EUROT","fund"]' -p viterbotelos
cleos push action vapaeetokens transfer '["viterbotelos","koinonospool","98912.1810 KOINE","fund"]' -p viterbotelos
cleos get table koinonospool koinonospool pools 

echo "-------- koinonospool swap ---------"
# cleos get currency balance vapaeetokens bob EUROT 
# cleos get currency balance vapaeetokens bob TIPS 
# cleos push action vapaeetokens transfer '["bob","koinonospool","1.00 EUROT","koinonos.v1,0.000000 TIPS,bob"]' -p bob@active
# cleos get currency balance vapaeetokens bob EUROT 
# cleos get currency balance vapaeetokens bob TIPS 
# cleos get table koinonospool koinonospool pools 
# sleep 1
# cleos push action vapaeetokens transfer '["bob","koinonospool","1000.00 EUROT","koinonos.v1,0.000000 TIPS,bob"]' -p bob@active
# cleos get currency balance vapaeetokens bob EUROT 
# cleos get currency balance vapaeetokens bob TIPS 
# cleos get table koinonospool koinonospool pools 


# cleos push action vapaeetokens transfer '["viterbotelos","koinonospool","500.00 EUROT","koinonos.v1,8874.069259 TIPS,viterbotelos"]' -p viterbotelos@active
# cleos push action vapaeetokens transfer '["viterbotelos","koinonospool","500.00 EUROT","koinonos.v1,0.000000 TIPS,viterbotelos"]' -p viterbotelos@active

