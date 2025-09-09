Affixes
================

Suffix creation
----------------

Create a rule for the suffix "-mente" in `pt_rule`:

```
?1  @@) mente (_S5 m''eINty
?2  @@) mente (_S5 m''eINtSy
```

Where:

* `@`: is a syllable that can be stressed
* `S5`: is a suffix with exactly 5 letters

Generate a list of words with a specific suffix, for example, the suffix "-mente":

```
cd ~/git/espeak-playground
mkdir affix/suffix/mente
zcat dictionaries/dicts/{brazilian,portuguese}.gz | grep -E "mente$" | sort | uniq > affix/suffix/mente/list.txt
```

Listen the list of words:

```
cat list.txt | espeak-ng -v pt-br --ipa
```

Generate a comparison table for the translation before and after the new rule:

```
cd affix/suffix/mente
cat list.txt | espeak-ng -v pt-br --ipa -q > /dev/shm/before.txt
cat list.txt | espeak-ng -v pt-br --ipa -q > /dev/shm/after.txt
paste list.txt /dev/shm/before.txt /dev/shm/after.txt > comparison.tsv
```

> NOTE: obviously you have to compile the rules between the commands to generate before.txt and after.txt files.

Generate a table containing the words that changed after the new rule:

```
awk '$2 != $3' comparison.tsv > changed.tsv
```

Listen the words that changed:

```
awk 'NR % 10 == 0 { print $1 }' changed.tsv | espeak-ng -v pt-br --ipa
awk '/^....mente/ { print $1 }' changed.tsv | espeak-ng -v pt-br --ipa
```
