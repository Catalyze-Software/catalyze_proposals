dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Register static assets canister"
URL="https://catalyze.one"
MOTION_TEXT=""
SUMMARY="
# Addition of a New Canister to the Existing Catalyze SNS

We are pleased to announce the deployment of the first of a series of new canisters under the control of the existing Catalyze SNS. This addition represents a significant step in enhancing the functionality and efficiency of our established service.

## Canister description
- **Name**: Static assets canister
- **Purpose**: This canister is responsible serving versioned static assets

## Objectives
- **Enhancement**: Integrate new capabilities to improve the existing SNS infrastructure.
- **Evaluation**: Use this initial canister as a benchmark to assess enhancements and gather user feedback.

## Significance
The integration of this new canister into the existing SNS framework is crucial for advancing the service's capabilities, ensuring continued scalability, and maintaining high performance.

## Future Steps
Following the successful implementation and assessment of this canister, we will continue with the planned addition of more canisters, each designed to further refine and expand the functionalities of the Catalyze SNS.

We appreciate your continued support and feedback as we enhance our services.
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {RegisterDappCanisters = record {canister_ids=vec {principal \"yimtt-ziaaa-aaaap-ahe3q-cai\"}}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json