# Addition of a New Canister to the Existing Catalyze SNS

The Catalyze DAO Association proposes to register the multisig index canister as an SNS controlled canister.

## Technical Details:

- **Name**: Multisig Index Canister
- **Canister id**: o7ouu-niaaa-aaaap-ahhdq-cai

## Key Features:

- **Handling Multisig Operations**: Facilitates the creation of multisig wallets

## Multisig spawn:

- **Costs**: The costs of creating a multisig canister is the equivalent of 5T cycles in ICP
- **Fee**: On top of the costs catalyze charges 0.1 ICP per multisig spinup
- **Dynamic pricing**: Because prices are dynamically fetched, the frontend adds an extra 0.01 ICP to accommodate for these fluctuations
- **Refund**: When for whatever reason the minimum amount of cycles cant be reached, the user will be refunded the total amount minus the transaction fee

## Misc:

- **Multisig WASMs**: Catalyze developers are possible to update WASM's for newly deployed multisig canisters, this will later change into an approval based approach
- **Notications**: Catalyze developers have the possibility to change the canister that handles websocket notifications
