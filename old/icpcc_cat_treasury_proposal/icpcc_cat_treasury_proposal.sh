dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=5000000000000
TO_PRINCIPAL="rdqvh-7d7ja-mt3xe-mxeqh-ejo26-piyo7-s2ap2-klyfw-ljixo-gehot-pae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Transfer 50,000 CAT tokens to participate in the Galactic Airdrop."
URL="https://catalyze.one"
SUMMARY="
# Summary\n\n
Alongside ICPCC 2024, a significant airdrop event titled the Galactic Airdrop is set to launch, aimed at attracting and onboarding new members into the #ICP ecosystem.\n\n
The Catalyze DAO has been invited to participate by contributing 50,000 CAT tokens to the reward pool. All tokens provided will be distributed to the viewers of the ICPCC 2024 livestream.\n\n

# About the Galactic Airdrop\n\n
- On May 10th, during ICPCC 2024, thousands of users will discover the #ICP ecosystem, making it the biggest onboarding event for the #ICP ecosystem since the Genesis event.
- During the live stream, viewers can use codes displayed on screen as “Airdrop Alerts” during the 9-hour event to claim rewards through a dedicated Galactic Airdrop app. This app also helps users explore and learn about other apps/projects in the ecosystem while preventing bots and cheating.\n\n

# Benefits for the Catalyze DAO
The Catalyze DAO has the opportunity to contribute its native token to the airdrop prize pool to enjoy these benefits:\n\n
- The Catalyze DAO will appear on the event's landing page
- The Catalyze DAO will have dedicated “Airdrop alert” slots during the live stream.
- The Catalyze DAO will be featured in the airdrop app, including our logo, a brief description, a link to our website, and links to our socials.\n\n

# Details\n\n
- The airdrop dApp will implement protections against bots and cheaters and was crafted by Seb - founder of Motoko Bootcamp
- Current partners include Ghost, ICPSwap, SNEED, Neutrinite DAO, ModClub, Windoge98, VaultBet, and more!
- To join as a partner, the Catalyze DAO needs to send tokens to the designated airdrop dApp wallet with Principal ID: rdqvh-7d7ja-mt3xe-mxeqh-ejo26-piyo7-s2ap2-klyfw-ljixo-gehot-pae\n\n
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=2:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json