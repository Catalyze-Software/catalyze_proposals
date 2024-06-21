dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Register proxy canister"
URL="https://catalyze.one"
CANISTER_PRINCIPAL="2jvhk-5aaaa-aaaap-ahewa-cai"
SUMMARY="
# Addition of a New Canister to the Existing Catalyze SNS

The Catalyze DAO Association proposes to register the “Proxy” canister as an SNS controlled canister. This initiative is designed to streamline operations and enhance the security measures on the Catalyze platform.

## Technical Details:
- **Name**: Proxy canister
- **Canister id**: 2jvhk-5aaaa-aaaap-ahewa-cai

## Key Features:
- **Stable Storage**: Utilizes stable storage to enhance data integrity and accessibility
- **Faster Lookup**: Optimizes data retrieval to improve responsiveness
- **Depreciation of Custom Identifiers**: Streamlines data management
- **Easier Upgradability**: Facilitates upgrades through a tag-based changelog


## Conclusion:
By approving this proposal to hand over the Proxy canister to the Catalyze DAO on the SNS, the Catalyze platform will benefit from improved performance, enhanced security, and streamlined operations, supporting our commitment to delivering a superior service experience.
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {RegisterDappCanisters = record {canister_ids=vec {principal \"${CANISTER_PRINCIPAL}\"}}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json