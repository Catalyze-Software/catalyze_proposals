dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=184200000000

TO_PRINCIPAL="3xwpq-ziaaa-aaaah-qcn4a-cai"
SUBACCOUNT="23; 143; 169; 66; 232; 160; 170; 179; 218; 163; 63; 38; 159; 6; 31; 38; 75; 140; 137; 94; 237; 98; 242; 255; 72; 168; 126; 63; 229; 212; 142; 29"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Transfer 1842 ICP to ICP/CAT Pool on Sonic Dex"
URL="https://catalyze.one"
SUMMARY="
This is the second of 2 proposals which add liquidity to the [ICP/CAT](https://data.sonic.ooo/pools/ryjl3-tyaaa-aaaaa-aaaba-cai:uf2wh-taaaa-aaaaq-aabna-cai) pool on SONIC DEX\n\n

See our [motion proposal for LP creation](https://nns.ic0.app/proposal/?u=uly3p-iqaaa-aaaaq-aabma-cai&proposal=18)\n\n

Simultaneously, [@sonic_ooo](https://twitter.com/sonic_ooo) & [@catalyze_one](https://twitter.com/catalyze_one) will tweet to verify these proposals. If these proposals are approved, Sonic Dex will add the funds to the liquidity pool.
"

quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=1:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=opt record {subaccount= vec {${SUBACCOUNT}};}}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json