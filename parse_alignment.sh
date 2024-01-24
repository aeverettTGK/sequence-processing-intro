#!/bin/bash

alignment="$1"

sed -i "s/ /-/g" "$alignment"

total_samples=$(grep "^>" "$alignment" | wc -l)

unique_dates=$(grep -o "[0-9]*-[a-zA-Z]*" "$alignment" | uniq | wc -l)

echo "Total Samples: $total_samples" > log.txt
echo "Unique Sample Dates: $unique_dates" >> log.txt
