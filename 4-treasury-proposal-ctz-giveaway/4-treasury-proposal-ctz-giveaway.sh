#!/bin/bash

# Source the common initialization script
source init_vars.sh


TITLE="CTZ giveaway proposal"
URL="https://catalyze.one"

RECEIVER_PRINCIPAL="yp332-553wz-7hgwn-4tsih-ds34g-mrqmq-5onyf-qrcci-g6m6n-2yni4-dae"
AMOUNT_E8s=3000000000000


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
         TransferSnsTreasuryFunds = record {
            from_treasury=2:int32;
            amount_e8s=${AMOUNT_E8s}:nat64;
            to_principal=opt principal \"${RECEIVER_PRINCIPAL}\";
            memo=null;
            to_subaccount=null;
            }
         }
      }
   )" \
   "${EXPRESS_NEURON_ID}" > $SCRIPT_DIR/msg.json

quill send --yes $SCRIPT_DIR/msg.json