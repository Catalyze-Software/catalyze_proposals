dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=1250000000000
TO_PRINCIPAL="pvuwl-3npdd-pgmoq-eqaii-lhh5m-gvjta-57xr2-rauoe-yzyub-gatcj-zae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Token restauration for community member"
URL="https://catalyze.one"
SUMMARY="
This proposal is submitted to address a recent occurrence where a Catalyze Funded NFT holder inadvertently directed its 12,500 CAT token allocation to the CAT ledger canister. The user has provided compelling evidence of their account identifier and the associated transaction, unequivocally demonstrating their intent to rightfully claim the allocation. For verification purposes, the transaction in question can be accessed via the following link: [transaction](https://dashboard.internetcomputer.org/sns/uly3p-iqaaa-aaaaq-aabma-cai/transaction/5045)/n/n
## Proposal\n\n
The Catalyze SNS DAO is hereby presented with the following proposal, designed to uphold principles of impartiality and transparency\n\n
- Initiate the restoration process to return 12,500 CAT tokens that were sent to the CAT ledger.\n\n 
## Rationale\n\n
This proposal is founded on the Catalyze SNS DAO's core principles of fairness, transparency, and community support. It seeks to rectify a confirmed user error, ensuring that the tokens are rightfully returned to their rightful owner.\n\n
## Funding\n\n
Notably, no supplementary funding is required for this proposal, as it pertains to the restoration of the user's own tokens\n\n
## Conclusion\n\n
The adoption of this proposal underscores the DAO's unwavering commitment to its community members and the principled framework upon which it is built. The DAO members are kindly requested to consider and cast their votes regarding this proposal in a timely manner, thus facilitating the prompt return of the misallocated tokens to the affected user.\n\n
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=2:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json