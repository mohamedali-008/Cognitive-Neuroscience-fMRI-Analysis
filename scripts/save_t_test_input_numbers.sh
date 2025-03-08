#!/usr/bin/sh

# Set the name of the output file
output_file="t_Test_input.txt"

# Loop over the 7 regions
for roi_idx in `seq -w 1 7` ; do
    ROI="ROI_$roi_idx"

    echo "Extract data from $ROI"

    # Loop over the 3 copes
    for cope_idx in `seq -w 1 3` ; do
        COPE="cope$cope_idx"

        echo "Extract data from $COPE"

        # Print the ROI and COPE labels to the output file
        echo  "$ROI $COPE :" >> $output_file

        # Run fslmeants and append the output to the output file
        fslmeants -i allZstats_${COPE}.nii.gz -m ${ROI}_Sphere_bin.nii.gz >> $output_file

    done

done

