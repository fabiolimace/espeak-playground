# Transcription

```bash
function transcribe-ksb { /usr/bin/espeak-ng -q -x -v "$1" "$2"; }
function transcribe-ipa { /usr/bin/espeak-ng -q --ipa -v "$1" "$2"; }

function transcribe-list-ksb { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ksb $lang "$i"`"; done; }
function transcribe-list-ipa { lang=$1; dict=$2; for i in `cat $dict`; do echo -e "$i\t`transcribe-ipa $lang "$i"`"; done; }
```

```bash
transcribe-list-ksb pt-br ../brazilian > brazilian-ksb.tsv
transcribe-list-ksb pt-pt ../portuguese > portuguese-ksb.tsv

transcribe-list-ipa pt-br ../brazilian > brazilian-ipa.tsv
transcribe-list-ipa pt-pt ../portuguese > portuguese-ipa.tsv
```

