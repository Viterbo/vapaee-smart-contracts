#!/bin/bash
INCLUDE_DIR=$HOME/include

echo "-------- 6_load_pooldex ---------"
sleep 1;

if [[ $1 == "prod" ]] ; then
   NET="--url https://telos.eosrio.io"
fi

echo "-------- telospooldex ---------"
POOLDEX_CONTRACT_DIR=$HOME/contracts/telospooldex
POOLDEX_WASM_FILE=build/telospooldex.wasm
POOLDEX_INCLUDE_MODULES_DIR=$INCLUDE_DIR/vapaee/pool/modules
POOLDEX_INCLUDE_TABLES_DIR=$INCLUDE_DIR/vapaee/pool/tables
# BOOKDEX_INCLUDE_MODULES_DIR=$INCLUDE_DIR/vapaee/book/modules
BOOKDEX_INCLUDE_TABLES_DIR=$INCLUDE_DIR/vapaee/book/tables


if [[ $POOLDEX_CONTRACT_DIR/telospooldex.cpp         -nt $POOLDEX_WASM_FILE ||
      $POOLDEX_CONTRACT_DIR/telospooldex.hpp         -nt $POOLDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/fund_attempts.hpp  -nt $POOLDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/history.hpp        -nt $POOLDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/pools.hpp          -nt $POOLDEX_WASM_FILE ||

      $force == true ]]; then
   
   cd $POOLDEX_CONTRACT_DIR
   mkdir -p build
   echo "compiling..."
   eosio-cpp -o $POOLDEX_WASM_FILE -I $INCLUDE_DIR telospooldex.cpp --abigen
fi

cd $POOLDEX_CONTRACT_DIR
echo "POOLDEX_WASM_FILE = $POOLDEX_WASM_FILE"
echo "cleos $NET set contract telospooldex $PWD/build telospooldex.wasm telospooldex.abi -p telospooldex@active"
cleos $NET set contract telospooldex $PWD/build telospooldex.wasm telospooldex.abi -p telospooldex@active

# --------------------------------------------------------------

ECHOCONTRACT_CONTRACT_DIR=$HOME/contracts/echocontract
ECHOCONTRACT_WASM_FILE=build/echocontract.wasm
if [ "$NET" == "" ]; then
    echo "-------- echocontract ---------"
    cd $ECHOCONTRACT_CONTRACT_DIR
    if [[ echocontract.hpp -nt $ECHOCONTRACT_WASM_FILE || 
        $force == true ]]; then
        mkdir -p build
        echo "compiling..."
        eosio-cpp -o $ECHOCONTRACT_WASM_FILE -I $INCLUDE_DIR echocontract.cpp --abigen
    fi
    echo "cleos $NET set contract echocontract $PWD/build echocontract.wasm echocontract.abi -p echocontract@active"
    cleos $NET set contract echocontract $PWD/build echocontract.wasm echocontract.abi -p echocontract@active
fi


# --------------------------------------------------------------

# echo "-- INIT DEX --"
# sleep 1
# cleos push action telospooldex init '[]' -p telospooldex@active
# cleos push action telospooldex init '[]' -p telospooldex@active
# 
# 
# 
# echo "-- register clients --"
# 
# cleos push action telospooldex addclient '["bob",   "vapaee","fee memo for vapaee", "Vapaée Telos DEX", "https://vapaee.io", "brief", "banner", "thumbnail"]' -p bob@active
# cleos push action telospooldex addclient '["alice", "sqrl", "fee memo for sqrl", "SQRL Wallet", "https://sqrlwallet.io", "brief", "banner", "thumbnail"]' -p alice@active
# 
# echo "repito por las dudas..."
# sleep 1
# 
# cleos push action telospooldex addclient '["bob",   "vapaee","fee memo for vapaee", "Vapaée Telos DEX", "https://vapaee.io", "brief", "banner", "thumbnail"]' -p bob@active
# cleos push action telospooldex addclient '["alice", "sqrl", "fee memo for sqrl", "SQRL Wallet", "https://sqrlwallet.io", "brief", "banner", "thumbnail"]' -p alice@active
# 