#!/bin/bash

alignment=$1

main(){
    var_site_n=0
    var_site_aa=0
    if [[ -f "$alignment" ]] && [[ "$alignment" == *.fasta ]]; then

        output=$(python3 count_var_sites.py "$alignment")
        IFS=" " read -r vs_nuc vs_aa <<< "$output"
        var_site_n=$((var_site_n + vs_nuc))
        var_site_aa=$((var_site_aa + vs_aa))

        . parse_alignment.sh "$alignment"
        echo "Number of Variable Sites in the DNA Alignment: $var_site_n" >> log.txt
        echo "Number of Variable Sites in the Amino Acid Alignment: $var_site_aa" >> log.txt
    fi
}

main
