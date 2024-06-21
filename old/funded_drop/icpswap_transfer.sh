# DOES NOT WORK CORRECTLY YET

dfx identity use catalyze-funded-drop
OWNER_PRINCIPAL=$(dfx identity get-principal)

# GET THE BALANCE OF OWNER PRINCIPAL
get_balance() {
  echo "GET BALANCE:"
  
  quill sns \
    balance \
    --of sawyp-svn6p-3z3k5-qddau-v3mwm-rk2kk-o4hms-wef5g-bjvbn-dhvjj-2qe \
    --canister-ids-file ./sns_canister_ids.json \
    -y 
}

transfer() {
  echo "TRANSFER:"
  
  quill sns \
    transfer \
    --amount 90 \
    --fee 0.001 \
    --pem-file ./catalyze-funded-drop.identity.pem \
    --canister-ids-file ./sns_canister_ids.json \
    sawyp-svn6p-3z3k5-qddau-v3mwm-rk2kk-o4hms-wef5g-bjvbn-dhvjj-2qe \
    > msg.json

  quill send --yes msg.json
}

# get_balance
transfer