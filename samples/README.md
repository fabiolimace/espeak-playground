

```bash
/usr/bin/espeak-ng --version
eSpeak NG text-to-speech: 1.51  Data at: /usr/lib/x86_64-linux-gnu/espeak-ng-data
```

```bash
for i in txt/*.txt; do cat $i | /usr/bin/espeak-ng -q -x -v pt-pt > transcriptions/pt/ksb/`basename $i` ; done;
for i in txt/*.txt; do cat $i | /usr/bin/espeak-ng -q -x -v pt-br > transcriptions/br/ksb/`basename $i` ; done;
for i in txt/*.txt; do cat $i | /usr/bin/espeak-ng -q --ipa -v pt-pt > transcriptions/pt/ipa/`basename $i` ; done;
for i in txt/*.txt; do cat $i | /usr/bin/espeak-ng -q --ipa -v pt-br > transcriptions/br/ipa/`basename $i` ; done;
```
