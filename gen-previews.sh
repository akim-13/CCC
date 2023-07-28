#!/bin/bash

dir="./previews"

rm $dir/*

echo "Generating previews..."
convert -density 225 ./Cultivated\ Code\ of\ Conduct.pdf $dir/CCC.jpg

# Create an array of generated preview files.
previews=($(ls $dir))

# Delete the lines between the tags
sed -i '/<!--PREVIEWS START-->/,/<!--PREVIEWS FINISH-->/ {//!d}' ./README.md

for ((i=${#previews[@]}-1 ; i>=0; i--)); do
    md_preview="[![The preview of the CCC]($dir/${previews[i]})](./Cultivated%20Code%20of%20Conduct.pdf)"
    awk -v n="$md_preview" '/<!--PREVIEWS START-->/ {print; print n; next}1' ./README.md > tmp && mv tmp README.md
    echo ${previews[i]}
done
