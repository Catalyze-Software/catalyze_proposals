dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

AMOUNT_E8s=10000000000000
TO_PRINCIPAL="yp332-553wz-7hgwn-4tsih-ds34g-mrqmq-5onyf-qrcci-g6m6n-2yni4-dae"
DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Budget proposal"
URL="https://catalyze.one"
SUMMARY="
The software development service provider (Hubmaker Labs LLC) seeks funding from the Catalyze SNS DAO to advance the growth and development of the Catalyze platform. This 'Proposal for Funding' aims to allocate 100,000 ICP from the Catalyze DAO Treasury to the Catalyze Developer Organization.\n\n
The funds will be utilized to cover the operational costs of the service provider as it delivers the Roadmap mentioned below. The funding is expected to span a 4 month duration, providing support until the end of January 2024.\n\n

## Budget Breakdown\n\n

### Team Salaries\n\n

- Compensation for the existing 7 team members dedicated to Catalyze's mission.

### Operational Expenses\n\n

- Remote work-related expenses, including tools, software, and communication platforms that facilitate remote collaboration
- General operational expenses to support the day-to-day functions of a remote team.

### Legal and Compliance\n\n

- Legal services to navigate evolving regulatory landscapes, compliance, contractual obligations

### Third party services\n\n

- Costs related to third-party tools, technologies, and services necessary for Catalyze's seamless operation (ex. Matrix)

### Marketing, Community Engagement and Support\n\n

- Marketing campaigns, Social Media management, and other promotional activities to increase the exposure of the Catalyze platform.
- Allocation for remote community managers and moderators.

## Roadmap\n\n

#### 1. Roll out phase 1 of Catalyze’s roadmap\n\n

- Phased launch of the redesigned app with an upgraded UI/UX for an improved user experience. Example of new features that will gradually be launched
  - Fungible tokens and NFT airdropping
  - Boosting model for communities
  - Tipping system to enhance community interaction
- Move Canisters to stable storage
- Begin the development of an in-app SNS Proposal system to streamline community interactions and governance

#### 2. Begin Preparations for Android and IOS App development

## Motion Proposals and Community Engagement\n\n

In line with Catalyze's decentralized ethos, any member of the Catalyze SNS DAO can propose motion proposals. These proposals will be actively discussed and deliberated upon on a dedicated group on the Catalyze platform, empowering the community to actively shape the direction and progress of Catalyze.\n\n

## Conclusion\n\n

The proposed funding of 100,000 ICP will drive the achievement of key milestones outlined in the roadmap. By supporting the core dev team, enabling front-end enhancements, maintaining the platform, scaling up of marketing efforts, Catalyze aims to solidify its position as a significant player within the web3 ecosystem.\n\n
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {TransferSnsTreasuryFunds = record {from_treasury=1:int32; amount_e8s=${AMOUNT_E8s}:nat64; to_principal=opt principal \"${TO_PRINCIPAL}\";memo=null; to_subaccount=null;}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json