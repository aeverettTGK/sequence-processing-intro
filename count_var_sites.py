#! /usr/bin/env python3

import sys
from Bio import SeqIO
from Bio.Seq import Seq

def read_sequences(file):
    sequences = SeqIO.to_dict(SeqIO.parse(file, "fasta"))
    return sequences

def translate_to_aa(sequences):
    translated_seq = {}
    for seq_id, dna_sequence in sequences.items():
        dna_seq = Seq(str(dna_sequence.seq))
        amino_acid_seq = dna_seq.translate()
        translated_seq[seq_id] = amino_acid_seq
    return translated_seq

def count_var_site(seq_objects):
    count = 0
    sequences = list(seq_objects.values())
    for pos in range(len(sequences[0])):
        letters = [seq[pos] for seq in sequences]
        if len(set(letters)) > 1:
            count += 1
    return count

def create_aa_alignment(sequences):
    with open("ExampleProteinAlignment.fasta", "w") as outfile:
        for seq_id, sequence in sequences.items():
            outfile.write(str(seq_id) + "\n")
            outfile.write(str(sequence) + "\n")

def main():
    alignment = sys.argv[1]
    sequences = read_sequences(alignment)
    translated_seqs = translate_to_aa(sequences)
    var_site_n = count_var_site(sequences)
    var_site_aa = count_var_site(translated_seqs)
    create_aa_alignment(translated_seqs)
    print(var_site_n, var_site_aa)

if __name__=="__main__":
    main()
