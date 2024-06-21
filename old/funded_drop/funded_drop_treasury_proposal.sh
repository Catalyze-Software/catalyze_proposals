dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=376500000000000
TO_PRINCIPAL="kpfko-v2ia6-y6xzj-v63p6-vi7d6-kt2g5-ivicu-y3vdo-uis3r-44vog-vqe"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Funded NFT holders treasury request"
URL="https://catalyze.one"
SUMMARY="With deep appreciation for the support and confidence shown by Funded NFT token purchasers in the Catalyze project, we present this proposal to the Catalyze SNS DAO to approve the token budget allocation as agreed upon during the Funded NFT sale.
    #### Token Budget Allocation Details:
    Funded NFT token purchasers: As previously agreed upon, we propose the allocation of 3,765,000.00 tokens to Funded NFT token purchasers who have played a pivotal role in contributing to the development and advancement of the Catalyze platform.
    #### Budget and Distribution Plan:
    The distribution of tokens will be conducted transparently and equitably, ensuring that each token purchaser receives the designated token allocation proportionate to their respective investments.
    In conclusion, this proposal seeks the approval of the Catalyze SNS DAO to fulfill our commitment to Funded NFT token purchasers. By allocating this token budget, we reaffirm our dedication to transparency, accountability, and community engagement. We invite the Catalyze SNS DAO to support this proposal, signaling our collective commitment to creating a thriving and vibrant ecosystem for the Catalyze platform.
    "


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=2:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json