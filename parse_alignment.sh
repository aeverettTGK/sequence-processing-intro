#!/bin/bash

alignment="$1"

total_samples=$(grep "^>" "$alignment" | wc -l)

unique_dates=$(grep "[0-9]{1,2}-[a-zA-Z]{3}" "$alignment" | uniq | wc -l)

echo "Total Samples: $total_samples" > log.txt
echo "Unique Sample Dates: $unique_dates" >> log.txt

echo "Processing complete. Results written to log.txt"
