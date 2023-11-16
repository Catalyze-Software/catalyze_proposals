dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=700000000000
TO_PRINCIPAL="yp332-553wz-7hgwn-4tsih-ds34g-mrqmq-5onyf-qrcci-g6m6n-2yni4-dae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Establishment of the Catalyze DAO Association in Geneva, Switzerland"
URL="https://catalyze.one"
SUMMARY="
As the driving force behind Catalyze DAO's technical advancements, HubMaker Labs is dedicated to ensuring the continued growth and resilience of the community. To fortify our commitment, we propose the establishment of the Catalyze DAO Association in Geneva, Switzerland. This strategic move not only enhances our legal standing but also safeguards our community, enabling us to operate with confidence, credibility, and a robust legal foundation. To implement this initiative, we seek your support and approval for a budget of 7,000 ICP. Your backing in this endeavor is pivotal, marking a significant stride towards a more secure and enduring future for the Catalyze DAO.\n\n

# Incorporation approval\n\n

We kindly request the Catalyze DAO's approval for the establishment of the Catalyze DAO Association in the Canton of Geneva, Switzerland. This legal entity will provide us with official recognition and enable us to operate with a stronger legal framework.\n\n

## Objectives:\n\n

- Legal Recognition: Obtain legal recognition for the Catalyze DAO Association in Switzerland, ensuring compliance with Swiss laws and regulations.
- Limitation of Liability: Unincorporated DAOs may expose their members to personal liability; a Swiss association answers for its obligations solely with its treasury, thus protecting the members from external claims.

## Choice of Association as a legal structure:\n\n

HubMaker Labs, in pursuit of legal clarity and strategic alignment, has diligently consulted with a reputable Swiss-based legal firm. Based on their expert advice, we propose adopting the association legal structure for the Catalyze DAO. This careful consideration ensures full compliance with local regulations and aligns seamlessly with Catalyze's community-driven ethos. In Switzerland, an association's purpose must inherently serve the greater good, mirroring Catalyze's altruistic objectives. This structure demands a minimum of two participants without the requirement of seed capital, establishing Catalyze as an independent legal entity. Members are shielded from personal liability for the association’s obligations, unless specified otherwise in the articles of association (Art. 75a, Swiss Civil Code). Embracing this framework not only ensures legal adherence but also fosters an environment conducive to community-driven development and decentralized collaboration.\n\n
More details on Swiss Associations as legal structures [here](https://www.kmu.admin.ch/kmu/en/home/concrete-know-how/setting-up-sme/starting-business/choosing-legal-structure/associations.html)

# Funding Requirements\n\n

To facilitate the incorporation process, we require a budget of 7,000 ICP. This fund will cover essential expenses, including legal fees, notary fees, local taxes and commercial register fees necessary for the formal establishment of the Catalyze DAO Association in compliance with Swiss laws and regulations.

## Detailed use of funds:\n\n

### Legal and Compliance\n\n

- Engage legal services in Switzerland to ensure compliance with local regulations, covering legal consultation fees and advisory services.
- Cover notary fees for official document verification and authentication.
- Allocate funds for commercial register fees required for the formal establishment of the Catalyze Association as a recognized entity with legal personality.


### Conclusion\n\n
In forging the future of Catalyze DAO, HubMaker Labs is resolute in ensuring our community's growth and resilience. Our proposal to establish the Catalyze DAO Association in Geneva, Switzerland, stands as a testament to this commitment. This strategic move not only enhances our legal standing but also fortifies our community, providing us the confidence, credibility, and robust legal foundation needed for sustained success. We earnestly seek your support and approval for a budget of 7,000 ICP to realize this vision. Your backing is the cornerstone of our progress, ushering in an era of secure, community-driven development and decentralized collaboration for Catalyze DAO.
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=1:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json