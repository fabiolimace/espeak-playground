Scripts to find dead rules in `espeak-ng`\'s `pt_rules`
========================================================

These scripts in this file can be used to find dead rules in `espeak-ng`\'s `pt_rules`, the rules file for Portuguese language.

## Get the lists of words

First you need lists of words:
-   [DELAS PB v2](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (simple words) from Unitex-PB project;
-   [DELAF PB v2](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (simple words with Inflection) from Unitex-PB project;
-   [DELACF PB v1](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (compound words with Inflection) from Unitex-PB project;
-   [Linux dictionaries](https://en.wikipedia.org/wiki/Words_\(Unix\)) for pt-br and pt-pt.
-   [Aeiouadô](http://www.nilc.icmc.usp.br/aeiouado/).

How to get the DELAS PB v2:

```bash
    # http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html
    wget http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/files/DELAS_PB_v2.zip
    unzip DELAS_PB_v2.zip
    cat DELAS_PB.dic | awk -F, '{ print $1 }' \
        | tr '[:upper:]' '[:lower:]' | sort | uniq > list_of_words.delas.txt
```

How to get the DELAF PB v2:

```bash
    # http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html
    wget http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/files/DELAF_PB_v2.zip
    unzip DELAF_PB_v2.zip
    mv Delaf2015v04.dic DELAF_PB_v2.dic
    cat DELAF_PB_v2.dic | awk -F, '{ print $1 }' \
        | tr '[:upper:]' '[:lower:]' | sort | uniq > list_of_words.delaf.txt
```

How to get the DELACF PB v1:

```bash
    # http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html
    wget http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/files/DELACF_PB.zip
    unzip DELACF_PB.zip
    # Convert from UTF-16 to UTF-8
    iconv -f UTF-16 -t UTF-8 DELACF_PB.dic > /tmp/DELACF_PB.dic;
    mv /tmp/DELACF_PB.dic DELACF_PB.dic
    cat DELACF_PB.dic | awk -F, '{ print $1 }' \
        | tr '[:upper:]' '[:lower:]' | sort | uniq > list_of_words.delacf.txt
```

How to get the Linux dictionaries:

```bash
    # sudo apt install wportuguese wbrazilian
    cat /usr/share/dict/portuguese /usr/share/dict/brazilian \
        | tr '[:upper:]' '[:lower:]' | sort | uniq > list_of_words.linux.txt
```

How to get the Aeiouadô:

```bash
    wget http://www.nilc.icmc.usp.br/aeiouado/media/aeiouado-ipa-01.csv
    gawk '{print tolower($1)}' aeiouado-ipa-01.csv > list_of_words.aeiouado.txt
```

## Get all rules from `pt_rules`

Function to generate list of all rules in `espeak-ng/dictsource/pt_rules`:

```bash
function generate_list_of_all_rules {
	cat -n $HOME/git/espeak-ng/dictsource/pt_rules \
	| tr -s "\t" " " | sed -E 's,//.*,,' \
	| sed -E "s/ +/ /g;s/^ //;s/ $//" \
	| grep -E -v '^[ ]*[0-9]+[ ]*\.' \
	| grep -E -v '^[ ]*[0-9]+[ ]*$' \
	| sed -E 's/ /\t/'
}
```

Generate list of all rules in `espeak-ng/dictsource/pt_rules`:

```bash
generate_list_of_all_rules > rules/list_of_all_rules.txt
```

## Find the used rules

First, you must compile with debug option, so that line numbers are printed with the rules.

```bash
cd ~/git/espeak-ng/dictsource
sudo espeak-ng --compile-debug=pt
```

Function to generate list of used rules in a list of words:

```bash
function generate_list_of_used_rules {
    lang=${1:-pt-br};
    gzip=${2};
	zcat "$gzip" | espeak-ng -q -v ${lang} -X | gawk -f ./count_used_rules.awk \
	| sed -E "s/ +/ /g;s/^ //;s/ $//" \
	| sort -n -r
}
```

Generate list of used rules for DELAS-PB, DELAF-PB and Linux dicts:

```bash
cd ~/git/espeak-ng-playground/dead-rules
```

```bash
# DELAS PB v2 (time: ~40s):
time generate_list_of_used_rules pt-br words/list_of_words.delas.txt.gz > rules/list_of_used_rules.delas.br.txt
time generate_list_of_used_rules pt-pt words/list_of_words.delas.txt.gz > rules/list_of_used_rules.delas.pt.txt

# DELAF PB v2 (time: ~1h20min):
time generate_list_of_used_rules pt-br words/list_of_words.delaf.txt.gz > rules/list_of_used_rules.delaf.br.txt
time generate_list_of_used_rules pt-pt words/list_of_words.delaf.txt.gz > rules/list_of_used_rules.delaf.pt.txt

# DELACF PB v1 (time: ~3s):
time generate_list_of_used_rules pt-br words/list_of_words.delacf.txt.gz > rules/list_of_used_rules.delacf.br.txt
time generate_list_of_used_rules pt-pt words/list_of_words.delacf.txt.gz > rules/list_of_used_rules.delacf.pt.txt

# Linux dicts (time: ~5min):
time generate_list_of_used_rules pt-br words/list_of_words.linux.txt.gz > rules/list_of_used_rules.linux.br.txt
time generate_list_of_used_rules pt-pt words/list_of_words.linux.txt.gz > rules/list_of_used_rules.linux.pt.txt

# Aeiouadô (time: ~1min):
time generate_list_of_used_rules pt-br words/list_of_words.aeiouado.txt.gz > rules/list_of_used_rules.aeiouado.br.txt
time generate_list_of_used_rules pt-pt words/list_of_words.aeiouado.txt.gz > rules/list_of_used_rules.aeiouado.pt.txt
```

> NOTE:<br>
> The rules that has a zero line number are provenient of other languages such as english `_^_EN`.
> They are automatically ignored by the `find_dead_rules.awk` script.

## Find the dead the rules

Generate a list of DEAD rules DELAS-PB, DELAF-PB and Linux dicts and Aeiouador:

```bash
# DELAS PB v2:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delas.br.txt > rules/list_of_dead_rules.delas.br.txt
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delas.pt.txt > rules/list_of_dead_rules.delas.pt.txt

# DELAF PB v2:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delaf.br.txt > rules/list_of_dead_rules.delaf.br.txt
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delaf.pt.txt > rules/list_of_dead_rules.delaf.pt.txt

# DELACF PB v1:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delacf.br.txt > rules/list_of_dead_rules.delacf.br.txt
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delacf.pt.txt > rules/list_of_dead_rules.delacf.pt.txt

# Linux dicts
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.linux.br.txt > rules/list_of_dead_rules.linux.br.txt
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.linux.pt.txt > rules/list_of_dead_rules.linux.pt.txt

# Aeiouadô
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.aeiouado.br.txt > rules/list_of_dead_rules.aeiouado.br.txt
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.aeiouado.pt.txt > rules/list_of_dead_rules.aeiouado.pt.txt
```

## Merge dead rules files into one

Generate a file that is the result of merging all dead rules files:

```bash
cat rules/list_of_used_rules.*.txt \
    | awk -v FS="\t" -v OFS="\t" '{ $1=1; print }' | sort -k2 -rh | uniq \
    | awk -v FS="\t" -v OFS="\t" 'line == $2 { word = $4; lines[line] = lines[line] "," word; next; } { line = $2; lines[line] = $0; } END { for (i in lines) print lines[i]; }' \
    | sort -k2 -h > rules/list_of_used_rules.txt
```

```bash
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.txt > rules/list_of_dead_rules.txt
```


