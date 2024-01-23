#!/bin/bash

alignment="$1"

total_samples=$(grep "^>" "$alignment" | wc -l)
unique_dates=$(grep "^>Sample[0-9]+_[0-9]{1,2}+-[a-zA-Z]+" "$alignment" | sort | uniq)
num_unique=$(echo "$unique_dates" | wc -l)

echo "Total Samples: $total_samples" > log.txt
echo "Unique Sample Dates: $num_unique" >> log.txt

echo "Processing complete. Results written to log.txt"
