dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Upgrade SNS to new version"
URL="https://catalyze.one"
SUMMARY="We propose an upgrade of the SNS canister to the latest version to ensure optimal performance and security.\n\n"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant { UpgradeSnsToNextVersion = record {}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json