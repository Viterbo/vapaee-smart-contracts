echo "-------- 5_load_bookdex_data ---------"
sleep 1;

echo "-- REGISTER TOKENS into DEX --"

cleos push action eosio.token transfer  '["token.issuer",  "telosbookdex","10000.0000 TLOS","deposit"]' -p token.issuer@active

# register tokens
echo "-- register VIITA --" 
cleos push action telosbookdex addtoken '["viitasphere1","VIITA",4,"token.issuer", "Viitasphere", "https://viitasphere.com", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/viitasphere.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/viitasphere-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register VIICT --" 
cleos push action telosbookdex addtoken '["viitasphere1","VIICT",0,"token.issuer", "Viitasphere", "https://viitasphere.com", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/viitasphere.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/viitasphere-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register QBE --" 
cleos push action telosbookdex addtoken '["qubicletoken","QBE",4,"token.issuer", "Qubicles", "https://fenero.io/qubicles", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/qbe.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/qbe-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register ACORN --" 
cleos push action telosbookdex addtoken '["acornaccount","ACORN",4,"token.issuer", "ACORN", "http://acorns.fun", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/acorn.svg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/acorn-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register YANG --" 
cleos push action telosbookdex addtoken '["yanggangcoin","YANG",4,"token.issuer", "Yang Gang Coin", "https://www.yang2020.com/", "Together, We Can Build a New Kind of Economy, One That Puts People First.", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/uploads/yang-banner.jpg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/yang-coin.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/yang-coin-lg.png","personal contact","group contact",true]' -p token.issuer
cleos push action telosbookdex settokendata '["YANG", 0, "add", "Official Twitter Account", "https://twitter.com/andrewyang", "twitter"]' -p token.issuer


echo "-- register FUTBOL --" 
cleos push action telosbookdex addtoken '["futboltokens","FUTBOL",4,"token.issuer", "Fútbol Tokens", "http://futboltokens.online/", "Collect the best football trading cards and win prizes", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/uploads/futboltokens-banner.jpg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/futboltokens.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/futboltokens.png","personal contact","group contact",true]' -p token.issuer
cleos push action telosbookdex settokendata '["FUTBOL", 0, "add", "Video en español", "https://www.youtube.com/watch?v=4fYHjH5ylnA", "youtube"]' -p token.issuer

echo "-- register LEGEND --" 
cleos push action telosbookdex addtoken '["teloslegends","LEGEND",0,"token.issuer", "Telos Legends", "http://futboltokens.online/", "Collect the best football trading cards and win prizes", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/uploads/legend-banner.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/legend.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/legend-lg.png",false]' -p token.issuer

echo "-- register OLIVE --" 
cleos push action telosbookdex addtoken '["oliveaccount","OLIVE",4,"token.issuer", "OLIVE", "http://democratic.money/olive", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/olive.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/olive-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register HEART --" 
cleos push action telosbookdex addtoken '["revelation21","HEART",4,"token.issuer", "HEART", "https://steemit.com/@steemchurch", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/beautitude.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/beautitude-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register EDNA --" 
cleos push action telosbookdex addtoken '["ednazztokens","EDNA",4,"token.issuer", "EDNA", "https://github.com/EDNA-LIFE", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/edna.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/edna-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register TEACH --" 
cleos push action telosbookdex addtoken '["teachology14","TEACH",4,"token.issuer", "Teachology", "http://teachology.io", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/teach.svg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/teach-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register ROBO --" 
cleos push action telosbookdex addtoken '["proxibotstkn","ROBO",4,"token.issuer", "Proxibots", "https://proxibots.io", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/proxibots.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/proxibots-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register TLOSD --" 
cleos push action telosbookdex addtoken '["stablecarbon","TLOSD",4,"token.issuer", "Carbon", "https://www.carbon.money", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/carbon.svg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/carbon.svg","personal contact","group contact",true]' -p token.issuer
# cleos push action telosbookdex setcurrency '["TLOSD", true]' -p telosbookdex@active

echo "-- register TLOSDAC --" 
cleos push action telosbookdex addtoken '["telosdacdrop","TLOSDAC",4,"token.issuer", "TelosDAC", "https://telosdac.io/", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/telosdac.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/telosdac-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register EZAR --"
cleos push action telosbookdex addtoken '["stablecoin.z","EZAR",2,"token.issuer", "South African Rand", "https://t.me/ezartoken", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/ezar.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/ezar-lg.png","personal contact","group contact",true]' -p token.issuer

echo "-- register CNT --"
cleos push action telosbookdex addtoken '["vapaeetokens", "CNT", 4, "token.issuer", "Cards & Tokens", "http://cardsandtokens.com", "A platform where you can create themed albums and trading cards to collect and play making money in the process.", "assets/img/cards-and-tokens-1200x400.jpeg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/cnt.svg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/cnt-lg.svg","personal contact","group contact",true]' -p token.issuer
cleos push action telosbookdex settokendata '["CNT", 0, "add", "Promo video", "https://youtu.be/YSVJgKsSobA", "youtube"]' -p telosbookdex@active
cleos push action telosbookdex settokendata '["CNT", 0, "add", "Membership cards", "https://twitter.com/TokensCards/status/1109668817175748608", "twitter"]' -p token.issuer
cleos push action telosbookdex settokendata '["CNT", 0, "add", "Demo video", "https://www.youtube.com/watch?v=jhL1KyifGEs&list=PLIv5p7BTy5wxqwqs0fGyjtOahoO3YWX0x&index=1", "youtube"]' -p token.issuer
cleos push action telosbookdex settokendata '["CNT", 0, "add", "The CNT token airdrop", "https://twitter.com/TokensCards/status/1105088865994452993", "twitter"]' -p token.issuer

echo "-- register BOX --" 
cleos push action telosbookdex addtoken '["vapaeetokens", "BOX", 4, "token.issuer", , "Board Game Box", "https://vapaee.io/bgbox", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/box.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/box-lg.png","personal contact","group contact",true]' -p token.issuer
echo "-- register VPE --" 
cleos push action telosbookdex addtoken '["vapaeetokens", "VPE", 6, "token.issuer", , "Vapaée", "https://vapaee.io", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/vapaee.png", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/vapaee-lg.png","personal contact","group contact",true]' -p token.issuer

echo "-- register MULITA --" 
cleos push action telosbookdex addtoken '["cryptomulita","MULITA",4,"token.issuer", "Crypto Mulita", "https://steemit.com/@viterbo", "", "", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/mulita.svg", "https://raw.githubusercontent.com/vapaee/vapaee.io-website/master/www/assets/logos/mulita.svg","personal contact","group contact",true]' -p token.issuer
echo "-- register FAKE --" 
cleos push action telosbookdex addtoken '["cryptomulita","FAKE",4,"token.issuer", "FAKE", "", "", "", "", "","personal contact","group contact",true]' -p token.issuer
























echo "-- deposits --"

cleos push action eosio.token transfer  '["bob",  "telosbookdex","100.0000 TLOS","deposit"]' -p bob@active
cleos push action eosio.token transfer  '["alice","telosbookdex","1000.0100 TLOS","deposit"]' -p alice@active
cleos push action eosio.token transfer  '["kate", "telosbookdex","100.0000 TLOS","deposit"]' -p kate@active
cleos push action eosio.token transfer  '["tom",  "telosbookdex","1000.0000 TLOS","deposit"]' -p tom@active

cleos push action acornaccount transfer  '["bob",  "telosbookdex","50.0000 ACORN","deposit"]' -p bob@active
cleos push action acornaccount transfer  '["alice","telosbookdex","1000.0200 ACORN","deposit"]' -p alice@active
cleos push action acornaccount transfer  '["tom",  "telosbookdex","50.0000 ACORN","deposit"]' -p tom@active
cleos push action acornaccount transfer  '["kate", "telosbookdex","50.0000 ACORN","deposit"]' -p kate@active

cleos push action futboltokens transfer  '["bob",  "telosbookdex","1000.0000 FUTBOL","deposit"]' -p bob@active
cleos push action futboltokens transfer  '["alice","telosbookdex","1000.0500 FUTBOL","deposit"]' -p alice@active
cleos push action futboltokens transfer  '["tom",  "telosbookdex","1000.0000 FUTBOL","deposit"]' -p tom@active
cleos push action futboltokens transfer  '["kate", "telosbookdex","1000.0000 FUTBOL","deposit"]' -p kate@active

cleos push action qubicletoken transfer  '["bob",  "telosbookdex","100.0000 QBE","deposit"]' -p bob@active
cleos push action qubicletoken transfer  '["alice","telosbookdex","100.0800 QBE","deposit"]' -p alice@active
cleos push action qubicletoken transfer  '["tom",  "telosbookdex","100.0000 QBE","deposit"]' -p tom@active
cleos push action qubicletoken transfer  '["kate", "telosbookdex","100.0000 QBE","deposit"]' -p kate@active

cleos push action stablecarbon transfer  '["bob",  "telosbookdex","1000.0000 TLOSD","deposit"]' -p bob@active
cleos push action stablecarbon transfer  '["alice","telosbookdex","1000.1200 TLOSD","deposit"]' -p alice@active
cleos push action stablecarbon transfer  '["tom",  "telosbookdex","1000.0000 TLOSD","deposit"]' -p tom@active
cleos push action stablecarbon transfer  '["kate", "telosbookdex","1000.0000 TLOSD","deposit"]' -p kate@active

cleos push action stablecoin.z transfer  '["bob",  "telosbookdex","1000.00 EZAR","deposit"]' -p bob@active
cleos push action stablecoin.z transfer  '["alice","telosbookdex","1000.14 EZAR","deposit"]' -p alice@active
cleos push action stablecoin.z transfer  '["tom",  "telosbookdex","1000.00 EZAR","deposit"]' -p tom@active
cleos push action stablecoin.z transfer  '["kate", "telosbookdex","1000.00 EZAR","deposit"]' -p kate@active

# cleos push action ednazztokens transfer  '["bob",  "telosbookdex","100.0000 EDNA","deposit"]' -p bob@active
# cleos push action ednazztokens transfer  '["alice","telosbookdex","100.0000 EDNA","deposit"]' -p alice@active
# cleos push action ednazztokens transfer  '["tom",  "telosbookdex","100.0000 EDNA","deposit"]' -p tom@active
# cleos push action ednazztokens transfer  '["kate", "telosbookdex","100.0000 EDNA","deposit"]' -p kate@active

cleos push action oliveaccount transfer  '["bob",  "telosbookdex","100.0000 OLIVE","deposit"]' -p bob@active
cleos push action oliveaccount transfer  '["alice","telosbookdex","100.0000 OLIVE","deposit"]' -p alice@active
cleos push action oliveaccount transfer  '["tom",  "telosbookdex","100.0000 OLIVE","deposit"]' -p tom@active
cleos push action oliveaccount transfer  '["kate", "telosbookdex","100.0000 OLIVE","deposit"]' -p kate@active

cleos push action proxibotstkn transfer  '["bob",  "telosbookdex","100.0000 ROBO","deposit"]' -p bob@active
cleos push action proxibotstkn transfer  '["alice","telosbookdex","100.0000 ROBO","deposit"]' -p alice@active
cleos push action proxibotstkn transfer  '["tom",  "telosbookdex","100.0000 ROBO","deposit"]' -p tom@active
cleos push action proxibotstkn transfer  '["kate", "telosbookdex","100.0000 ROBO","deposit"]' -p kate@active

cleos push action viitasphere1 transfer  '["bob",  "telosbookdex","100.0000 VIITA","deposit"]' -p bob@active
cleos push action viitasphere1 transfer  '["alice","telosbookdex","100.0000 VIITA","deposit"]' -p alice@active
cleos push action viitasphere1 transfer  '["tom",  "telosbookdex","100.0000 VIITA","deposit"]' -p tom@active
cleos push action viitasphere1 transfer  '["kate", "telosbookdex","100.0000 VIITA","deposit"]' -p kate@active

cleos push action teachology14 transfer  '["bob",  "telosbookdex","100.0000 TEACH","deposit"]' -p bob@active
cleos push action teachology14 transfer  '["alice","telosbookdex","100.0000 TEACH","deposit"]' -p alice@active
cleos push action teachology14 transfer  '["tom",  "telosbookdex","100.0000 TEACH","deposit"]' -p tom@active
cleos push action teachology14 transfer  '["kate", "telosbookdex","100.0000 TEACH","deposit"]' -p kate@active

cleos push action telosdacdrop transfer '["bob",  "telosbookdex","50000.0000 TLOSDAC","deposit"]' -p bob@active
cleos push action telosdacdrop transfer '["alice","telosbookdex","50000.0000 TLOSDAC","deposit"]' -p alice@active
cleos push action telosdacdrop transfer '["tom",  "telosbookdex","50000.0000 TLOSDAC","deposit"]' -p tom@active
cleos push action telosdacdrop transfer '["kate", "telosbookdex","50000.0000 TLOSDAC","deposit"]' -p kate@active

cleos push action vapaeetokens transfer '["bob",  "telosbookdex","10000.0000 CNT","deposit"]' -p bob@active
cleos push action vapaeetokens transfer '["alice","telosbookdex","10000.0000 CNT","deposit"]' -p alice@active
cleos push action vapaeetokens transfer '["kate", "telosbookdex","10000.0000 CNT","deposit"]' -p kate@active

cleos push action vapaeetokens transfer  '["bob",  "telosbookdex","1000.0000 BOX","deposit"]' -p bob@active
cleos push action vapaeetokens transfer  '["alice","telosbookdex","1000.0000 BOX","deposit"]' -p alice@active


cleos push action cryptomulita transfer '["bob",  "telosbookdex","1000.0000 MULITA","deposit"]' -p bob@active
cleos push action cryptomulita transfer '["alice","telosbookdex","1000.0000 MULITA","deposit"]' -p alice@active
cleos push action cryptomulita transfer '["tom",  "telosbookdex","1000.0000 MULITA","deposit"]' -p tom@active
cleos push action cryptomulita transfer '["kate", "telosbookdex","1000.0000 MULITA","deposit"]' -p kate@active

cleos push action cryptomulita transfer '["bob",  "telosbookdex","1000.0000 FAKE","deposit"]' -p bob@active
cleos push action cryptomulita transfer '["alice","telosbookdex","1000.0000 FAKE","deposit"]' -p alice@active
cleos push action cryptomulita transfer '["tom",  "telosbookdex","1000.0000 FAKE","deposit"]' -p tom@active
cleos push action cryptomulita transfer '["kate", "telosbookdex","1000.0000 FAKE","deposit"]' -p kate@active

echo "-- deposits finished --"

