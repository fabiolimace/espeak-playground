Prepositive Adjectives
--------------------------------------

Also known in Portuguese as "adjetivos antepostos".

List prepositive adjectives from a collection of ebooks.


	TEXT_COLLECTION=/path/to/text-collection
	PART_OF_SPEECH_DICT="../dict-extraction/PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.tsv"
	
	find "$TEXT_COLLECTION" -type f -name "*.txt" | while read FILE; do
		cat "$FILE" | awk -f ~/git/espeak-playground/tools/word-spacer.awk | awk -v "PART_OF_SPEECH_DICT=$PART_OF_SPEECH_DICT" -f prepositive-adjectives.awk | tee -a prepositive-adjective-phrases.txt
	done;

	sort prepositive-adjective-phrases.txt | uniq | awk '{ print $2 }' | sort | uniq -c | sort -h | tac > prepositive-adjective-count.txt


Wikipedia article about postpositive (and prepositive) adjectives: https://en.wikipedia.org/wiki/Postpositive_adjective

