#pragma once
#include <vapaee/base/base.hpp>
#include <vapaee/tprofile/tables.hpp>
#include <vapaee/tprofile/modules/prof.hpp>

using namespace vapaee::tprofile::prof;  // signed_by_any_owner

namespace vapaee {
    namespace tprofile {
        namespace org {

            static name ORG_CREATOR = "creator"_n;
            static name ORG_ADMINISTRATOR = "admin"_n;

            template<typename member_iter_t>
            bool has_role(name role, member_iter_t& member_iter) {
                return find(
                    member_iter->roles.begin(),
                    member_iter->roles.end(),
                    role
                ) != member_iter->roles.end();
            }

            void action_add_organization(string creator_alias, string org_name) {
                profiles prof_table(contract, contract.value);

                auto alias_index = prof_table.get_index<"alias"_n>();
                auto profile_iter = alias_index.find(vapaee::utils::hash(creator_alias));
                check(profile_iter != alias_index.end(), "profile not found");

                name owner = signed_by_any_owner<decltype(profile_iter)>(profile_iter);
                check(owner != "null"_n, "not authorized");

                organizations org_table(contract, contract.value);
                auto oname_index = org_table.get_index<"orgname"_n>();
                auto org_iter = oname_index.find(vapaee::utils::hash(org_name));
                check(org_iter == oname_index.end(), "organization exists");

                org_table.emplace(owner, [&](auto& row) {
                    row.id = org_table.available_primary_key();
                    row.org_name = org_name;

                    members member_table(contract, row.id);
                    member_table.emplace(owner, [&](auto& row) {
                        row.profile_id = profile_iter->id;
                        row.roles.push_back(ORG_CREATOR);
                    });
                });
            }

            void action_add_member(
                string admin_alias,
                string org_name,
                string user_alias
            ) {
                profiles prof_table(contract, contract.value);

                auto alias_index = prof_table.get_index<"alias"_n>();
                auto admin_iter = alias_index.find(vapaee::utils::hash(admin_alias));
                check(admin_iter != alias_index.end(), "profile not found (admin)");

                auto user_iter = alias_index.find(vapaee::utils::hash(user_alias));
                check(user_iter != alias_index.end(), "profile not found (user)");

                name owner = signed_by_any_owner<decltype(admin_iter)>(admin_iter);
                check(owner != "null"_n, "not authorized (sig)");

                organizations org_table(contract, contract.value);
                auto oname_index = org_table.get_index<"orgname"_n>();
                auto org_iter = oname_index.find(vapaee::utils::hash(org_name));
                check(org_iter != oname_index.end(), "organization not found");
                
                members member_table(contract, org_iter->id);
                auto admin_ms_iter = member_table.find(admin_iter->id);
                check(admin_ms_iter != member_table.end(), "not a member (admin)");
                check(
                    has_role<decltype(admin_ms_iter)>(ORG_CREATOR, admin_ms_iter) ||
                    has_role<decltype(admin_ms_iter)>(ORG_ADMINISTRATOR, admin_ms_iter), 
                    "not authorized (org)"
                );

                auto user_ms_iter = member_table.find(user_iter->id);
                check(user_ms_iter == member_table.end(), "already a member");

                member_table.emplace(owner, [&](auto& row) {
                    row.profile_id = user_iter->id;
                });

            }

            void action_add_role(
                string admin_alias,
                string org_name,
                name role_name,
                string user_alias
            ) {
                check(role_name != ORG_CREATOR, "can't give that role");

                profiles prof_table(contract, contract.value);

                auto alias_index = prof_table.get_index<"alias"_n>();
                auto admin_iter = alias_index.find(vapaee::utils::hash(admin_alias));
                check(admin_iter != alias_index.end(), "profile not found (admin)");

                auto user_iter = alias_index.find(vapaee::utils::hash(user_alias));
                check(user_iter != alias_index.end(), "profile not found (user)");

                name owner = signed_by_any_owner<decltype(admin_iter)>(admin_iter);
                check(owner != "null"_n, "not authorized (sig)");

                organizations org_table(contract, contract.value);
                auto oname_index = org_table.get_index<"orgname"_n>();
                auto org_iter = oname_index.find(vapaee::utils::hash(org_name));
                check(org_iter != oname_index.end(), "organization not found");
                
                members member_table(contract, org_iter->id);
                auto admin_ms_iter = member_table.find(admin_iter->id);
                check(admin_ms_iter != member_table.end(), "not a member (admin)");
                check(
                    has_role<decltype(admin_ms_iter)>(ORG_CREATOR, admin_ms_iter) ||
                    has_role<decltype(admin_ms_iter)>(ORG_ADMINISTRATOR, admin_ms_iter), 
                    "not authorized (org)"
                );

                auto user_ms_iter = member_table.find(user_iter->id);
                check(user_ms_iter != member_table.end(), "not a member (user)");
                check(
                    !has_role<decltype(user_ms_iter)>(role_name, user_ms_iter),
                    "user has the role"
                );

                member_table.modify(user_ms_iter, owner, [&](auto& row) {
                    row.roles.push_back(role_name);
                });
            }

        }
    }
};