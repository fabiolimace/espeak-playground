
Lista palavras do Grande Dicionário que se diferenciam:

	time cat ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0' > grande-dicionario.tsv

Lista palavras do Grande Dicionário que se diferenciam entre /e/ e /ɨ/:

	time awk '$1 ~ /e/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[eɨ]\]/ && $5 ~ /^[^[:punct:]]*\[[eɨ]\]/' > grande-dicionario-e1.tsv

No caso acima, uma das coisas que se pode fazer é mudar a definição do fonema /e/ no arquivo ph_portugal para usar a instrução `ChangeIfNotStressed()` em vez de `ChangeIfUnstressed()`.

	phoneme e
	  vwl starttype #e endtype #e
	  length 180
	//ChangeIfUnstressed(y)
	  ChangeIfNotStressed(y)
	  FMT(vowel/e)
	endphoneme


Lista palavras do Grande Dicionário que se diferenciam entre /e/ e /ɛ/:

	time awk '$1 ~ /e/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[eɛ]\]/ && $5 ~ /^[^[:punct:]]*\[[eɛ]\]/' > grande-dicionario-e2.tsv

Lista palavras do Grande Dicionário que se diferenciam entre /ɨ/ e /ɛ/:

	time awk '$1 ~ /e/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[ɨɛ]\]/ && $5 ~ /^[^[:punct:]]*\[[ɨɛ]\]/' > grande-dicionario-e3.tsv

Lista palavras do Grande Dicionário que se diferenciam entre /o/ e /u/:

	time awk '$1 ~ /o/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[ou]\]/ && $5 ~ /^[^[:punct:]]*\[[ou]\]/' > grande-dicionario-o1.tsv

Lista palavras do Grande Dicionário que se diferenciam entre /o/ e /ɔ/:

	time awk '$1 ~ /o/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[oɔ]\]/ && $5 ~ /^[^[:punct:]]*\[[oɔ]\]/' > grande-dicionario-o2.tsv

Lista palavras do Grande Dicionário que se diferenciam entre /u/ e /ɔ/:

	time awk '$1 ~ /o/' ../dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv \
	| awk -f grande-dicionario.awk | awk '$6 == 0 && $4 ~ /^[^[:punct:]]*\[[uɔ]\]/ && $5 ~ /^[^[:punct:]]*\[[uɔ]\]/' > grande-dicionario-o3.tsv

