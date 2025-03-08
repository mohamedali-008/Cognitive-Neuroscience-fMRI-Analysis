
for i in `seq -w 1 26`
do
echo $i

sub="sub-$i"

cd $sub

cp ../des.fsf .

if [ ! -f anat/${sub}_T1w_brain.nii.gz ]
then
bet2 anat/${sub}_T1w.nii.gz anat/${sub}_T1w_brain.nii.gz -f 0.2
fi
sed 's/sub-01/${sub}/g' des.fsf
feat des.fsf

cd ..

done
