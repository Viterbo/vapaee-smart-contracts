// TABLE uncommited
// All new entries made by a dapp will be created on the dapp's RAM.
// In order to push the user to pay for the RAM, they need to commit
// the changes made by the dapp in his/her name.
// scope: contract
TABLE uncommited_table {
    uint64_t id;
    name table;            // table where the entry is located
    name scope;            // scope to instanciate the table
    uint64_t key;          // primary key to find the entry
    name owner;            // creator who needs to commit and be chargen for all the RAM used on recently
                           // created entries by the dapp on owner's behalf
};


typedef eosio::multi_index<"uncommited"_n, uncommited_table> uncommited;