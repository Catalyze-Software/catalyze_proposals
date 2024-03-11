dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=7500000000000

TO_PRINCIPAL="yp332-553wz-7hgwn-4tsih-ds34g-mrqmq-5onyf-qrcci-g6m6n-2yni4-dae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Budget proposal"
URL="https://catalyze.one"
SUMMARY="
To advance the growth and development of the Catalyze platform during the first 4 to 5 months of 2024, HubMakerLabs, the software development service provider, is seeking funding from the Catalyze SNS DAO. This 'Funding Proposal' is designed to allocate 75,000 ICP from the Catalyze DAO Treasury to HubMaker Labs.\n\n

The last budget proposal proved instrumental in our journey to unveil the groundbreaking Catalyze platform by early 2024. We embarked on an ambitious endeavor, rewriting the entire app from the ground up, and the funds allocated from the previous proposal sustained our progress for a commendable four months. For the most current developments and comprehensive insights into our ongoing efforts and accomplishments, we warmly invite you to explore our monthly updates for Q4 of 2023, which are readily accessible through this link. These reports offer valuable glimpses into the dedication and determination propelling our mission forward.\n\n

## Overview\n\n

The requested funding will be instrumental in covering the operational costs of our organization as we work towards the ambitious goals outlined in the roadmap below. This funding will sustain our operations for 4 to 5 months.

## Budget Breakdown\n\n

### Team Salaries\n\n

- Compensation for the existing 10 team members dedicated to Catalyze's mission.

### Operational Expenses\n\n

- Covering remote work-related expenses, including tools, software, and communication platforms facilitating remote collaboration, as well as general operational expenses supporting the day-to-day functions of a remote team.

### Legal and Compliance\n\n

- Allocated for legal services to navigate evolving regulatory landscapes, compliance, and contractual obligations.

### Third party services\n\n

- Funding for third-party tools, technologies, and services essential for the seamless operation of Catalyze (e.g., Matrix).

### Marketing, Community Engagement and Support\n\n

- Allocated for marketing campaigns, social media management, and promotional activities to enhance the Catalyze platform's exposure. With the launch of Catalyze 2.0 on the horizon, we plan to increase our marketing efforts, including dynamic campaigns and community airdrops.

## Roadmap\n\n

#### 1. Release of Catalyze 2.0\n\n

Release of the major platform upgrade poised to revolutionize user experiences, scheduled for the early part of Q1.

#### 2. Engage-to-Earn Tokenomics Beta

Develop and start testing our upcoming engage-to-earn Tokenomics Beta.

#### 3. Voice channels

Catalyze 2.0 will introduce immersive voice channels enabling dynamic and interactive discussions and events.

#### 4. NFT minting

Unlocking a new realm of creativity, users will be able to mint their NFTs on the Catalyze platform, enabling unique digital asset creation.

#### 5. Airdropping function

We're rolling out an efficient token airdropping function that will simplify and streamline the distribution of rewards and tokens, fostering community engagement and inclusivity

#### 6. Liquidity pool (a separate proposal is coming)

In our commitment to bolstering the platform's sustainability and liquidity management, a dedicated proposal will soon outline our plans for the establishment of a robust liquidity pool, ensuring a stable and flourishing Catalyze ecosystem.

## Conclusion\n\n

The allocation of 75,000 ICP in funding is vital for reaching the pivotal milestones detailed in our roadmap. Through backing our core development team, facilitating front-end improvements, sustaining the platform, and expanding marketing endeavors, Catalyze strives to establish a strong presence within the web3 ecosystem.\n\n

"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=1:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json