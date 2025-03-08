#!/bin/bash

# Define the base path and variables
base_path="/home/mahmoud/Downloads/flanker_test/ds102_R2.0.0_all_data/ds102_R2.0.0"
prefix="sub-"
suffix="_T1w"
brain_suffix="_T1w_brain0.1"
f_value=0.1

# Loop through subjects from 1 to 26
for ((i=1; i<=26; i++))
do
    subject=$(printf "%02d" $i)  # Zero-padding for subject number
    input_file="$base_path/${prefix}${subject}/anat/${prefix}${subject}${suffix}"
    output_file="$base_path/${prefix}${subject}/anat/${prefix}${subject}${brain_suffix}"
    
    # Execute the command with current variables
    /home/mahmoud/fsl/bin/bet "$input_file" "$output_file" -f "$f_value" -g 0
done

