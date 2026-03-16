LibreOffice Dictionaries
=========================

Clone repository:

```
cd ~/git/
git clone https://github.com/LibreOffice/dictionaries.git
```

Copy and compress Portuguese dictionaries:

```
cp ~/git/dictionaries/pt_PT/pt_PT.dic ~/git/espeak-playground/libreoffice-dicts/
cp ~/git/dictionaries/pt_BR/pt_BR.dic ~/git/espeak-playground/libreoffice-dicts/
cd ~/git/espeak-playground/libreoffice-dicts/
gzip *.dic
```

Extract words from Portuguese dictionaries:

```bash
zcat pt_PT.dic.gz | awk '/^[[:alpha:]]/ { sub(/\/.*/,""); print $1; }' | sort > pt_PT.txt
```
```bash
zcat pt_BR.dic.gz | awk '/^[[:alpha:]]/ { sub(/\/.*/,""); print $1; }' | sort > pt_BR.txt
```

Extract acronyms:

```
cat pt_PT.txt | grep -E '^[[:upper:]]+$' | grep -E '[AEIOUY]' | grep -Ev '^(M{1,3})?(D?C{1,3}|CD|D|CM)?(L?X{1,3}|XL|L|XC)?(V?I{1,3}|IV|V|IX)?$' > pt_PT.acronyms.txt
cat pt_BR.txt | grep -E '^[[:upper:]]+$' | grep -E '[AEIOUY]' | grep -Ev '^(M{1,3})?(D?C{1,3}|CD|D|CM)?(L?X{1,3}|XL|L|XC)?(V?I{1,3}|IV|V|IX)?$' > pt_BR.acronyms.txt
```


