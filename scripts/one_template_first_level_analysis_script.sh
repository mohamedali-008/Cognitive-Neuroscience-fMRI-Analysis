#!/bin/bash

# Set up FSL environment
export FSLDIR=/home/ziyad/fsl
source $FSLDIR/etc/fslconf/fsl.sh

# Define paths and parameters
data_dir="/home/ziyad/Downloads/FMRI/Data/ds102_R2.0.0_all_data/ds102_R2.0.0"
template_dir="/home/ziyad/fsl/data/standard"  # Update with your template directory
standard_template="MNI152_T1_2mm_brain"
resolution="2" # Choose between "1" or "2" for 1mm or 2mm MNI template
output_dir="/home/ziyad/Downloads/FMRI/Data/ds102_R2.0.0_all_data/ds102_R2.0.0/Data_preprocessed_using_FEAT"
design_template="/home/ziyad/Downloads/FMRI/FEAT_design/my_feat_design.fsf"

# Loop through subject folders
for subject_folder in $data_dir/*/; do
    subject=$(basename $subject_folder)
    echo "Processing subject $subject"
    
    # Subject's anatomical image after brain extraction
    structural_image=""
    if [[ $subject =~ ^sub-([0-9]+)$ ]]; then
        subject_num=${BASH_REMATCH[1]}
        if (( $subject_num <= 10 )); then
            structural_image=$(find "$subject_folder/anat" -name "*brain.nii.gz")
        else
            structural_image=$(find "$subject_folder/anat" -name "*brain_thresh_0.2.nii.gz")
        fi
    fi
    
    if [ -z "$structural_image" ]; then
        echo "Anatomical image not found for subject $subject"
        continue
    fi
    
    # Set up FEAT directory for each functional run
    for run_folder in $subject_folder/func/*; do
        run=$(basename $run_folder)
        run_number=$(echo $run | cut -d '-' -f 2)  # Extract run number
        
        # Create output directory for the current run
        feat_output_dir="$output_dir/func_run_${run_number}.feat"
        mkdir -p $feat_output_dir
        
        # Copy design template to FEAT directory
        cp $design_template $feat_output_dir/design.fsf
        
        # Replace placeholders in the design template
        sed -i "s|REPLACE_TEMPLATE_DIR|$template_dir|g" $feat_output_dir/design.fsf
        sed -i "s|REPLACE_STANDARD_TEMPLATE|$standard_template|g" $feat_output_dir/design.fsf
        sed -i "s|REPLACE_RESOLUTION|$resolution|g" $feat_output_dir/design.fsf
        sed -i "s|REPLACE_STRUCTURAL_IMAGE|$structural_image|g" $feat_output_dir/design.fsf
        sed -i "s|REPLACE_FUNCTIONAL_DATA|${run_folder}/your_functional_data.nii.gz|g" $feat_output_dir/design.fsf
        sed -i "s|REPLACE_FEAT_OUTPUT_DIR|$feat_output_dir|g" $feat_output_dir/design.fsf
        
        # Run FEAT preprocessing
        feat $feat_output_dir/design.fsf
        
        echo "FEAT preprocessing completed for subject $subject, run $run_number"
    done
done

