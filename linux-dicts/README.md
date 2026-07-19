Phonemization
==========================

```bash
awk '/PRETTY_NAME/' /etc/os-release
PRETTY_NAME="Ubuntu 24.04.4 LTS"
```

```bash
/usr/bin/espeak-ng --version
eSpeak NG text-to-speech: 1.51  Data at: /usr/lib/x86_64-linux-gnu/espeak-ng-data
```

---------------------

```bash
sudo apt install wbrazilian wportuguese
```

```bash
cp /usr/share/dicts/*(brazilian|portuguese) dicts/
```

```bash
gzip dicts/*(brazilian|portuguese)
```

---------------------

IPA table:

```bash
time zcat dicts/*(brazilian|portuguese).gz | sort | uniq | \
awk '{ n++; buf = buf $1 " "; if (n % 200 == 0) { print buf; buf=null; } }' | \
while read i; do \
paste <(echo "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }'; ) \
<(espeak-ng -q -v pt-br --ipa "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }';) \
<(espeak-ng -q -v pt-pt --ipa "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }';); \
done | tee -a espeak-ng-v$(espeak-ng --version | awk '{print $4}')-ipa.tsv
```

Kirshenbaum table:

```bash
time zcat dicts/*(brazilian|portuguese).gz | sort | uniq | \
awk '{ n++; buf = buf $1 " "; if (n % 200 == 0) { print buf; buf=null; } }' | \
while read i; do \
paste <(echo "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }'; ) \
<(espeak-ng -q -v pt-br -x "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }';) \
<(espeak-ng -q -v pt-pt -x "$i" | awk '{ for (i=1; i<=NF; i++) print $i; }';); \
done | tee -a espeak-ng-v$(espeak-ng --version | awk '{print $4}')-kir.tsv
```

---------------------

```bash
function phonemize-ksb { /usr/bin/espeak-ng -q -x -v "$1" "$2"; }
function phonemize-ipa { /usr/bin/espeak-ng -q --ipa -v "$1" "$2"; }

# records in TSV format
function phonemization-ksb { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`phonemize-ksb $lang "$i"`"; done; }
function phonemization-ipa { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`phonemize-ipa $lang "$i"`"; done; }
```

```bash
phonemization-ksb pt-br <(zcat dicts/brazilian.tgz) > phonemizations/br-ksb.tsv
phonemization-ksb pt-pt <(zcat dicts/portuguese.tgz) > phonemizations/pt-ksb.tsv
phonemization-ipa pt-br <(zcat dicts/brazilian.tgz) > phonemizations/br-ipa.tsv
phonemization-ipa pt-pt <(zcat dicts/portuguese.tgz) > phonemizations/pt-ipa.tsv
```

---------------------

```bash
function phonemize-trace { /usr/bin/espeak-ng -q -X -v "$1" "$2"; }

# records in Record-Jar format
function phonemization-trace { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "\n%% $i\n\n`phonemize-trace $lang "$i"`"; done; }
```

```bash
phonemization-trace pt-br dicts/brazilian > phonemizations-trace/br.txt
phonemization-trace pt-pt dicts/portuguese > phonemizations-trace/pt.txt
```

```bash
# seach records by KEY in Record-Jar format
zcat dictionaries/phonemizations-trace/br.txt.gz | tools/cookie-jar-search-by-key.awk -v KEY=Adolfo
%% Adolfo

Translate 'adolfo'
  1	a        [a]

  1	d        [d]

  1	o        [o]
 43	?2 ol (  [ow]

  1	f        [f]

 41	@) o (_  [,U]
  1	o        [o]

,ad'owfU
```


