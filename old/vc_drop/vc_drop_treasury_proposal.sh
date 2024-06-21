dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=7236055500000000
TO_PRINCIPAL="tq27i-opimk-dj3aj-upksm-2cmdl-r67qb-oadk4-4bf2s-66uer-yfcox-pqe"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Seed and private investors treasury request"
URL="https://catalyze.one"
SUMMARY="In fulfillment of our commitment to Seed and private round token purchasers, we present this proposal to the Catalyze SNS DAO to approve the token budget allocation as agreed upon in the token purchase agreements. We firmly believe that honoring our agreements with these investors is essential for building trust and fostering a strong and supportive community around the Catalyze platform. \
    #### Token Budget Allocation Details: \
    Seed and private round token purchasers: As previously agreed, we propose the allocation of 72,360,555.00 tokens to Seed and private token purchasers who have been instrumental in laying the foundation of the Catalyze platform. \
    #### Budget and Distribution Plan: \
    The distribution of tokens will be conducted transparently and fairly, ensuring that each token purchaser receives the designated token allocation proportionate to their respective purchase amounts. The tokens will be dropped in 3 neurons each with a dissolve delay of one month but with vesting periods of 0, 1 and 2 years respectively. \
    #### Benefits and Objectives:
    Upholding Token Holder Trust: By fulfilling our promise to Seed and private token purchasers, we demonstrate our commitment to maintaining the trust and confidence they have placed in the Catalyze platform. Honoring our agreements is crucial for building lasting and meaningful relationships with our valued token holders. \
    In conclusion, this proposal seeks the approval of the Catalyze SNS DAO to fulfill our commitment to Seed and private token purchasers. By allocating the agreed-upon token budget, we reaffirm our dedication to transparency, trust, and community engagement. We invite the Catalyze SNS DAO to support this proposal and stand together in our journey to make Catalyze a flourishing and impactful platform within the web3 ecosystem. Together, we will create a sustainable and vibrant future for Catalyze and its community of token holders.
    "

quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=2:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json