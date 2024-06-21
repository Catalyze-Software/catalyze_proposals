# init_vars.sh

dfx identity use catalyze_production
OWNER_IDENTITY=$(dfx identity whoami)
PEM_FILE="$(readlink -f "$HOME/.config/dfx/identity/${OWNER_IDENTITY}/identity.pem")"
EXPRESS_NEURON_ID="37173462e82235788f2592e076b31cf0e8601eff16b2a8687b564589d867de36"
DEVELOPER_NEURON_ID="a27696a58538320efc03d85cd214da64afd880c215dcf2fc23ebae49b831bd8d"
CANISTERS_PATH=./sns_canister_ids.json

# Export variables if needed to be available to child processes
export OWNER_IDENTITY
export PEM_FILE
export DEVELOPER_NEURON_ID
export EXPRESS_NEURON_ID
export CANISTERS_PATH