#!/bin/bash

get_tokens_for_tiers() {
# Define the tier ranges with index offset
tier1_min=0
tier1_max=263
tier2_min=264
tier2_max=383
tier3_min=384
tier3_max=420

# Create an array to store the results
declare -a results

# Read the CSV file line by line
while IFS=, read -r accountIdentifier principal numberOfOwnedNFTs ownedNFTs ownedNFTsVisible minted numberOfMintedNFTs mintedNFTs mintedNFTsVisible mintValueICP sold numberOfSoldNFTs soldNFTs soldNFTsVisible sellValueICP bought numberOfBoughtNFTs boughtNFTs boughtNFTsVisible buyValueICP listings numberOfListedNFTs listedNFTs listedNFTsVisible minListingPriceICP collectionName collectionCanisterId; do

    # Split the list of owned NFTs
    IFS=';' read -r -a nfts <<< "$ownedNFTsVisible"
    
    # Loop over owned NFTssi
    for nft in "${nfts[@]}"; do
        if [ "$nft" != "ownedNFTsVisible" ]; then
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
            if (( tier > 0 )); then
                # NFT ID, Tier, tokens, principal
                results+=("$nft $tier $tokens $principal")
            fi
        fi
    done

done < ./funded_drop/data.csv

# Sort the results by NFT ID
IFS=$'\n' sorted_results=($(sort -t' ' -k1n <<<"${results[*]}"))

# Print the sorted results
for result in "${sorted_results[@]}"; do
    echo "$result"
done
}

get_tokens_for_tiers