#!/bin/bash

get_tokens_for_tiers() {
# Define the tier ranges with index offset
tier1_min=0
tier1_max=262
tier2_min=263
tier2_max=382
tier3_min=383
tier3_max=421

# Create an array to store the results
declare -a results

# Read the CSV file line by line
while IFS=, read -r accountIdentifier principal numberOfOwnedNFTs ownedNFTs ownedNFTsVisible minted numberOfMintedNFTs mintedNFTs mintedNFTsVisible mintValueICP sold numberOfSoldNFTs soldNFTs soldNFTsVisible sellValueICP bought numberOfBoughtNFTs boughtNFTs boughtNFTsVisible buyValueICP listings numberOfListedNFTs listedNFTs listedNFTsVisible minListingPriceICP collectionName collectionCanisterId; do

    # Split the list of owned NFTs
    IFS=';' read -r -a nfts <<< "$ownedNFTs"
    
    # Loop over owned NFTssi
    for nft in "${nfts[@]}"; do
        if [ "$nft" != "ownedNFTs" ]; then
            if (( nft >= tier1_min && nft <= tier1_max )); then
                tier=1
                tokens=5000
            elif (( nft >= tier2_min && nft <= tier2_max )); then
                tier=2
                tokens=12500
            elif (( nft >= tier3_min && nft <= tier3_max )); then
                tier=3
                tokens=25000
            else
                tier=0
            fi
                # NFT ID, Tier, tokens, accountIdentifier
                results+=("$nft, $tokens, $accountIdentifier")
        fi
    done

done < ./funded_drop/data.csv

# Sort the results by NFT ID
IFS=$'\n' sorted_results=($(sort -t' ' -k1n <<<"${results[*]}"))

# Print the sorted results
for result in "${sorted_results[@]}"; do
# for result in "${results[@]}"; do
    echo "$result"
done
}

get_tokens_for_tiers