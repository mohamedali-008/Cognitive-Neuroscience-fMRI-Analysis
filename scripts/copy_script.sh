#!/bin/bash

# Function to modify the template script_high.fsf file
modify_template() {
    local template_file="script_high.fsf"
    local output_file="modified_script_high.fsf"
    local EVs=$1
    local contrasts=$2

    # Copy the template to the output file
    cp "$template_file" "$output_file"

    # Modify the EVs in the output file
    sed -i "s/^set fmri\(.*\)/set fmri\1/g" "$output_file"
    sed -i "s/\"dummy\"/\"\"/g" "$output_file"  # Replace "dummy" with empty string

    # Modify the contrasts in the output file
    sed -i "s/^set fmri\(.*\)/set fmri\1/g" "$output_file"

    # Set the number of EVs and contrasts
    sed -i "s/^set fmri\(.*\) $EVs/set fmri\(ntasks\)$EVs/g" "$output_file"
    sed -i "s/^set fmri\(.*\) $contrasts/set fmri\(ncon_real\)$contrasts/g" "$output_file"
}

# Function to run higher-level analysis using FEAT
run_feat() {
    local feat_dir="feat_output"

    # Run FEAT analysis
    feat "$feat_dir"
}

# Number of EVs and contrasts
EVs=26
contrasts=26

# Modify the template script
modify_template "$EVs" "$contrasts"

# Run higher-level analysis using FEAT
run_feat

