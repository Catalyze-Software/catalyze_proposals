dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"

DEVELOPER_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"

TITLE="Proposal to add $EXE to Catalyze"
URL="https://catalyze.one"
MOTION_TEXT=""
SUMMARY="
This proposal is submitted to seek approval for the integration of the $EXE token (https://twitter.com/windoge_98, Canister ID: rh2pm-ryaaa-aaaan-qeniq-cai) into the Catalyze platform, specifically for tipping and airdrops. This token is aligned with the ICRC-1 standard and represents an initial step toward exploring the potential for incorporating additional tokens into the platform. This initiative aims to enrich community engagement and provide a framework for testing the integration of new tokens within our ecosystem. 
\n\n

## Proposal\n\n
The Catalyze SNS DAO is hereby presented with the following proposal, designed to uphold principles of innovation, community engagement, and prudent exploration:\n\n
- Approve the addition of the $EXE token, adhering to the ICRC-1 standard, to the Catalyze DAO for tipping and airdrops. This action is intended as a pilot of 60 days to assess the feasibility and community response to integrating additional tokens in the future.
\n\n

## Rationale\n\n
This proposal is founded on the Catalyze SNS DAO's core principles of inclusivity, engagement, and cautious innovation. It seeks to:
- Introduce the $EXE token as a tool for community members to express support and appreciation, enhancing community interaction.\n
- Serve as a test for the potential integration of other tokens, ensuring that our ecosystem remains dynamic and responsive to community interests and the evolving digital landscape.\n\n

## Disclaimer\n\n
Please note that the $EXE token is not owned or controlled by the Catalyze DAO. Community members are advised to exercise the usual cautions associated with meme tokens and to conduct their own research and due diligence before engaging with these tokens.
\n\n

## Conclusion\n\n
The adoption of this proposal would mark an important step towards exploring the integration of additional tokens into our ecosystem, reinforcing the DAO's commitment to innovation, community engagement, and cautious exploration. DAO members are kindly requested to consider and vote on this proposal, enabling us to proceed with this pilot initiative and potentially enrich our community engagement strategies.
"


quill sns  \
   --canister-ids-file ./sns_canister_ids.json  \
   --pem-file "${PEM_FILE}"  \
   make-proposal --proposal "(record { title=\"${TITLE}\"; url=\"${URL}\"; summary=\"${SUMMARY}\"; action=opt variant {Motion = record {motion_text=\"${MOTION_TEXT}\"}}})" "${DEVELOPER_NEURON_ID}" > msg.json

quill send --yes msg.json