#pragma once

#include <vapaee/base/base.hpp>
#include <vapaee/dex/modules/utils.hpp>
#include <vapaee/dex/modules/market.hpp>
#include <vapaee/pool/tables.hpp>

#define ARITHMETIC_PRECISION 8

#define ERR_MARKET_NOT_FOUND    "market not found"
#define ERR_MARKET_INVERSE      "market musn\'t be inverted"
#define ERR_POOL_NOT_FOUND      "pool not found"
#define ERR_POOL_EXISTS         "pool already exists"
#define ERR_TOKEN_NOT_REG       "token not registered"
#define ERR_COMM_SYM_NOT_MATCH  "commodity symbols don\'t match"
#define ERR_CURR_SYM_NOT_MATCH  "currency symbols don\'t match"
#define ERR_ACCOUNT_NOT_FOUND   "account not found"
#define ERR_MEMO_PARSING        "incorrect memo format"
#define ERR_ATTEMPT_NOT_FOUND   "fund attempt not found"
#define ERR_NOT_FUNDER          "not funder"
#define ERR_EMPTY_PATH          "path is empty"
#define ERR_INCORRECT_CONVERTER "this is not the converter you need"
#define ERR_POOL_NOT_FUNDED     "unfunded pool"
#define ERR_RECIPIENT_NOT_FOUND "recipient not found"
#define ERR_BAD_DEAL            "total less than minimun"
#define ERR_CONVERTER_NOT_FOUND "can't find converter"
#define ERR_FAKE_TOKEN          "wrong token contract"
#define ERR_INSUFFICENT_PART    "insufficent participation"

#define PROTO_VERSION "openpool.v1"_n

#define ECHO_CONTRACT "echocontract"_n

#define THANK_YOU_MSG "Thank you for using Telos Pool DEX"

#include <eosio/system.hpp>

using eosio::asset;
using eosio::check;

using vapaee::dex::utils::get_contract_for_token;
using vapaee::dex::global::get_now_time_point_sec;
using vapaee::dex::market::aux_get_canonical_index_for_symbols;
using vapaee::utils::ipow;
using vapaee::utils::pack;
using vapaee::utils::asset_divide;
using vapaee::utils::symbols_get_index;
using vapaee::utils::asset_change_symbol;
using vapaee::utils::asset_change_precision;


namespace vapaee {

    namespace pool {

        static symbol PART_SYM = symbol("PART", ARITHMETIC_PRECISION);
        static asset PART_UNIT = asset(ipow(10, 8), PART_SYM);

        namespace utils {

            bool get_market_id_for_syms(
                symbol_code A, symbol_code B, uint64_t* result
            ) {
                markets book_markets(vapaee::dex::contract, vapaee::dex::contract.value);
                auto sym_index = book_markets.get_index<"tokensidx"_n>();

                auto book_it = sym_index.find(aux_get_canonical_index_for_symbols(A, B));
                bool found = book_it != sym_index.end();
                if (found)
                    *result = book_it->id;

                return found;
            }

            bool pool_exists(symbol_code A, symbol_code B) {
                pools pool_markets(contract, contract.value);
                auto sym_index = pool_markets.get_index<"symbols"_n>();
                return sym_index.find(symbols_get_index(A, B)) != sym_index.end();
            }

            void create_pool(uint64_t market_id) {
                markets book_markets(vapaee::dex::contract, vapaee::dex::contract.value);
                auto book_it = book_markets.find(market_id);
                check(book_it != book_markets.end(), ERR_MARKET_NOT_FOUND);

                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(market_id);
                check(pool_it == pool_markets.end(), ERR_POOL_EXISTS);

                tokens book_tokens(vapaee::dex::contract, vapaee::dex::contract.value);
                auto commodity_it = book_tokens.find(book_it->commodity.raw());
                auto currency_it = book_tokens.find(book_it->currency.raw());
                check(commodity_it != book_tokens.end(), ERR_TOKEN_NOT_REG);
                check(currency_it != book_tokens.end(), ERR_TOKEN_NOT_REG);

                check(
                    !pool_exists(book_it->commodity, book_it->currency) &&
                    !pool_exists(book_it->currency, book_it->commodity),
                    ERR_POOL_EXISTS
                );

                pool_markets.emplace(contract, [&](auto& row) {
                    row.id = market_id;
                    row.commodity_reserve = asset(
                        0, symbol(book_it->commodity, commodity_it->precision));
                    row.currency_reserve = asset(
                        0, symbol(book_it->currency, currency_it->precision));
                    row.total_participation = asset(0, PART_SYM);
                });
            }

            asset get_pool_rate(uint64_t pool_id) {
                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(pool_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);
                
                asset commodity_supply = asset_change_precision(
                        pool_it->commodity_reserve, ARITHMETIC_PRECISION);
                asset currency_supply = asset_change_precision(
                        pool_it->currency_reserve, ARITHMETIC_PRECISION);
                return asset_divide(commodity_supply, currency_supply);
            }

            tuple<asset, asset> get_conversion(
                uint64_t pool_id, asset quantity, asset fee
            ) {
                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(pool_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);
                
                asset from_reserve, to_reserve;
                if (quantity.symbol.code() == 
                        pool_it->commodity_reserve.symbol.code()) {
                    from_reserve = pool_it->commodity_reserve;
                    to_reserve = pool_it->currency_reserve;
                } else {
                    from_reserve = pool_it->currency_reserve;
                    to_reserve = pool_it->commodity_reserve;
                }
                
                asset from_reserve_ex = asset_change_precision(from_reserve, ARITHMETIC_PRECISION);
                asset to_reserve_ex = asset_change_precision(to_reserve, ARITHMETIC_PRECISION);
                asset quantity_ex = asset_change_precision(quantity, ARITHMETIC_PRECISION);

                asset rate = asset_divide(
                    to_reserve_ex, from_reserve_ex + quantity_ex);

                asset conversion_ex = asset_multiply(quantity_ex - fee, rate);
                asset conversion = asset_change_precision(
                    conversion_ex, to_reserve.symbol.precision());

                return make_tuple(conversion, rate);
            }

            void record_conversion(
                name sender,
                name recipient,
                asset rate,
                asset sent, asset result
            ) {
                action(
                    permission_level{contract, "active"_n},
                    vapaee::dex::contract,
                    "poolswap"_n,
                    make_tuple(
                        sender, recipient,
                        rate, sent, result)
                ).send();
            }

            void record_fund_attempt(
                uint64_t pool_id,
                name funder,
                asset quantity
            ) {
                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(pool_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);

                fund_history history(contract, pool_id);
                history.emplace(contract, [&](auto & row) {
                    row.id = history.available_primary_key();
                    row.date = current_time_point();
                    row.funder = funder;
                    row.quantity = quantity;
                    row.commodity_reserve = pool_it->commodity_reserve;
                    row.currency_reserve = pool_it->currency_reserve;
                });
            }

            void update_participation(uint64_t pool_id, name funder, asset part_delta) {
                participation_scores pscores(contract, pool_id);
                auto score_it = pscores.find(funder.value);

                if (score_it == pscores.end())
                    pscores.emplace(contract, [&](auto & row) {
                        row.funder = funder;
                        row.score = part_delta;
                    });
                else
                    pscores.modify(score_it, contract, [&](auto & row) {
                        row.score += part_delta;
                    });
            }

            void withdraw_participation(name funder, uint64_t pool_id, asset score) {
                // validate pool
                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(pool_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);

                // validate funder
                participation_scores pscores(contract, pool_id);
                auto score_it = pscores.find(funder.value);
                check(score_it != pscores.end(), ERR_NOT_FUNDER);

                // validate participation
                check(score_it->score >= score, ERR_INSUFFICENT_PART);

                pscores.modify(score_it, contract, [&](auto & row) {
                    row.score -= score;
                });

                asset part_ratio = asset_divide(score, pool_it->total_participation);

                asset commodity_quant = asset_multiply(
                    part_ratio, pool_it->commodity_reserve);

                asset currency_quant = asset_multiply(
                    part_ratio, pool_it->currency_reserve);

                pool_markets.modify(pool_it, contract, [&](auto & row) {
                    row.commodity_reserve -= commodity_quant;
                    row.currency_reserve -= currency_quant;
                    row.total_participation -= score;
                });

                // finally withdraw funds to funder wallet
                action(
                    permission_level{contract, "active"_n},
                    get_contract_for_token(commodity_quant.symbol.code()),
                    "transfer"_n,
                    make_tuple(
                        contract, funder, commodity_quant, string(THANK_YOU_MSG))
                ).send();

                action(
                    permission_level{contract, "active"_n},
                    get_contract_for_token(currency_quant.symbol.code()),
                    "transfer"_n,
                    make_tuple(
                        contract, funder, currency_quant, string(THANK_YOU_MSG))
                ).send();

            }

            void create_fund_attempt(name funder, uint64_t market_id) {
                require_auth(funder);
                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(market_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);
                check(is_account(funder), ERR_ACCOUNT_NOT_FOUND);

                fund_attempts funding_attempts(contract, funder.value);
                funding_attempts.emplace(contract, [&](auto & row) {
                    row.market_id = market_id;
                    row.commodity = asset(0, pool_it->commodity_reserve.symbol);
                    row.currency = asset(0, pool_it->currency_reserve.symbol);
                });
            }

            void end_fund_attempt(name funder, uint64_t market_id) {
                fund_attempts funding_attempts(contract, funder.value);
                auto fund_it = funding_attempts.find(market_id);
                
                check(fund_it != funding_attempts.end(), ERR_ATTEMPT_NOT_FOUND);

                asset commodity_ex = asset_change_precision(
                        fund_it->commodity, ARITHMETIC_PRECISION);
                asset currency_ex = asset_change_precision(
                        fund_it->currency, ARITHMETIC_PRECISION);

                pools pool_markets(contract, contract.value);
                auto pool_it = pool_markets.find(fund_it->market_id);
                check(pool_it != pool_markets.end(), ERR_POOL_NOT_FOUND);

                asset comm_delta, curr_delta;

                if (pool_it->commodity_reserve.amount == 0 &&
                    pool_it->currency_reserve.amount == 0) {
                    // if both reserves are zero, this is initial founding,
                    // accept any ratio and return
                    comm_delta = fund_it->commodity;
                    curr_delta = fund_it->currency;
                } else {

                    asset fund_rate = asset_divide(commodity_ex, currency_ex);
                    asset pool_rate = get_pool_rate(fund_it->market_id);
                        
                    if (fund_rate == pool_rate) {
                        comm_delta = fund_it->commodity;
                        curr_delta = fund_it->currency;
                    } else {  // non exact ratio, return surplus
                        asset diff;

                        if (fund_rate < pool_rate) {
                            // surplus of currency  in fund attempt
                            asset inv_rate = inverse(pool_rate, currency_ex.symbol);
                            asset inv_fund_rate = asset_divide(currency_ex, commodity_ex);
                            diff = asset_change_symbol(
                                asset_multiply(
                                    inv_fund_rate - inv_rate,
                                    commodity_ex),
                                fund_it->currency.symbol);
                            comm_delta = fund_it->commodity;
                            curr_delta = fund_it->currency - diff;
                        } else {
                            // surplus of commodity in fund attempt
                            asset delta =  asset_multiply(
                                pool_rate,
                                asset_change_symbol(currency_ex, commodity_ex.symbol));
                            diff = commodity_ex - delta;
                            diff = asset_change_symbol(diff, fund_it->commodity.symbol);
                            comm_delta = fund_it->commodity - diff;
                            curr_delta = fund_it->currency;
                        }

                        // return surplus to keep ratio intact
                        if (diff.amount > 0) {
                            /*
                            * because difference is calculated at a higher precision
                            * and then converted back amount could be 0
                            */
                            action(
                                permission_level{contract, "active"_n},
                                get_contract_for_token(diff.symbol.code()),
                                "transfer"_n, 
                                make_tuple(contract, funder, diff, "return surplus of funding attempt to market " + to_string(market_id))
                            ).send();
                        }

                    }
                }

                asset comm_reserve = pool_it->commodity_reserve;
                asset curr_reserve = pool_it->currency_reserve;
               
                // investor participation score
                //
                // pd = participation score delta
                // pt = participation score total
                //
                // cd = currency delta
                // ct = total currency reserve
                //
                // pd = (cd / ct) * pt
                
                asset pd;
                asset pt = pool_it->total_participation;

                if (pt.amount == 0)
                    pd = PART_UNIT; 

                else {
                    asset cd = asset_change_symbol(curr_delta, PART_SYM);
                    asset ct = asset_change_symbol(curr_reserve, PART_SYM);

                    pd = asset_multiply(asset_divide(cd, ct), pt);
                }

                update_participation(pool_it->id, funder, pd);

                // finally update pool
                pool_markets.modify(pool_it, contract, [&](auto &row) {
                    row.commodity_reserve += comm_delta;
                    row.currency_reserve += curr_delta;
                    row.total_participation += pd;
                });

                // cleanup
                funding_attempts.erase(fund_it);
            }

        };  // namespace utils

    };  // namespace pool

};  // namespace vapaee
