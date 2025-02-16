
```bash
/usr/bin/espeak-ng --version
eSpeak NG text-to-speech: 1.51  Data at: /usr/lib/x86_64-linux-gnu/espeak-ng-data
```

```bash
function transcribe-ksb { /usr/bin/espeak-ng -q -x -v "$1" "$2"; }
function transcribe-ipa { /usr/bin/espeak-ng -q --ipa -v "$1" "$2"; }

function transcribe-list-ksb { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ksb $lang "$i"`"; done; }
function transcribe-list-ipa { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ipa $lang "$i"`"; done; }
```

```bash
transcribe-list-ksb pt-br dict/brazilian > transcriptions/br-ksb.tsv
transcribe-list-ksb pt-pt dict/portuguese > transcriptions/pt-ksb.tsv
transcribe-list-ipa pt-br dict/brazilian > transcriptions/br-ipa.tsv
transcribe-list-ipa pt-pt dict/portuguese > transcriptions/pt-ipa.tsv
```

