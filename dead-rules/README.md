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
	cat $HOME/git/espeak-ng/dictsource/pt_rules \
	| tr -s "\t" " " | sed -E 's,//.*,,' \
	| grep -E -v '^[ ]*\.' \
	| grep -E -v '^[ ]*$' \
	| sed -E "s/(\?[!]?[0-9])[ ]+//" \
	| sed -E "s/^[ ]+//;s/[ ]+$//" \
	| sort
}
```

Generate list of all rules in `espeak-ng/dictsource/pt_rules`:

```bash
generate_list_of_all_rules > list_of_all_rules.txt
```

## Find the used rules

Function to generate list of used rules in a list of words:

```bash
function generate_list_of_used_rules {
	cat "$1" | espeak-ng -q -v pt-br -X \
	| gawk -f ./count_used_rules.awk \
	| tr -s "\t" " " | awk '{ $1 = ""; print $0; }' \
	| sed -E "s/(\?[!]?[0-9])[ ]+//" \
	| sed -E "s/^[ ]+//;s/[ ]+$//" | sort
}
```

Generate list of used rules for DELAS-PB, DELAF-PB and Linux dicts:

```bash
# DELAS PB v2 (time: ~40s):
time generate_list_of_used_rules list_of_words.delas.txt > list_of_used_rules.delas.txt

# DELAF PB v2 (time: ~1h20min):
time generate_list_of_used_rules list_of_words.delaf.txt > list_of_used_rules.delaf.txt

# DELACF PB v1 (time: ~3s):
time generate_list_of_used_rules list_of_words.delacf.txt > list_of_used_rules.delacf.txt

# Linux dicts (time: ~5min):
time generate_list_of_used_rules list_of_words.linux.txt > list_of_used_rules.linux.txt
```

## Find the dead the rules

Generate a list of DEAD rules DELAS-PB, DELAF-PB and Linux dicts (lines deleted in the second file):

```bash
# DELAS PB v2:
comm -23 list_of_all_rules.txt list_of_used_rules.delas.txt > list_of_dead_rules.delas.txt

# DELAF PB v2:
comm -23 list_of_all_rules.txt list_of_used_rules.delaf.txt > list_of_dead_rules.delaf.txt

# DELACF PB v1:
comm -23 list_of_all_rules.txt list_of_used_rules.delacf.txt > list_of_dead_rules.delacf.txt

# Linux dicts
comm -23 list_of_all_rules.txt list_of_used_rules.linux.txt > list_of_dead_rules.linux.txt
```

Generate a list of MIGHT NOT BE DEAD rules DELAS-PB and Linux dicts (lines changed in the second file):

```bash
# DELAS PB v2:
comm -13 list_of_all_rules.txt list_of_used_rules.delas.txt > list_of_might_not_be_dead_rules.delas.txt

# DELAF PB v2:
comm -13 list_of_all_rules.txt list_of_used_rules.delaf.txt > list_of_might_not_be_dead_rules.delaf.txt

# DELACF PB v1:
comm -13 list_of_all_rules.txt list_of_used_rules.delacf.txt > list_of_might_not_be_dead_rules.delacf.txt

# Linux dicts
comm -13 list_of_all_rules.txt list_of_used_rules.linux.txt > list_of_might_not_be_dead_rules.linux.txt
```

> CAUTION:
> Compare the `dead` list with the `might_not_be_dead` list, because some lines might have been changed by the `espeak-ng` executable.
> Use `meld` to help do identify the rules that the executable updated; they are highlighted in blue color.

> NOTE:
> The output lists for DELAF PB and DELACF PB won't be uploaded to this Gist.

---

_Github Gist URL_: <https://gist.github.com/fabiolimace/760bf4b8ba0ef536005fb29ad2b4c59d>


