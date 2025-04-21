
Transcriber
==================================

Description
----------------------------------

### Structure

Structure of rules for a triad of syllables:

```
+---------------------------------------------------------------------------------------+
|                              Structure of Transcriber Rules                           |
+--------------------------+---------------+-------------------------+------------------+
|          F1              |       F2      |          F3             |        F4        |
+--------------------------+---------------+-------------------------+------------------+
| [_] [Prev. Syllable] [%] | Cur. Syllable | [%] [Next Syllable] [_] |  X-SAMPA For F2  |
+--------------------------+---------------+-------------------------+------------------+
```

* `F1`: an optional regex for the previous syllable.
* `F2`: a regex for the current syllable.
* `F3`: an optional regex for the next syllable.
* `F4`: a X-SAMPA transcription of the current syllable (F2).

* `%`: an optional underline symbol that indicates the current syllable is near to the start or end of a word (the boundaries).
* `_`: an optional percent symbol that indicates that the strongest syllable (the stress) in a word is before or after the current syllable.

* `V`: is a wildcard for a vowel.
* `C`: is a wildcard for a consonant.

Note: The apostrophe is also important to find rule matches. If a stress has been detected for a word, all following rules that have an apostrophe in F4 won't match. This is to avoid that a word has more than one stressed syllable.

```
+---------------------------------------------------------------------------------------+
|                              Examples of Transcriber Rules                            |
+--------------------------+---------------+-------------------------+------------------+
|          F1              |       F2      |           F3            |        F4        |
+--------------------------+---------------+-------------------------+------------------+
|                          |      bla      |                         |       bla        |  // dri.bla.ram [dri.'bla.ra~U]
+--------------------------+---------------+-------------------------+------------------+
|                          |      bla      |           _             |       bl@        |  // dri.bla ['dri.bl@]
+--------------------------+---------------+-------------------------+------------------+
|                          |      blá      |                         |       'bla       |  // dri.blá.vel [dri.'bla.veU]
+--------------------------+---------------+-------------------------+------------------+
|                          |      ção      |           _             |      'sa~U       |  // a.ção [a.'sa~U]
+--------------------------+---------------+-------------------------+------------------+
|           %              |      ção      |           _             |       sa~U       |  // bên.ção ['be~.sa~U]
+--------------------------+---------------+-------------------------+------------------+
```

Alternative structure of rules for a pair of syllables around a space:

```
+---------------------------------------------------------------------------------------+
|                      Alternative Structure of Transcriber Rules                       |
+--------------------------+---------------+-------------------------+------------------+
|           F1             |       F2      |          F3             |        F4        |
+--------------------------+---------------+-------------------------+------------------+
|      Cur. Syllable       |       _       |      Next Syllable      |  X-SAMPA for F1  |
+--------------------------+---------------+-------------------------+------------------+
```

* `F1`: a regex for the current syllable.
* `F2`: a fixed underline character denoting a space between words.
* `F3`: a regex for the next syllable.
* `F4`: a X-SAMPA transcription of the previous syllable (F1).

This alternative structure allows for ressilabification of codas as onsets of the next word and other processes that occur in the context between two words.

Note: this alternative structure is to be implemented.

Demonstration
----------------------------------

Run the `transcriber.awk` script:

```bash
cat /usr/share/dict/brazilian | awk -f ../syllabificator/syllabificator.awk  \
    | awk -f transcriber.awk 2> /dev/null | awk 'NF' > transcriber.output.txt
```

You need the syllabificator to generate the input for `transcriber.awk`.

Output sample:

```bash
shuf -n 200  transcriber.output.txt  | sort
```
```
a.dẽ.'ta.ɾẽɪ
a.di.a.mã.'teɪs
a.di.vi.ɲa.'ɾi.ãʊ
a.do.ẽ.ta.'ɾi.ə
ad.ʒe.ti.'vaʊ
ad.ʒu.di.ka.'do.ɾəs
a.fɾi.ka.ni.'zaɪ
'a.gi.əs
a.gɾe.mi.'a.də
ã.ko.'ɾa.ɾɪs
a.kos.'taɾ.mʊs
a.kos.tu.'ma.də
a.kɾi.zo.la.'ɾi.əs
a.lu.'as.tʃɪ
a.ma.'sa.dəs
a.mã.'sa.dʊ
a.'ma.xʊ
a.ma.ze.la.'ɾas
a.mõ.to.a.'do.ɾəs
a.ne.'ʃa.vəs
a.pa.ɾe.'ʎa.mʊs
a.pas.sẽ.'ta.ɾɪs
a.pe.li.'da.ɾa.mʊs
ã.pli.fi.ka.'ti.vʊ
'aɾ.də
aɾ.ga.ma.sa.'do.ɾəs
a.si.ɾi.o.lo.'ʒis.tə
a.te.di.a.'ɾeɪ
a.te.'nu.aɪ
ã.te.o.ku.'pa
a.toʊ.si.ɲa.'ɾe.mʊs
a.tɾo.'so.ẽɪ
aʊ.'kã.ta.ɾəs
a.xa.bu.'ʒaɪs
a.zu.le.'ʒaɪs
ba.bi.'lo.ni.kʊ
buɾ.'ki.nəs
da.ti.lo.gɾa.fa.'ɾeɪs
de.di.ʎa.'ɾeɪs
de.'kɾe.tʃɪs
de.maɾ.ka.'do.ɾə
de.nu͂.si.'a.vãʊ
de.nu͂.'si.eɪs
de.pɾe.ẽ.'de.ɾẽɪ
des.gas.'te.mʊs
de.si.li.tɾa.'ɾa
de.sı͂.foɾ.'ma.seɪs
des.ko.oɾ.de.na.'ɾeɪ
des.kõ.pɾo.'me.teʊ
des.kõ.tɾa.'taɾ.dʒɪs
des.kõ.ʒu.'ɾeɪs
des.'kɾa.vãʊ
des.pe.'da.sɪ
des.plã.'te.mʊs
des.tɾo.'sa.ɾɪs
des.vẽ.si.'ʎa.də
des.xes.põ.sa.bi.li.za.'ɾas
de.za.pɾẽ.'di.eɪs
de.za.ʒeɪ.'teɪ
de.zẽ.faɪ.ʃa.'ɾas
de.zẽ.ka.'xeɪ.ɾə
de.zẽ.kos.ta.'ɾe.mʊs
de.zeɾ.'tas.tʃɪ
de.zes.ti.mu.la.'ɾi.ə
de.zẽ.vẽ.si.'ʎa.ɾẽɪ
de.zẽ.xas.'kã.dʊ
de.zo.be.de.se.'ɾi.ə
de.zo.ksi.ʒe.'nã.dʊ
di.na.mi.za.'ɾas
dis.fe.'ɾi.də
di.si.mu.'la.veʊ
dɾe.na.'ɾãʊ
ẽ.fas.ti.'a.vãʊ
ẽ.feɪ.'ti.saɪs
ẽ.foɾ.te.se.'ɾi.a.mʊs
ẽ.fɾẽ.'ta.se.mʊs
ẽ.kaʊ.deɪ.'ɾa.va.mʊs
ẽ.ka.vaʊ.'ga.ɾẽɪ
e.klo.'di.seɪs
ẽ.kwa.'dɾa.və
e.kwa.si.'o.nʊ
e.leɪ.to.'ɾaʊ
e.li.mi.'na.veʊ
e.'ɾas.mʊ
es.gaɾ.sa.'ɾe.mʊs
es.pe.to.'ɾaɪ
es.pe.to.ɾa.'ɾeɪs
es.te.ti.za.'ɾãʊ
ẽ.ʃa.me.a.'ɾas
ẽ.taɾ.de.'se.ɾəs
ẽ.xo.'lã.dʊ
fa.to.'ɾas.se.mʊs
fe.de.'ʎi.sɪ
fis.'gaɾ
fos.fo.ɾes.'si.əs
fɾã.'ʒa.va.mʊs
go.veɾ.'naʊ
i.be.ɾi.'zeɪs
i.di.o.ti.'za.sɪ
i.fe.ni.za.'ɾãʊ
i.ma.ʒi.'nas.tʃɪ
i.peɾ.bo.'li.zẽ
iɾ.lã.'des
ı͂.'kɔ.mo.dʊs
ı͂.pɾo.pɾi.'a.ɾãʊ
ı͂s.ti.la.'ɾeɪs
ı͂.teɾ.'na.mʊ
ı͂.teɾ.se.'deɾ.mʊ
ka.'kɔ.fa.tʊ
ka.li.dos.'kɔ.pi.ʊ
ka.ɾa.'paʊ
kaɾ.'bu.ɾəs
ka.se.'teɪ.ʊ
kas.ti.sa.'ɾi.ãʊ
ka.ta.xe.'a.ɾəs
kõ.'di.gnə
kõ.fa.bu.'la.mʊ
kõ.glu.ti.na.'ɾe.mʊs
koɪ~.di.'ka.sẽɪ
kõ.pɾo.me.'tʃi.eɪs
koɾ.de.'a.ɾə
kõ.'seɪ.tʊ
kõs.te.'lã.dʊ
kõs.teɾ.'na.dʊs
kõ.tes.tu.a.li.'za.ɾa.mʊs
kõ.tuɾ.ba.'ɾi.a.mʊs
kõ.'vi.ɲãʊ
kuɾ.ve.'ʒa.sẽɪ
kwã.ti.ta.'ti.vəs
kwı͂.tu.pli.'kaɾ.mʊs
la.ti.ni.za.'ɾe.mʊs
loʊ.'zeɪ.rʊ
ma.ki.la.'ɾi.ãʊ
me.di.ka.mẽ.'ta.ɾãʊ
me.mo.ɾi.'za.ɾẽɪ
mi.'ga.ɾə
mo.li.ɲa.'ɾãʊ
mo.'ɾe.nʊ
mo.ti.'na.se.mʊs
mu.'tu͂ʊ
muʊ.'ta.mʊs
naʊ.ze.a.'ɾi.ə
no.ta.'ɾi.eɪs
o.ne.'ɾa.dʊs
oʊ.'ve.ɾãʊ
paɾ.si.a.li.'za.ɾa.mʊs
pa.tɾo.ne.a.'ɾi.eɪs
paʊ.mi.'ʎoʊ
paʊ.pi.'ta.se.mʊs
peɾ.mu.'ta.sɪs
ple.bis.si.'ta.ɾa.mʊs
pɾa.zẽ.te.a.'ɾãʊ
pɾe.'ka.vɪs
pɾo.ẽ.'zi.mə
pɾo.pa.ga.'ɾi.a.mʊs
pɾos.pek.ta.'ɾi.a.mʊs
pɾo.vi.'e.ɾãʊ
sa.bo.ne.'teɪ.ɾə
saʊ.mo.di.'a.sɪs
sa.zo.na.li.'da.dʒɪ
se.gu͂.da.'ɾi.əs
se.kẽ.si.'aɾ.mʊs
si.ga.'na.se.mʊs
soɾ.te.'a.ɾə
su.ba.li.mẽ.'ta.dəs
su.ba.li.mẽ.ta.'ɾi.ãʊ
sub.zu.'mi.sɪs
su.es.'taɾ.dʒɪs
su.fo.'ka.va.mʊs
su.fɾa.'ga.se.mʊs
su.pli.si.a.'do.ɾə
'suɾ.dʒɪ
'ʃu͂.bʊs
te.le.gi.a.'ɾi.ə
te.'ʎaɾs.tʃɪs
te.me.'ɾe.mʊs
tẽ.si.'o.nɪ
to.'a.sɪ
tos.ta.'ɾa
trı͂.'ka.və
tɾãs.'ʒe.ni.kʊs
tɾo.'ta.mʊ
vi.ti.ma.'ɾi.eɪs
vi.za.'ɾi.ãʊ
xa.le.'a.sɪ
xa.mi.'fi.koʊ
xas.'gaɾ.mʊs
xẽ.'de.ɾa.mʊs
xe.ẽ.di.ɾeɪ.ta.'ɾãʊ
xe.ẽ.po.'saɪ
xe.'ga.sʊ
xe.ka.'taɾ.mʊs
xe.kla.'maɾ.mʊs
xe.pẽ.sa.'ɾeɪs
xe.pu.bli.ka.ni.'za.ɾəs
xes.plã.de.'se.ɾəs
xes.se.'kẽɪ
xes.'ta.ɾãʊ
xe.vo.lu.si.o.'naɾ
ʒe.'la.dʊs
```
