#!/bin/bash
set -e

# Creating Backup Folder

BACKUP=.BACKUP-`date +%y-%m-%m`

if [ ! -d ${BACKUP} ]; then
	echo "creating... ${BACKUP}";	
	mkdir ${BACKUP};
fi


######################
# Setting Parameters #
######################

FROM_ENC=TIS-620         # Convert from ${FROM_ENC} encoding
TO_ENC=UTF-8             # Convert to ${TO_ENC} encoding
INPUT_FILE=./.aspx.list  # list of files will be converted. ! it should be full path

n=0 # count number of converted files

while read p; do
	file=$(awk -F '\:' '{print $1}'<<<$p);
	filename=$(awk -F '/' '{print $NF}' <<< $file);
	
	printf "prepare converting %s\n" $filename;

	echo "backup..."
	cp ${file} ${BACKUP}/${filename}.orig;

	echo "convert..."
	iconv -f ${FROM_ENC} -t ${TO_ENC} ${file} > ${file}.convert

	echo "saving..."
	mv ${file}.convert ${file}

	((n++));	
done < ${INPUT_FILE} 

printf "number of records: %d\n" ${n}
