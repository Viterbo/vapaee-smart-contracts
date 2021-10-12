#!/bin/bash
INCLUDE_DIR=$HOME/include

echo "-------- 5_load_book_dex ---------"
sleep 1;

if [[ $1 == "prod" ]] ; then
   NET="--url https://telos.eosrio.io"
fi

echo "-------- telosbookdex ---------"
BOOKDEX_CONTRACT_DIR=$HOME/contracts/telosbookdex
BOOKDEX_WASM_FILE=build/telosbookdex.wasm
BOOKDEX_INCLUDE_MODULES_DIR=$INCLUDE_DIR/vapaee/dex/modules
BOOKDEX_INCLUDE_TABLES_DIR=$INCLUDE_DIR/vapaee/dex/tables


if [[ $BOOKDEX_CONTRACT_DIR/telosbookdex.cpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_CONTRACT_DIR/telosbookdex.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/client.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/dao.hpp           -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/deposit.hpp       -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/error.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/exchange.hpp      -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/experience.hpp    -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/global.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/maintenance.hpp   -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/market.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/record.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/token.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_MODULES_DIR/utils.hpp         -nt $BOOKDEX_WASM_FILE ||

      $BOOKDEX_INCLUDE_TABLES_DIR/_aux.hpp           -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/ballots.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/blacklist.hpp      -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/clients.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/delmarkets.hpp     -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/deposits.hpp       -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/depusers.hpp       -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/events.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/exp.hpp            -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/history.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/historyall.hpp     -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/historyblock.hpp   -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/last24hs.hpp       -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/markets.hpp        -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/ordersummary.hpp   -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/points.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/sellorders.hpp     -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/stat.hpp           -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/state.hpp          -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/tokendata.hpp      -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/tokenevents.hpp    -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/tokengroups.hpp    -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/tokens.hpp         -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/userorders.hpp     -nt $BOOKDEX_WASM_FILE ||
      $BOOKDEX_INCLUDE_TABLES_DIR/whitelist.hpp      -nt $BOOKDEX_WASM_FILE ||

      $force == true ]]; then
   
   cd $BOOKDEX_CONTRACT_DIR
   mkdir -p build
   echo "compiling..."
   eosio-cpp -o $BOOKDEX_WASM_FILE -I $INCLUDE_DIR telosbookdex.cpp --abigen
fi

cd $BOOKDEX_CONTRACT_DIR
echo "BOOKDEX_WASM_FILE = $BOOKDEX_WASM_FILE"
echo "cleos $NET set contract telosbookdex $PWD/build telosbookdex.wasm telosbookdex.abi -p telosbookdex@active"
cleos $NET set contract telosbookdex $PWD/build telosbookdex.wasm telosbookdex.abi -p telosbookdex@active

# --------------------------------------------------------------

EVENTHANDLER_CONTRACT_DIR=$HOME/contracts/eventhandler
EVENTHANDLER_WASM_FILE=build/eventhandler.wasm
if [ "$NET" == "" ]; then
    echo "-------- eventhandler ---------"
    cd $EVENTHANDLER_CONTRACT_DIR
    if [[ eventhandler.hpp -nt $EVENTHANDLER_WASM_FILE || 
        $force == true ]]; then
        mkdir -p build
        echo "compiling..."
        eosio-cpp -o $EVENTHANDLER_WASM_FILE -I $INCLUDE_DIR eventhandler.cpp --abigen
    fi
    echo "cleos $NET set contract eventhandler $PWD/build eventhandler.wasm eventhandler.abi -p eventhandler@active"
    cleos $NET set contract eventhandler $PWD/build eventhandler.wasm eventhandler.abi -p eventhandler@active
fi


# --------------------------------------------------------------

echo "-- INIT DEX --"
sleep 1
cleos push action telosbookdex init '[]' -p telosbookdex@active
cleos push action telosbookdex init '[]' -p telosbookdex@active



echo "-- register clients --"

cleos push action telosbookdex addclient '["bob",   "vapaee","fee memo for vapaee", "Vapaée Telos DEX", "https://vapaee.io", "brief", "banner", "thumbnail"]' -p bob@active
cleos push action telosbookdex addclient '["alice", "sqrl", "fee memo for sqrl", "SQRL Wallet", "https://sqrlwallet.io", "brief", "banner", "thumbnail"]' -p alice@active

echo "repito por las dudas..."
sleep 1

cleos push action telosbookdex addclient '["bob",   "vapaee","fee memo for vapaee", "Vapaée Telos DEX", "https://vapaee.io", "brief", "banner", "thumbnail"]' -p bob@active
cleos push action telosbookdex addclient '["alice", "sqrl", "fee memo for sqrl", "SQRL Wallet", "https://sqrlwallet.io", "brief", "banner", "thumbnail"]' -p alice@active
