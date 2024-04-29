dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=6500000000000
TO_PRINCIPAL="yp332-553wz-7hgwn-4tsih-ds34g-mrqmq-5onyf-qrcci-g6m6n-2yni4-dae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Request for CAT Funding for MultiSig Wallet Audit"
URL="https://catalyze.one"
SUMMARY="
Following the Catalyze DAO's approval of the motion proposal to audit the MultiSig Wallet, we now request the necessary funds to cover the audit costs.\n\n

# Funding Request \n\n
We seek an allocation of 65,000 CAT tokens (equivalent to USD 1,500 on April 29, 2024) from the Catalyze DAO treasury to finance the audit conducted by Beosin.\n\n

# Details\n\n
- **Audit Scope:** Comprehensive security review of the MultiSig Wallet.
- **More Information:** Full details on the audit scope and objectives are available in the previously approved motion proposal (insert Motion proposal link).\n\n

**Conclusion**\n\n 
This allocation of CAT tokens is crucial for funding the security enhancements of our MultiSig Wallet. We encourage all DAO members to vote in favor of this proposal to support our ongoing commitment to platform security.\n\n
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=2:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json