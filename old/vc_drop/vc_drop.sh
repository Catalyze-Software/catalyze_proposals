dfx identity use catalyze-vc-drop
OWNER_PRINCIPAL=$(dfx identity get-principal)


# GET THE BALANCE OF OWNER PRINCIPAL
get_balance() {
  echo "GET BALANCE:"
  
  quill sns \
    balance \
    --of ${OWNER_PRINCIPAL} \
    --canister-ids-file ./sns_canister_ids.json \
    -y 
}

# CREATE A NEW NEURON WITH ALL TOKENS TO SPLIT INTO DIFFERENT NEURONS
create_neuron() {
  echo "CREATE MAIN NEURON:"

  local MEMO=$1
  local AMOUNT=$2
  
  quill sns \
    stake-neuron \
    --memo $MEMO \
    --pem-file ./catalyze-vc-drop.identity.pem \
    --amount $AMOUNT \
    --fee 0.001 \
    --canister-ids-file ./sns_canister_ids.json \
    > msg.json
    
  quill send --yes msg.json
}

# GET THE NEURON ID FOR THE NEWLY CREATED NEURON
get_neuron_id_by_memo() {
  local MEMO=$1
  
  quill sns \
    neuron-id \
    --memo ${MEMO} \
    --pem-file ./catalyze-vc-drop.identity.pem \
    --principal-id ${OWNER_PRINCIPAL} \
    --canister-ids-file ./sns_canister_ids.json | sed -e 's/.* //'
}

# SPLIT NEURON
split_neuron() {
  echo "SPLIT NEURON IN DIFFERENT NEURONS:"
  
  local NEURON_ID=$1
  local AMOUNT=$2
  local MEMO=$3

  quill sns \
    split-neuron \
    $NEURON_ID \
    --memo $MEMO \
    --amount $AMOUNT \
    --pem-file ./catalyze-vc-drop.identity.pem \
    --canister-ids-file ./sns_canister_ids.json \
    > msg.json 

  quill send --yes msg.json

}

# SET DISSOLVE DELAY
set_dissolve_delay() {
  echo "SET DISSOLVE DELAY:"
  
  local NEURON_ID=$1
  local DISSOLVE_DELAY_SECONDS=$2

  quill sns \
    configure-dissolve-delay \
    $NEURON_ID \
    --pem-file ./catalyze-vc-drop.identity.pem \
    --canister-ids-file ./sns_canister_ids.json \
    -a $DISSOLVE_DELAY_SECONDS \
    > msg.json

  quill send --yes msg.json
}

# SET PERMISSIONS FOR VC
add_vc_permissions() {
  echo "ADD VC PERMISSIONS:"
  
  local NEURON_ID=$1
  local PRINCIPAL=$2

  quill sns \
    neuron-permission \
    --pem-file ./catalyze-vc-drop.identity.pem \
    --canister-ids-file ./sns_canister_ids.json \
    --principal "${PRINCIPAL}" \
    --permissions unspecified,configure-dissolve-state,manage-principals,submit-proposal,vote,disburse,split,merge-maturity,disburse-maturity,stake-maturity,manage-voting-permission \
    add \
    $NEURON_ID \
    > msg.json

  quill send --yes msg.json
}

# REMOVE PERMISSIONS FOR INITIAL OWNER
remove_owner_permissions() {
  echo "REMOVE CURRENT OWNER AS CONTROLLER:"

  local NEURON_ID=$1
  local PRINCIPAL=$2

  quill sns \
  neuron-permission \
  --pem-file ./catalyze-vc-drop.identity.pem \
  --canister-ids-file ./sns_canister_ids.json \
  --principal "${PRINCIPAL}" \
  --permissions unspecified,configure-dissolve-state,manage-principals,submit-proposal,vote,disburse,split,merge-maturity,disburse-maturity,stake-maturity,manage-voting-permission \
  remove \
  $NEURON_ID \
  > msg.json

  quill send --yes msg.json
}

drop_neurons() {
  local VC_PRINCIPAL=$1
  local NEURON_0=$2
  local NEURON_1=$3
  local NEURON_2=$4
  # not needed but used as a check
  get_balance

  # MEMO AMOUNT DISSOLVE_DELAY_SECONDS
  NEURON_1_DELAY=31560000
  NEURON_2_DELAY=63120000

# To access the first element of the first tuple:
  IFS=' ' read -r neuron_0_memo neuron_0_amount <<< $NEURON_0

  # create the initial neuron that hold all tokens to be split into different neurons
  create_neuron $neuron_0_memo $neuron_0_amount
  initial_neuron=$(get_neuron_id_by_memo $neuron_0_memo)
  echo $initial_neuron

  # # NEURON 1 
  IFS=' ' read -r neuron_1_memo neuron_1_amount <<< $NEURON_1
  split_neuron $initial_neuron $neuron_1_amount $neuron_1_memo
  neuron_id_1=$(get_neuron_id_by_memo $neuron_1_memo)
  set_dissolve_delay $neuron_id_1 $NEURON_1_DELAY
  add_vc_permissions $neuron_id_1 $VC_PRINCIPAL
  # remove_owner_permissions $neuron_id_1 $OWNER_PRINCIPAL
  
  # NEURON 2
  IFS=' ' read -r neuron_2_memo neuron_2_amount <<< $NEURON_2
  split_neuron $initial_neuron $neuron_2_amount $neuron_2_memo
  neuron_id_2=$(get_neuron_id_by_memo $neuron_2_memo)
  set_dissolve_delay $neuron_id_2 $NEURON_2_DELAY
  add_vc_permissions $neuron_id_2 $VC_PRINCIPAL

  # this step should be last because its sets the owner as controller which removes the ability to split the neuron
  # INITIAL NEURON
  add_vc_permissions $initial_neuron $VC_PRINCIPAL
  # remove_owner_permissions $initial_neuron $OWNER_PRINCIPAL
}

remove_owner_permissions "3603fcb972dfd0ccc026bf8cb5e88675be7cb460d796d35f82ce13e763ff74ed" $OWNER_PRINCIPAL
remove_owner_permissions "72d40ccb8c10b52466dddb1bf56d847b3b90c511383df2b5bd431d42a94bc9bc" $OWNER_PRINCIPAL
remove_owner_permissions "e0df64e248e2e603a1e89812756f7161c50dff4442fc4f74742e680c14f4ff35" $OWNER_PRINCIPAL
# get_balance
# drop_neurons "ljxsi-5du4w-3se32-vba6v-dd543-rrj3g-nayx2-f7xhd-o4u7a-ycmxw-bae" "567 42500000.003" "568 19125000.001" "569 19125000.001"