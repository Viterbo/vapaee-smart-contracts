// TABLE multiplicity
// In the vast majority of nfts will have a quantity of 1.
// But in the cases of issuing multiple instances of a particular nft
// instead of creating multiple entries on nft table we use
// the multiplicity table to extend the nft entry and say how many instances are hold in the same entry.
// The user can separate them later using split.
// scope: owner
TABLE multiplicity_table {
    uint64_t    nft_id;              // extends an entry on the nfts table
    uint64_t  quantity;              // Indicates how many instances this entry holds.
    uint64_t primary_key() const {
        return nft_id;
    }
};

typedef eosio::multi_index<"multiplicity"_n, multiplicity_table> multiplicity;