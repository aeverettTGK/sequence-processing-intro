#!/bin/bash

alignment=$1

seq_process(){
    var_site_n=0
    var_site_aa=0
    if [[ -f "$alignment" ]] && [[ "$alignment" == *.fasta ]]; then
        . parse_alignment.sh "$alignment"
        output=$(python3 count_var_sites.py "$alignment")
        IFS=" " read -r vs_nuc vs_aa <<< "$output"
        var_site_n=$((var_site_n + vs_nuc))
        var_site_aa=$((var_site_aa + vs_aa))

        echo "Number of Variable Sites in the DNA Alignment: $var_site_n" >> log.txt
        echo "Number of Variable Sites in the Amino Acid Alignment: $var_site_aa" >> log.txt
    fi

    echo "Processing compeleted. Results written to log.txt"
}

seq_process

palignment="ProteinAlignment.fasta"

directive(){
    output_dir="sequence_data"
    mkdir -p "$output_dir"
    echo "Creating parent directory for sequence data"

    while read -r line
    do
        if [[ $line == ">"* ]]; then
            seq_id=$(echo "$line" | tr -d ">" | tr -d " ")
            seq_dir="$output_dir/$seq_id"
            mkdir -p "$seq_dir"
            echo "$line" > "$seq_dir/dna_sequence.fasta"
            read -r dna_sequence
            echo "$dna_sequence" >> "$seq_dir/dna_sequence.fasta"
        fi
    done < "$alignment"
    echo "Nucleotide sequences sorted."

	while read -r line
    do
        if [[ $line == ">"* ]]; then
            seq_id=$(echo "$line" | tr -d ">" | tr -d " ")
            echo "$line" > "$seq_dir/aa_sequence.fasta"
            read -r aa_sequence
            echo "$aa_sequence" >> "$seq_dir/aa_sequence.fasta"
        fi
    done < "$palignment"
    echo "Amino acid sequences sorted."

    echo "Directory creation completed."
}

directive
