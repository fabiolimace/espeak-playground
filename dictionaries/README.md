
```bash
/usr/bin/espeak-ng --version
eSpeak NG text-to-speech: 1.51  Data at: /usr/lib/x86_64-linux-gnu/espeak-ng-data
```


```bash
function transcribe-ksb { /usr/bin/espeak-ng -q -x -v "$1" "$2"; }
function transcribe-ipa { /usr/bin/espeak-ng -q --ipa -v "$1" "$2"; }

# records in TSV format
function transcription-ksb { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ksb $lang "$i"`"; done; }
function transcription-ipa { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ipa $lang "$i"`"; done; }
```

```bash
transcription-ksb pt-br dicts/brazilian > transcriptions/br-ksb.tsv
transcription-ksb pt-pt dicts/portuguese > transcriptions/pt-ksb.tsv
transcription-ipa pt-br dicts/brazilian > transcriptions/br-ipa.tsv
transcription-ipa pt-pt dicts/portuguese > transcriptions/pt-ipa.tsv
```


```bash
function transcribe-trace { /usr/bin/espeak-ng -q -X -v "$1" "$2"; }

# records in Record-Jar format
function transctiption-trace { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "\n%% $i\n\n`transcribe-trace $lang "$i"`"; done; }
```

```bash
transctiption-trace pt-br dicts/brazilian > transcriptions-trace/br.txt
transctiption-trace pt-pt dicts/portuguese > transcriptions-trace/pt.txt
```

```bash
# seach records by KEY in Record-Jar format
zcat dictionaries/transcriptions-trace/br.txt.gz | tools/cookie-jar-search-by-key.awk -v KEY=Adolfo
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

