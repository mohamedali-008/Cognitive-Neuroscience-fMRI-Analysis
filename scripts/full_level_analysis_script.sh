#!/bin/bash

# Path to the FEAT design template for run1
design_template_run1="/path/to/your/design_template_run1.fsf"

# Path to the FEAT design template for run2
design_template_run2="/path/to/your/design_template_run2.fsf"

# Path to the directory containing subject data
data_dir="/path/to/your/data/directory"

# Iterate over subjects
for subject_dir in "$data_dir"/*; do
    if [ -d "$subject_dir" ]; then
        subject=$(basename "$subject_dir")

        # Path to the subject's functional data for run1
        func_data_run1="$subject_dir/func/sub-${subject}_task-flanker_run-1_bold.nii.gz"

        # Path to the subject's functional data for run2
        func_data_run2="$subject_dir/func/sub-${subject}_task-flanker_run-2_bold.nii.gz"

        # Create output directory for run1
        output_dir_run1="$subject_dir/func/run1_FEAT"
        mkdir -p "$output_dir_run1"

        # Create output directory for run2
        output_dir_run2="$subject_dir/func/run2_FEAT"
        mkdir -p "$output_dir_run2"

        # Copy design template and modify for run1
        cp "$design_template_run1" "$output_dir_run1/design.fsf"

        # Update paths in the design template for run1
        sed -i "s|set fmri\(.*\)feat_files(1) \"\"|set fmri\1feat_files(1) \"$func_data_run1\"|" "$output_dir_run1/design.fsf"

        # Copy design template and modify for run2
        cp "$design_template_run2" "$output_dir_run2/design.fsf"

        # Update paths in the design template for run2
        sed -i "s|set fmri\(.*\)feat_files(1) \"\"|set fmri\1feat_files(1) \"$func_data_run2\"|" "$output_dir_run2/design.fsf"

        # Run FEAT analysis for run1
        feat "$output_dir_run1/design.fsf"

        # Run FEAT analysis for run2
        feat "$output_dir_run2/design.fsf"
    fi
done

