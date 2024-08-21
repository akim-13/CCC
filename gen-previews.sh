#!/bin/bash

dir="./previews"

rm $dir/*

echo "Generating previews..."
magick -density 225 -quality 10 ./Cultivated\ Code\ of\ Conduct.pdf -set filename:page "02%d" "$dir/CCC-%02d.jpg"

# Create an array of generated preview files.
previews=($(ls $dir))

# Delete the lines between the tags.
sed -i '/<!--PREVIEWS START-->/,/<!--PREVIEWS FINISH-->/ {//!d}' ./README.md

for ((i=${#previews[@]}-1 ; i>=0; i--)); do
    md_preview="[![The preview of the CCC]($dir/${previews[i]})](./Cultivated%20Code%20of%20Conduct.pdf)"
    # Insert a linked image after the start tag.
    awk -v n="$md_preview" '/<!--PREVIEWS START-->/ {print; print n; next}1' ./README.md > tmp && mv tmp README.md
    echo ${previews[i]}
done
