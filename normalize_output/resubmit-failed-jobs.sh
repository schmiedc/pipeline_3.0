names=`grep "exit" out.* -l`
for name in $names; do
	job=`sed -n '4,4p' $name | sed -n "s/Job <\([^>]*\)>.*/\1/p"`
	echo bsub -q short -n 1 -R span[hosts=1] -o "out.%J" -e "err.%J" ${job}
	bsub -q short -n 1 -R span[hosts=1] -o "out.%J" -e "err.%J" ${job}
done
