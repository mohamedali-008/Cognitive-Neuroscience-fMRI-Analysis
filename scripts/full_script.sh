#!/bin/bash

# Generate the subject list to make modifying this script
# to run just a subset of subjects easier.

# Starting subject ID
start_id=1

for id in $(seq -w ${start_id} 26); do
    subj="sub-${id}"
    echo "===> Starting processing of ${subj}"
    echo

    # Navigate to the subject directory
    cd "${subj}"

    # If the brain mask doesn’t exist, create it
    if [ ! -f anat/${subj}_T1w_brain0.15.nii.gz ]; then
        echo "Skull-stripped brain not found, using bet with a fractional intensity threshold of 0.15"
        # Note: This fractional intensity appears to work well for most of the subjects in the
        # Flanker dataset. You may want to change it if you modify this script for your own study.
        bet2 anat/${subj}_T1w.nii.gz \
            anat/${subj}_T1w_brain0.15.nii.gz -f 0.15
    fi

    # Copy the design files into the subject directory, and then
    # change “sub-01” to the current subject number
    cp ../design_run1.fsf .
    cp ../design_run2.fsf .

    # Note that we are using the | character to delimit the patterns
    # instead of the usual / character because there are / characters
    # in the pattern.
    sed -i "s|sub-01|${subj}|g" design_run1.fsf
    sed -i "s|sub-01|${subj}|g" design_run2.fsf

    # Create output directory for run1 and run2
    mkdir -p ${subj}_run1_FEAT
    mkdir -p ${subj}_run2_FEAT

    # Move to the output directories
    cd ${subj}_run1_FEAT

    # Now everything is set up to run feat for run1
    echo "===> Starting feat for run 1"
    feat ../design_run1.fsf

    # Move back to the subject directory
    cd ..

    # Move to the output directories for run2
    cd ${subj}_run2_FEAT

    # Now everything is set up to run feat for run2
    echo "===> Starting feat for run 2"
    feat ../design_run2.fsf

    # Move back to the subject directory
    cd ..

    # Go back to the directory containing all of the subjects, and repeat the loop
    cd ..
done

echo "Finished processing all subjects."

