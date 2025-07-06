Extract tokens from text collection
=====================================

This directory contains lists of words extracted from 3 collections of texts:

* 777 ebooks (~500MiB);
* 100k news (~500MiB);
* 100k wikis (~500MiB).

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
LOCAL_REPO=~/git/espeak-ng-playground
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
	gawk -f $LOCAL_REPO/tools/word-spacer.awk "$FILE" > "tmp/$HASH".word-spacer.txt;
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

```
MIN_DOC_FREC=0.0001 # empricic value for 100k texts
awk 'BEGIN { OFS="\t"; } NR==1; $2 ~ /^(L|LH|U|UH|S|SH|C)$/ && $6 >= '"$MIN_DOC_FREC"' { if ($2 ~ /^(L|LH)$/) { LOWER[tolower($1)]; } else { if (tolower($1) in LOWER) next; } print; }' collection-tokens.tsv > collection-words.tsv
```

Note: the command above ignores tokens that already exists as lowercase. UTF-8 collation is assumed.

Pre-selection of texts
--------------------------

Sometimes it's not possible to process all texts in our collection. This command can be used to randomly select a small part of a big collection of texts:

```
find my-big-collection/ -type f -size +4k -size -9k | shuf | while read -r i; do [ $(( $RANDOM % 100 )) -gt 10 ] && continue; cp -v --update=none --parents "$i" smaller-collection/; done;
```

