#!/usr/bin/sh

# # copy zstat files of third level incongruent and congruent to the current directory
fslmaths /home/ziyad/Tasks/Flanker_Dataset/third_level_2_pairs/third_level_incongruent.gfeat/cope1.feat/stats/zstat1.nii.gz incongruent_zstat1

fslmaths /home/ziyad/Tasks/Flanker_Dataset/third_level_2_pairs/third_level_congruent.gfeat/cope1.feat/stats/zstat1.nii.gz congruent_zstat1

# # substract the 2 z-stats to get incongruent - congruent activation
fslmaths incongruent_zstat1.nii.gz -sub congruent_zstat1.nii.gz incongruent_minus_congruent_zstat1.nii.gz

# cluster the output usinng z threshold
echo "thresholding by 3.1"
cluster -i incongruent_minus_congruent_zstat1.nii.gz --zthresh=3.1 --othresh=incongruent_minus_congruent_zstat1_cluster1.nii.gz
echo "thresholding by 2.3"
cluster -i incongruent_minus_congruent_zstat1.nii.gz --zthresh=2.3 --othresh=incongruent_minus_congruent_zstat1_2.3.nii.gz
