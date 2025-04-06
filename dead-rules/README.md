Scripts to find dead rules in `espeak-ng`\'s `pt_rules`
========================================================

These scripts in this file can be used to find dead rules in `espeak-ng`\'s `pt_rules`, the rules file for Portuguese language.

## Get the lists of words

First you need lists of words:
-   [DELAS PB v2](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (simple words) from Unitex-PB project;
-   [DELAF PB v2](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (simple words with Inflection) from Unitex-PB project;
-   [DELACF PB v1](http://www.nilc.icmc.usp.br/nilc/projects/unitex-pb/web/dicionarios.html) (compound words with Inflection) from Unitex-PB project;
-   [Linux dictionaries](https://en.wikipedia.org/wiki/Words_\(Unix\)) for pt-br and pt-pt.

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
sudo espeak-ng --compile-debug=pt-br
```

Function to generate list of used rules in a list of words:

```bash
function generate_list_of_used_rules {
	zcat "$1" | espeak-ng -q -v pt-br -X | gawk -f ./count_used_rules.awk \
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
time generate_list_of_used_rules words/list_of_words.delas.txt.gz > rules/list_of_used_rules.delas.txt

# DELAF PB v2 (time: ~1h20min):
time generate_list_of_used_rules words/list_of_words.delaf.txt.gz > rules/list_of_used_rules.delaf.txt

# DELACF PB v1 (time: ~3s):
time generate_list_of_used_rules words/list_of_words.delacf.txt.gz > rules/list_of_used_rules.delacf.txt

# Linux dicts (time: ~5min):
time generate_list_of_used_rules words/list_of_words.linux.txt.gz > rules/list_of_used_rules.linux.txt
```

## Find the dead the rules

Generate a list of DEAD rules DELAS-PB, DELAF-PB and Linux dicts (lines deleted in the second file):

```bash
# DELAS PB v2:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delas.txt > rules/list_of_dead_rules.delas.txt

# DELAF PB v2:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delaf.txt > rules/list_of_dead_rules.delaf.txt

# DELACF PB v1:
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.delacf.txt > rules/list_of_dead_rules.delacf.txt

# Linux dicts
gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.linux.txt > rules/list_of_dead_rules.linux.txt
```


