#!/bin/bash

# Source the common initialization script
source init_vars.sh


TITLE="Registering multisig index canister"
URL="https://catalyze.one"
CANISTER_PRINCIPAL="o7ouu-niaaa-aaaap-ahhdq-cai"
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
         RegisterDappCanisters = record {
            canister_ids= vec {
               principal \"${CANISTER_PRINCIPAL}\"
               }
            }
         }
      }
   )" \
   "${DEVELOPER_NEURON_ID}" > $SCRIPT_DIR/msg.json

quill send --yes $SCRIPT_DIR/msg.json