dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Sonic liquidity motion proposal"
URL="https://catalyze.one"
MOTION_TEXT=""
SUMMARY="
After discussions with the SONIC team, We propose to add liquidity to the [ICP/CAT pool](https://data.sonic.ooo/pools/ryjl3-tyaaa-aaaaa-aaaba-cai:uf2wh-taaaa-aaaaq-aabna-cai) on Sonic Dex \n\n
Following this motion proposal, we will submit 2 additional proposals to apply for the transfer of 1842 ICP and 500.000 CAT tokens, respectively from the Catalyze DAO treasury to the ICP/CAT Swap canister. \n\n

The destination account for both transfers will be the same but on 2 different ledgers and is as follows:\n\n

Principal: 3xwpq-ziaaa-aaaah-qcn4a-cai\n\n

Subaccount: [23, 143, 169, 66, 232, 160, 170, 179, 218, 163, 63, 38, 159, 6, 31, 38, 75, 140, 137, 94, 237, 98, 242, 255, 72, 168, 126, 63, 229, 212, 142, 29] (this is the Subaccount generated from the SONIC swap canister, hex encoded as 178fa942e8a0aab3daa33f269f061f264b8c895eed62f2ff48a87e3fe5d48e1d)\n\n

Simultaneously, [@sonic_ooo](https://twitter.com/sonic_ooo) & [@catalyze_one](https://twitter.com/catalyze_one) will tweet to verify these proposals.\n\n

If these proposals are approved, Sonic Dex will add the funds to the liquidity pool.
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {Motion = record {motion_text=\"${MOTION_TEXT}\"}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json