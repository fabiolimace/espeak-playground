Sede
==============================

Calculate the frequence of place prepositons occurring with "sede":

	grep -Ehor '(\b[[:alpha:]]+\b ){1,2}sedes?[[:punct:]]?( \b[[:alpha:]]+\b){1,2}' news-collection/ | tee sede.txt

	grep -Eho '(\b[[:alpha:]]+\b )?sedes?[[:punct:]]?( \b[[:alpha:]]+\b)?' sede.txt | sort | uniq -c | sort -h > sede.count.txt

	awk '{ gsub(/[[:punct:]]/, ""); PAIRS[tolower($2) " " tolower($3)]+=$1 } END { for (i in PAIRS) print PAIRS[i], i; }' sede.count.txt | sort -h > sede.summary.txt

	grep -E "\b(em|na|nas|à|às) sedes?" sede.summary.txt | awk '{ SUM+=$1 } END { print SUM }'
	113387

	cat sede.summary.txt | awk '{ SUM+=$1 } END { print SUM }'
	293917

	echo '113387 / 293917' | bc -l
	.38577897841907749466


Conclusion
------------------------------

The frequency of place prepositions em, na/s, and à/s occurring with sede/s in the news collection is 39%.

A way of mitigating the ambiguity of the word "sede" is to add these lines to `dictsource/pt_list`:

	sede            $alt2
	(à sede)        à séde $text
	(em sede)       em séde $text
	(na sede)       na séde $text
	sedes           $alt


