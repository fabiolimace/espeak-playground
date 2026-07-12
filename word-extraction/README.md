Extract tokens from text collection
=====================================

This directory contains lists of words extracted from 3 collections of texts:

* 777 ebooks (500 MiB);
* 100k news (500 MiB);
* 100k wikis (500 MiB).

Summary of extracted words:

```bash
wc -lc *-collection-words.tsv  | numfmt --to=iec --field=1-2
```
```
    110K     4,2M ebook-collection-words.tsv
     82K     3,4M news-collection-words.tsv
    118K     4,8M wiki-collection-words.tsv
    308K      13M total
```

Extraction of words
--------------------

This is the script used to extract the words from collecions of texts.

```bash
COLLECTION=PRIVATE/ebook/ebook-collection
LOCAL_REPO=~/git/espeak-playground
```
```bash
mkdir -p tmp
cat /dev/null > filename-hash.tsv
```
```bash
time find $COLLECTION -type f -name "*.txt" | sort | while read -r FILE; do
	HASH=`echo "$FILE" | md5sum | awk '{print $1}'`
	[ -f "tmp/$HASH".word-spacer.txt ] && continue;
	echo "$FILE"
	echo -e "$HASH\t$FILE" >> filename-hash.tsv
	# Ignore lines with less than 200 characters
	cat "$FILE" | sed -E 's/[[:space:]]+/ /;' | grep -E '^.{200,}$' | \
	gawk -f $LOCAL_REPO/tools/word-spacer.awk > "tmp/$HASH".word-spacer.txt;
	gawk -f $LOCAL_REPO/tools/word-counter.awk "tmp/$HASH".word-spacer.txt > "tmp/$HASH".word-counter.tsv;
	gawk -f $LOCAL_REPO/tools/word-formats.awk "tmp/$HASH".word-spacer.txt > "tmp/$HASH".word-formats.tsv;
	join -1 1 -2 1 -t'	' --header "tmp/$HASH".word-formats.tsv "tmp/$HASH".word-counter.tsv > "tmp/$HASH".text-tokens.tsv;
	# rm -f "tmp/$HASH".word-spacer.txt "tmp/$HASH".word-counter.tsv "tmp/$HASH".word-formats.tsv;
done;
```
```bash
time find tmp/ -type f -name "*.text-tokens.tsv" -exec cat "{}" \; | awk '$1 == "TOKEN" && $2 == "FORMAT" { DOC_TOTAL++; next; } { TOKEN[$1]; F[$1]=$2; TC[$1]+=$3; DC[$1]++; } END { OFS="\t"; TOK_TOTAL=length(TOKEN); print "TOKEN", "FORMAT", "TOK_COUNT", "TOK_FRAC", "DOC_COUNT", "DOC_FRAC"; for (i in TOKEN) print i, F[i], TC[i], TC[i]/TOK_TOTAL, DC[i], DC[i]/DOC_TOTAL | "sort -t'"'	'"' -k1,1"; }' > collection-tokens.tsv
```

Filter words from `collection-tokens.tsv`:

```bash
MIN_DOC_FREC=0.0001 # empricic value for 100k texts
awk 'BEGIN { OFS="\t"; } NR==1; $2 ~ /^(L|LH|U|UH|S|SH|C)$/ && $6 >= '"$MIN_DOC_FREC"' { if ($2 ~ /^(L|LH)$/) { LOWER[tolower($1)]; } else { if (tolower($1) in LOWER) next; } print; }' collection-tokens.tsv > collection-words.tsv
```

Note: the command above ignores tokens that already exists as lowercase. UTF-8 collation is assumed.

Pre-selection of texts
--------------------------

Sometimes it's not possible to process all texts in our collection. This command can be used to randomly select a small part of a big collection of texts:

```bash
find my-big-collection/ -type f -size +4k -size -9k | shuf | while read -r i; do [ $(( $RANDOM % 100 )) -gt 10 ] && continue; cp -v --update=none --parents "$i" smaller-collection/; done;
```

Non-existing words
----------------------------------

Find all non-existing words of the ebook collection.

	STAT_FILE=extracted-words/ebook-collection-words.tsv
	DICT_FILE=/usr/share/dict/brazilian

	cat "${STAT_FILE}" \
		| awk -v "DICT_FILE=${DICT_FILE}" 'BEGIN { while (getline < DICT_FILE) { DICT[tolower($1)]=1; } } { if (!(tolower($1) in DICT)) { print $0 } }'


Now list only proper names in the ebook collection:

	cat "${STAT_FILE}" | awk '$2 == "S"' \
		| awk -v "DICT_FILE=${DICT_FILE}" 'BEGIN { while (getline < DICT_FILE) { DICT[tolower($1)]=1; } } { if (!(tolower($1) in DICT)) { print $0 } }' \
		| sort -h -t'	' -k3,3 | tac | head -n 10

Now list the top 20 names in the ebook collection:


	cat "${STAT_FILE}" | awk '$2 == "S"' \
		| awk -v "DICT_FILE=${DICT_FILE}" 'BEGIN { while (getline < DICT_FILE) { DICT[tolower($1)]=1; } } { if (!(tolower($1) in DICT)) { print $0 } }' \
		| sort -h -t'	' -k3,3 | tac | head -n 20


	Cambridge	S	5404	0.00544304	316	0.406692
	Robert	S	5073	0.00510965	418	0.537967
	Marx	S	4874	0.00490921	267	0.343629
	Kant	S	4777	0.00481151	194	0.249678
	Oxford	S	4504	0.00453654	336	0.432432
	Thomas	S	3846	0.00387378	425	0.546976
	Philip	S	3816	0.00384357	142	0.182754
	Smith	S	3793	0.0038204	279	0.359073
	William	S	3591	0.00361694	417	0.53668
	Hegel	S	3590	0.00361593	152	0.195624
	Sócrates	S	3555	0.00358068	218	0.280566
	Charles	S	3443	0.00346787	428	0.550837
	James	S	3295	0.0033188	400	0.514801
	Judá	S	3268	0.00329161	61	0.0785071
	Zeus	S	3208	0.00323117	139	0.178893
	Hans	S	2955	0.00297635	213	0.274131
	Scarlett	S	2801	0.00282123	11	0.014157
	Henry	S	2616	0.0026349	338	0.435006
	Sartre	S	2568	0.00258655	108	0.138996
	Anna	S	2557	0.00257547	143	0.184041


Now pronounce the top 20 names using eSpeak NG:

	cat "${STAT_FILE}" | awk '$2 == "S"' \
		| awk -v "DICT_FILE=${DICT_FILE}" 'BEGIN { while (getline < DICT_FILE) { DICT[tolower($1)]=1; } } { if (!(tolower($1) in DICT)) { print $0 } }' \
		| sort -h -t'	' -k3,3 | tac | head -n 20 \
		| awk '{ print $1}' | while read word; do echo $word; espeak-ng -v pt-br --ipa $word; echo; done;


	Cambridge
	kˈembɹˌidʒɪ

	Robert
	xˈɔbɛɾtʃ

	Marx
	mˈaɾks

	Kant
	kˈɐ̃ntʃ

	Oxford
	oksfˈɔɾdʒ

	Thomas
	tˈomɐs

	Philip
	fˈilip

	Smith
	zmˈitʃ

	William
	wˈiliʲɐm

	Hegel
	hˈeɡew

	Sócrates
	sˈɔkɾɐtʃɪs

	Charles
	ʃˈaɾlɪs

	James
	dʒˈeɪmɪs

	Judá
	ʒudˈa

	Zeus
	zˈeʊs

	Hans
	hˈɐns

	Scarlett
	skˈaɾletʃ

	Henry
	ˈẽnxi

	Sartre
	sˈaɾtɾɪ

	Anna
	ˈɐ̃nɐ


