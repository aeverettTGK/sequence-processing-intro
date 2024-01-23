#!/bin/bash

alignment="$1"

total_samples=$(grep "^>" "$alignment")
unique_dates=$(grep "\b\d{1,2}-[a-zA-Z]{3}\b" | sort | uniq)
num_unique=$(echo "$unique_dates" | wc -l)

echo "Total Samples: $total_samples" > log.txt
echo "Unique Sample Dates: $num_unique" >> log.txt

echo "Processing complete. Results written to log.txt"
