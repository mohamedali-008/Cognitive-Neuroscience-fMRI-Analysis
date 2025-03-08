#!/bin/bash

# Set up environment variables
export FSLDIR=/home/ziyad/fsl
source $FSLDIR/etc/fslconf/fsl.sh

# Set the threshold value
threshold=0.2

# Loop through subject folders from 11 to 26
for ((subject_num=11; subject_num<=26; subject_num++)); do
    subject="sub-${subject_num}"
    subject_folder="/home/ziyad/Downloads/FMRI/Data/ds102_R2.0.0_all_data/ds102_R2.0.0/$subject/"

    # Get anatomy file path
    anatomy_file="${subject_folder}anat/${subject}_T1w.nii.gz"
    
    # Check if anatomy file exists
    if [ -f "$anatomy_file" ]; then
        # Perform brain extraction using BET
        bet_output="${subject_folder}anat/${subject}_T1w_brain_thresh_${threshold}.nii.gz"
        bet $anatomy_file $bet_output -f $threshold -g 0
        
        echo "BET applied for $subject with threshold $threshold"
    else
        echo "Anatomy file not found for $subject"
    fi
done

