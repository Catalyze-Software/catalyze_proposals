dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Proposal for auditing the multisig wallet on the Catalyze Platform"
URL="https://catalyze.one"
MOTION_TEXT=""
SUMMARY="
We propose an audit of the Multisig Wallet feature, essential to the security and integrity of the Catalyze platform.
\n\n

## Objective\n\n
To uphold the highest standards of security, we seek to audit the Multisig Wallet, identifying and mitigating any vulnerabilities to ensure operational reliability and safeguard user assets.
\n\n

## Auditing Partner\n\n
We recommend partnering with Beosin, a security firm with expertise in blockchain security and prior experience auditing our systems, making them ideal for this detailed audit.
\n\n
- Website [Beosin](https://www.beosin.com/?lang=en-US)
- Twitter [@Beosin_com](https://twitter.com/Beosin_com)
\n\n

## Multsig wallet repository\n\n
For a detailed insight into the current architecture of the Multisig Wallet, the repository can be accessed here:
\n\n
- Github [Catalyze multisig wallet repository](https://github.com/Catalyze-Software/multisig)
\n\n

## Cost of Audit\n\n
The total estimated cost for this audit is:
\n\n
- **ICP equivalent of USD 4,000**
- **CAT tokens equivalent to USD 1,500**
\n\n

## Proposal for DAO Action\n\n
Upon approval of this motion, we will initiate two treasury requests to fund the audit:
\n\n
- A request for ICP equivalent to USD 4,000
- A request for CAT tokens equivalent to USD 1,500
\n\n

## Conclusion\n\n
Approving this audit proposal reinforces the Catalyze DAO’s commitment to maintaining a secure and trustworthy platform. This proactive measure is crucial for ensuring the integrity of our Multisig Wallet, supporting our platform's operational excellence and securing community assets. We value the DAO’s support in this vital security endeavor.\n\n
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {Motion = record {motion_text=\"${MOTION_TEXT}\"}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json