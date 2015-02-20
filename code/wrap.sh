#!/bin/bash
#$ -cwd
#$ -S /bin/bash
#$ -j y

# email address to send notices to
#$ -M sspowers@stanford.edu
#$ -m e

## set a name to make it easy to pick out of qstat output
#$ -N sim

case "$#" in 
    1) 
	echo "modules already loaded in environment"
	module list
	echo "loading R module"
	module load R
	echo ""
	echo "Final module list"
	module list
	echo "running on"
	hostname
	echo ""
	echo ""
	Rscript $1
	;;
    *)
	echo "Usage: $0 <code_file>"
	echo "       Submits job and"
	echo "       joins stderr and stdout, sends mail notification,"
	echo "       names job for easy identification in qstat"
	exit 1
	;;
esac
exit 0
