#!/bin/bash

# Source the common initialization script
source init_vars.sh


TITLE="Motion Proposal: Catalyze V1.0 Mainnet release"
URL="https://catalyze.one"
MOTION_TEXT=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUMMARY=$(cat $SCRIPT_DIR/summary.md)

quill sns  \
   --canister-ids-file $CANISTERS_PATH  \
   --pem-file $PEM_FILE  \
   make-proposal --proposal "(record { 
      title=\"$TITLE\"; 
      url=\"$URL\"; 
      summary=\"$SUMMARY\"; 
      action=opt variant {
         Motion = record {
            motion_text=\"$MOTION_TEXT\"
            }
         }
      }
   )" \
   "${DEVELOPER_NEURON_ID}" > $SCRIPT_DIR/msg.json

quill send --yes $SCRIPT_DIR/msg.json