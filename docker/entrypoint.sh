#!/bin/bash

echo "-- Vapaée Smart Contracts Entrypoint --"

echo waiting...
#echo 5; sleep 1;
#echo 4; sleep 1;
#echo 3; sleep 1;
echo 2; sleep 1;
echo 1; sleep 1;

HOME=$(pwd)
echo "HOME: $HOME"

./docker/scripts/1_create_accounts.sh
./docker/scripts/2_download_telos_compiled_contracts.sh
./docker/scripts/3_load_tokens.sh
./docker/scripts/3_load_telos_decide.sh
# ./docker/scripts/4_load_koinonospool.sh
./docker/scripts/5_load_bookdex.sh
./docker/scripts/5_load_bookdex_data.sh
#./docker/scripts/5_load_bookdex_orders.sh
./docker/scripts/6_load_pooldex.sh
./docker/scripts/6_load_pooldex_data.sh

echo "export HOME=/app"