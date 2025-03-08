#!/usr/bin/sh

for idx in `seq -w 1 26` ; do
    sub="sub-$idx"
    echo " Start first level analysis of $sub"

    # Copy the design files into the subject directory.
	#copy preprocessing desgin files
    cp /home/ziyad/Tasks/Flanker_Dataset/Designs/preprocessing_design_run1.fsf .
    cp /home/ziyad/Tasks/Flanker_Dataset/Designs/preprocessing_design_run2.fsf .
        #copy preprocessing desgin files
    cp /home/ziyad/Tasks/Flanker_Dataset/Designs/statistics_design_run1.fsf .
    cp /home/ziyad/Tasks/Flanker_Dataset/Designs/statistics_design_run2.fsf .

	# change “sub-01” to the current subject number in design files
    sed -i "s/sub-01/${sub}/g" preprocessing_design_run1.fsf
    sed -i "s/sub-01/${sub}/g" preprocessing_design_run2.fsf

    sed -i "s/sub-01/${sub}/g" statistics_design_run1.fsf
    sed -i "s/sub-01/${sub}/g" statistics_design_run2.fsf

	#run feat desgin files
    echo "===> Start preprocessing run 1"
    feat preprocessing_design_run1.fsf
    echo "===> Start statistics and modeling run 1"
    feat statistics_design_run1.fsf

    echo "===> Start preprocessing run 2"
    feat preprocessing_design_run2.fsf
    echo "===> Start statistics and modeling run 2"
    feat statistics_design_run2.fsf
done
