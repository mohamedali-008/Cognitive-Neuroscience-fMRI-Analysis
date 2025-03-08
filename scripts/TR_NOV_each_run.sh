#!/bin/bash

# Set up environment variables
export FSLDIR=/home/ziyad/fsl
source $FSLDIR/etc/fslconf/fsl.sh

# Output file
output_file="TR_and_NumVolumes.csv"

# Write header to output file
echo "Subject,Run,TR (s),Number of Volumes" > $output_file

# Loop through subject folders
for subject_folder in /home/ziyad/Downloads/FMRI/Data/ds102_R2.0.0_all_data/ds102_R2.0.0/*/; do
    subject=$(basename $subject_folder)
    
    # Get functional data folder
    func_folder="${subject_folder}func/"
    
    # Check if func folder exists
    if [ -d "$func_folder" ]; then
        # Find functional data files (assuming they have .nii.gz extension)
        func_files=($(find "$func_folder" -name "*.nii.gz"))
        
        # Loop through functional data files
        for func_file in "${func_files[@]}"; do
            # Get run number from file name
            run=$(basename $func_file .nii.gz)
            
            # Get TR and number of volumes
            tr=$(fslinfo $func_file | grep "pixdim4" | awk '{print $2}')
            num_volumes=$(fslinfo $func_file | grep "dim4" | awk '{print $2}')
            
            # Write to output file without adding extra newline
            echo "$subject,$run,$tr,$num_volumes" >> $output_file
            
        done
    fi
done

