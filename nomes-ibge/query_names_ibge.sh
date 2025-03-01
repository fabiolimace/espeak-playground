#!/bin/bash

#
# Query the service "Nomes do Brasil": https://censo2010.ibge.gov.br/nomes/
#
# Usage:
#
#     query_names_ibge.sh LIST_OF_NAMES [OUTPUT_FILE]
#

LIST_OF_NAMES=$1
OUTPUT=${2:-${LIST_OF_NAMES%.*}.output.txt}

function query_name_ibge {
	wget -q -O- http://servicodados.ibge.gov.br/api/v1/censos/nomes/basica?nome=$name | gzip -d -c \
	| sed -E "s#\[\]#[{"rank":-1,"nome":"\1","freq":0,"percentual":0.0000,"ufMax":""}]#";
}

while read name; do
	sleep 3;
	echo -e "\n\n$name:" >> "$OUTPUT";
	query_name_ibge $name 2>&1 >> "$OUTPUT";
done < <( cat "$LIST_OF_NAMES" );

