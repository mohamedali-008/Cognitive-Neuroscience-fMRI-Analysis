#!/bin/bash


template_file="thirdLevelModelCope3.fsf"

output_directory="Flanker_3rdLevelCope3"

# Loop through four times
for i in {0..3}; do
    # Increment the value of fmri(mixed_yn)
    mixed_value=$((i % 4))
    
    sed -i "s/set fmri(mixed_yn) [0-9]/set fmri(mixed_yn) $mixed_value/" "$template_file"
    
    
    sed -i "s|set fmri(outputdir) \".*\"|set fmri(outputdir) \"$output_directory\"|" "$template_file"
    
    # Run FEAT
    feat "$template_file"
    
done

