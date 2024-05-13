dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"
DEVELOPER_NEURON_ID_BLOB="\37\17\34\62\e8\22\35\78\8f\25\92\e0\76\b3\1c\f0\e8\60\1e\ff\16\b2\a8\68\7b\56\45\89\d8\67\de\36"

TITLE="Token Symbol Change from CAT to CTZ"
URL="https://catalyze.one"
MOTION_TEXT=""
SUMMARY="
The Catalyze DAO Association hereby proposes a change of the current token symbol from "CAT" to "CTZ". This change aims to distinguish the project’s token from the numerous existing tokens with the same symbol, many of which are meme coins, and to enhance the distinctiveness and branding of the token within the cryptocurrency ecosystem.
\n\n

## Rationale\n\n
- **Market Confusion:** The widespread use of the "CAT" symbol across various platforms, predominantly for meme-based cryptocurrencies, has led to significant market confusion and diluted brand identity.
- **Branding and Identity:** Adopting "CTZ" will establish a unique identity, more closely aligning with our brand and mission. This new symbol signifies a fresh start and a clear separation from associations that do not reflect our organization's goals.
- **Strategic Marketing:** A less common token symbol can aid in marketing efforts by ensuring that our token is not overshadowed by others with similar names. This unique symbol can improve visibility in exchanges and listings, enhancing accessibility.
- **Technical Efficiency:** A distinctive token symbol may help avoid technical issues related to token misidentification and transaction errors in exchanges and wallets, ensuring refined operations for our community.
\n\n

## Proposed Change\n\n
- **Old Token Symbol:** CAT
- **New Token Symbol:** CTZ
\n\n

## Implementation\n\n
Upon approval of this proposal, the change of the token symbol from "CAT" to "CTZ" will occur automatically. This will ensure a seamless transition and minimize any disruption across platforms.
\n\n

## Conclusion\n\n
We believe that changing our token symbol from "CAT" to "CTZ" will significantly benefit in terms of branding, network identity, and operational efficiency. We request the community’s support in this strategic move to better represent our token’s role and utility in the ecosystem.
"


dfx canister call \
 --network ic umz53-fiaaa-aaaaq-aabmq-cai \
 manage_neuron \
 "(
   record {
      subaccount = blob \"${DEVELOPER_NEURON_ID_BLOB}\";
      command = opt variant {
            MakeProposal = record { 
               title=\"${TITLE}\"; 
               url=\"${URL}\"; 
               summary=\"${SUMMARY}\"; 
               action=opt variant {
                  ManageLedgerParameters = record { 
                     token_symbol=opt \"CTZ\"; 
                     transfer_fee=null; 
                     token_logo=null; 
                     token_name=null; 
                     }
                  }
               }
            };
         }
 )"

# quill sns  \
#    --canister-ids-file ./sns_canister_ids.json  \
#    --pem-file "${PEM_FILE}"  \
#    make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {ManageLedgerParameters = record { token_symbol=opt \"CTZ\"; transfer_fee=null; token_logo=null; token_name=null; }}})" "${DEVELOPER_NEURON_ID}" > msg.json

# quill send --yes msg.json