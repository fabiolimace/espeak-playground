Dicionário Silveira Bueno
============================

Define a dictionary to be used:

```bash
DICTIONARY="PRIVATE/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.txt"
```

List dictionaries entries that contain indication of the rised vowel [ó]:

```bash
grep -E "[^ ]+ \([^)]+\) \[ó\]" "${DICTIONARY}" | head
```
```
abrolhos (a.bro.lhos) [ó] s.m.pl. 1. Rochas submersas no mar, próximas da costa, que podem ser perigosas para a navegação. 2. (Fig.) Dificuldades.
acerola (a.ce.ro.la) [ó] s.f. (Bot.) Fruta pequena e alaranjada originária da América Central, apreciada em sucos e rica em vitamina C.
acorde (a.cor.de) [ó] adj. 1. Que está combinado ou de acordo; concorde, harmônico. s.m. 2. (Mús.) Harmonia gerada pela união de notas: com três acordes já dá para fazer um baião. 3. Cântico, poesia lírica.
afora (a.fo.ra) [ó] adv. 1. Por toda a extensão ou duração: seguia pela estrada afora; foi ensinando pela vida afora. 2. (Raro) Para o lado de fora: disse tchau e saiu porta afora. prep. 3. Fora, menos, exceto; à exceção de: agradou a todos afora um ou outro.
aftosa (af.to.sa) [ó] s.f. (Bio.) Doença viral muito contagiosa, comum no gado bovino. Também chamada febre aftosa.
agiota (a.gi.o.ta) [ó] s.2g. Pessoa que empresta dinheiro a juros sem seguir a legislação; usurário.
aldeola (al.de.o.la) [ó] s.f. Pequena aldeia.
amora (a.mo.ra) [ó] s.f. (Bot.) Fruto da amoreira.
amorfo (a.mor.fo) [ó] adj. Que não tem forma determinada.
anedota (a.ne.do.ta) [ó] s.f. 1. Narração curta e engraçada, que alguém conta para divertir os outros; piada. 2. Particularidade engraçada de alguém.
```

Listing the words that should be pronunced by espeak-ng with an [ˈɔ] (open "o"):

```bash
grep -E "[^ ]+ \([^)]+\) \[ó\]" "${DICTIONARY}" | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, $4, "[" phonemes "]" }' | grep -F 'ˈo'
```
```
abrolhos (a.bro.lhos) [ó] s.m.pl. [ˌabɾˈoʎʊs]
amorfo (a.mor.fo) [ó] adj. [ˌɐmˈoɾfʊ]
baitola (bai.to.la) [ó] s.m. [bˌaɪtˈolɐ]
barroca (bar.ro.ca) [ó] s.f. [bˌaxˈokɐ]
birosca (bi.ros.ca) [ó] s.f. [bˌiɾˈoskɐ]
broxa (bro.xa) [ó] s.f. [bɾˈoʃɐ]
corte (cor.te) [ó] s.m. [kˈɔɾtʃɪ dˈoɪs]
covo (co.vo) [ó] s.m. [kˈovʊ dˈoɪs]
derredor (der.re.dor) [ó] s.m. [dˌexedˈoɾ]
gabiroba (ga.bi.ro.ba) [ó] s.f. [ɡˌabiɾˈobɐ]
guabiroba (gua.bi.ro.ba) [ó] s.f. [ɡwˌabiɾˈobɐ]
joça (jo.ça) [ó] s.f. [ʒˈosɐ]
lobo (lo.bo) [ó] s.m. [lˈobʊ dˈoɪs]
logo (lo.go) [ó] adv. [lˈɔɡʊ dˈoɪs]
manossolfa (ma.nos.sol.fa) [ó] s.f. [mˌɐnosˈowfɐ]
marosca (ma.ros.ca) [ó] s.f. [mˌaɾˈoskɐ]
molho (mo.lho) [ó] s.m. [mˈɔʎʊ dˈoɪs]
oca (o.ca) [ó] s.f. [ˈokɐ]
ocra (o.cra) [ó] s.f. [ˈokɾɐ]
ocre (o.cre) [ó] s.m. [ˈokɾɪ]
pletora (ple.to.ra) [ó] s.f. [plˌetˈoɾɐ]
polimorfo (po.li.mor.fo) [ó] adj. [pˌolimˈoɾfʊ]
quiosque (qui.os.que) [ó] s.m. [kˌiˈoskɪ]
regabofe (re.ga.bo.fe) [ó] s.m. [xˌeɡabˈofɪ]
robe (ro.be) [ó] s.m. [xˈobɪ]
taioba (tai.o.ba) [ó] s.f. [tˌaɪˈobɐ]
xador (xa.dor) [ó] s.m. [ʃadˈoɾ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈo] (closed "o"):

```bash
grep -E "[^ ]+ \([^)]+\) \[ô\]" "${DICTIONARY}" | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, $4, "[" phonemes "]" }' | grep -F 'ˈɔ'
```
```
açorda (a.çor.da) [ô] s.f. [ˌasˈɔɾdɐ]
agridoce (a.gri.do.ce) [ô] adj.2g. [ˌaɡɾidˈɔsɪ]
algoz (al.goz) [ô] s.m. [aʊɡˈɔs]
anodo (a.no.do) [ô] s.m. [ˌɐnˈɔdʊ]
apodo (a.po.do) [ô] s.m. [ˌapˈɔdʊ]
arrojo (ar.ro.jo) [ô] s.m. [ˌaxˈɔʒʊ]
arroto (ar.ro.to) [ô] s.m. [ˌaxˈɔtʊ]
assopro (as.so.pro) [ô] s.m. [ˌasˈɔpɾʊ]
azoto (a.zo.to) [ô] s.m. [ˌazˈɔtʊ]
baitolo (bai.to.lo) [ô] s.m. [bˌaɪtˈɔlʊ]
bancarrota (ban.car.ro.ta) [ô] s.f. [bˌɐ̃ŋkaxˈɔtɐ]
boldo (bol.do) [ô] s.m. [bˈɔldʊ]
bororo (bo.ro.ro) [ô] s.2g. [bˌoɾˈɔɾʊ]
borra (bor.ra) [ô] s.f. [bˈɔxɐ]
boto (bo.to) [ô] s.m. [bˈɔtʊ]
broto (bro.to) [ô] s.m. [bɾˈɔtʊ]
cachopa (ca.cho.pa) [ô] s.f. [kˌaʃˈɔpɐ]
chope (cho.pe) [ô] s.m. [ʃˈɔpɪ]
choro (cho.ro) [ô] s.m. [ʃˈɔɾʊ]
consolo (con.so.lo) [ô] s.m. [kˌõnsˈɔlʊ]
controle (con.tro.le) [ô] s.m. [kˌõntɾˈɔlɪ]
corte (cor.te) [ô] s.f. [kˈɔɾtʃɪ ˈũm]
decoro (de.co.ro) [ô] s.m. [dˌekˈɔɾʊ]
denodo (de.no.do) [ô] s.m. [dˌenˈɔdʊ]
desafogo (de.sa.fo.go) [ô] s.m. [dˌezafˈɔɡʊ]
desconsolo (des.con.so.lo) [ô] s.m. [dˌeskõnsˈɔlʊ]
descontrole (des.con.tro.le) [ô] s.m. [dˌeskõntɾˈɔlɪ]
desembolso (de.sem.bol.so) [ô] s.m. [dˌezeɪmbˈɔlsʊ]
despojo (des.po.jo) [ô] s.m. [dˌespˈɔʒʊ]
destroço (des.tro.ço) [ô] s.m. [dˌestɾˈɔsʊ]
dolo (do.lo) [ô] s.m. [dˈɔlʊ]
eletrodo (e.le.tro.do) [ô] s.m. [ˌeletɾˈɔdʊ]
embolso (em.bol.so) [ô] s.m. [ˌeɪmbˈɔlsʊ]
empola (em.po.la) [ô] s.f. [ˌeɪmpˈɔlɐ]
enchova (en.cho.va) [ô] s.f. [ˌeɪnʃˈɔvɐ]
endosso (en.dos.so) [ô] s.m. [ˌeɪndˈɔsʊ]
entojo (en.to.jo) [ô] s.m. [ˌeɪntˈɔʒʊ]
escopro (es.co.pro) [ô] s.m. [ˌeskˈɔpɾʊ]
estroço (es.tro.ço) [ô] s.m. [ˌestɾˈɔsʊ]
forma2 (for.ma) [ô] s.f. [fˈɔɾmɐ dˈoɪs]
foro (fo.ro) [ô] s.m. [fˈɔɾʊ]
godo (go.do) [ô] s.m. [ɡˈɔdʊ]
gonococo (go.no.co.co) [ô] s.m. [ɡˌonokˈɔkʊ]
goro (go.ro) [ô] adj. [ɡˈɔɾʊ]
goto (go.to) [ô] s.m. [ɡˈɔtʊ]
gozo (go.zo) [ô] s.m. [ɡˈɔzʊ]
heliporto (he.li.por.to) [ô] s.m. [ˌelipˈɔɾtʊ]
indecoro (in.de.co.ro) [ô] s.m. [ˌĩndekˈɔɾʊ]
insosso (in.sos.so) [ô] adj. [ˌĩnsˈɔsʊ]
logo1 (lo.go) [ô] s.m. [lˈɔɡw ˈũm]
logro (lo.gro) [ô] s.m. [lˈɔɡɾʊ]
lorpa (lor.pa) [ô] s.2g. [lˈɔɾpɐ]
loto2 (lo.to) [ô] s.m. [lˈɔtʊ dˈoɪs]
awk: lin. de com.:1: (FILENAME=- FNR=1021) fatal: não foi possível abrir pipe "espeak-ng -v pt-br --ipa -q menina-moça": Muitos arquivos abertos
manojo (ma.no.jo) [ô] s.m. [mˌɐnˈɔʒʊ]
manzorra (man.zor.ra) [ô] s.f. [mˌɐ̃nzˈɔxɐ]
mãos-rotas (mãos-ro.tas) [ô] s.2g.2n. [mˈɐ̃ʊ̃zxˈɔtɐs]
marnoto (mar.no.to) [ô] s.m. [mˌaɾnˈɔtʊ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈɛ] (open "e"):

```bash
grep -E "[^ ]+ \([^)]+\) \[é\]" "${DICTIONARY}" | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, $4, "[" phonemes "]" }' | grep -F 'ˈe'
```
```
aedo (a.e.do) [é] s.m. [ˌaˈedʊ]
besta2 (bes.ta) [é] s.f. [bˈestɐ dˈoɪs]
besta-fera (bes.ta-fe.ra) [é] s.f. [bˈestɐfˈɛɾɐ]
cateter (ca.te.ter) [é] s.m. [kˌatetˈeɾ]
colher2 (co.lher) [é] s.f. [koʎˈeɾ dˈoɪs]
derma (der.ma) [é] s.m. [dˈeɾmɐ]
escaler (es.ca.ler) [é] s.m. [ˌeskalˈeɾ]
esmoler (es.mo.ler) [é] s.m. [ˌezmolˈeɾ]
eta (e.ta) [é] s.m. [ˈetɐ]
fresa (fre.sa) [é] s.f. [fɾˈezɐ]
gleba (gle.ba) [é] s.f. [ɡlˈebɐ]
haltere (hal.te.re) [é] s.m. [ˌaʊtˈeɾɪ]
hera (he.ra) [é] s.f. [ˈeɾɐ]
herpes (her.pes) [é] s.m.pl. [ˈeɾpɪs]
homeotermo (ho.me.o.ter.mo) [é] s.m. [ˌomeotˈeɾmʊ]
masseter (mas.se.ter) [é] s.m. [mˌasetˈeɾ]
medo2 (me.do) [é] s.m. [mˈedʊ dˈoɪs]
melopeia (me.lo.pei.a) [é] s.f. [mˌelopˈeɪɐ]
meta (me.ta) [é] s.f. [mˈetɐ]
palerma (pa.ler.ma) [é] s.2g. [pˌalˈeɾmɐ]
pela (pe.la) [é] s.f. [pˈelɐ]
Quaresma (qua.res.ma) [é] s.f. [kwˌaɾˈezmɐ]
quepe (que.pe) [é] s.m. [kˈepɪ]
quirera (qui.re.ra) [é] 1. [kˌiɾˈeɾɐ]
refle (re.fle) [é] s.m. [xˈeflɪ]
sede2 (se.de) [é] s.f. [sˈedʒɪ dˈoɪs]
tapeba (ta.pe.ba) [é] s.2g. [tˌapˈebɐ]
tatupeba (ta.tu.pe.ba) [é] s.m. [tˌatupˈebɐ]
teta2 (te.ta) [é] s.m. [tˈetɐ dˈoɪs]
```

Listing the words that should be pronunced by espeak-ng with an [ˈe] (closed "e"):

```bash
grep -E "[^ ]+ \([^)]+\) \[ê\]" "${DICTIONARY}" | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, $4, "[" phonemes "]" }' | grep -F 'ˈɛ'
```
```
abelha-mestra (a.be.lha-mes.tra) [ê] s.f. [ˌabˈeʎɐmˈɛstɾɐ]
abeto (a.be.to) [ê] s.m. [ˌabˈɛtʊ]
acerto (a.cer.to) [ê] s.m. [ˌasˈɛɾtʊ]
adrede (a.dre.de) [ê] adv. [ˌadɾˈɛdʒɪ]
alegreto (a.le.gre.to) [ê] s.m. [ˌaleɡɾˈɛtʊ]
alegro (a.le.gro) [ê] s.m. [ˌalˈɛɡɾʊ]
ama-seca (a.ma-se.ca) [ê] s.f. [ˈɐ̃mɐsˈɛkɐ]
ambidestro (am.bi.des.tro) [ê] adj. [ˌɐ̃mbidˈɛstɾʊ]
anacoreta (a.na.co.re.ta) [ê] s.2g. [ˌɐnakoɾˈɛtɐ]
apego (a.pe.go) [ê] s.m. [ˌapˈɛɡʊ]
apelo (a.pe.lo) [ê] s.m. [ˌapˈɛlʊ]
aperto (a.per.to) [ê] s.m. [ˌapˈɛɾtʊ]
arremesso (ar.re.mes.so) [ê] s.m. [ˌaxemˈɛsʊ]
asbesto (as.bes.to) [ê] s.m. [ˌazbˈɛstʊ]
asserto (as.ser.to) [ê] s.m. [ˌasˈɛɾtʊ]
atropelo (a.tro.pe.lo) [ê] s.m. [ˌatɾopˈɛlʊ]
baeta (ba.e.ta) [ê] s.f. [bˌaˈɛtɐ]
barrete (bar.re.te) [ê] s.m. [bˌaxˈɛtʃɪ]
borrego (bor.re.go) [ê] s.m. [bˌoxˈɛɡʊ]
cacholeta (ca.cho.le.ta) [ê] s.f. [kˌaʃolˈɛtɐ]
café-concerto (ca.fé-con.cer.to) [ê] s.m. [kafˈɛkˌõnsˈɛɾtʊ]
cambeta (cam.be.ta) [ê] adj.2g. [kˌɐ̃mbˈɛtɐ]
canhestro (ca.nhes.tro) [ê] adj. [kˌɐ̃ɲˈɛstɾʊ]
carne-seca (car.ne-se.ca) [ê] s.f. [kˈaɾnɪsˈɛkɐ]
carreto (car.re.to) [ê] s.m. [kˌaxˈɛtʊ]
cepa (ce.pa) [ê] s.f. [sˈɛpɐ]
cepo (ce.po) [ê] s.m. [sˈɛpʊ]
cerro (cer.ro) [ê] s.m. [sˈɛxʊ]
cincerro (cin.cer.ro) [ê] s.m. [sˌĩnsˈɛxʊ]
concerto (con.cer.to) [ê] s.m. [kˌõnsˈɛɾtʊ]
conserto (con.ser.to) [ê] s.m. [kˌõnsˈɛɾtʊ]
cureta (cu.re.ta) [ê] s.f. [kˌuɾˈɛtɐ]
desaperto (de.sa.per.to) [ê] s.m. [dˌezapˈɛɾtʊ]
desassossego (de.sas.sos.se.go) [ê] s.m. [dˌezasosˈɛɡʊ]
desconcerto (des.con.cer.to) [ê] s.m. [dˌeskõnsˈɛɾtʊ]
desgoverno (des.go.ver.no) [ê] s.m. [dˌezɡovˈɛɾnʊ]
desinteresse (de.sin.te.res.se) [ê] s.m. [dˌezĩnteɾˈɛsɪ]
desmazelo (des.ma.ze.lo) [ê] s.m. [dˌezmazˈɛlʊ]
desprezo (des.pre.zo) [ê] s.m. [dˌespɾˈɛzʊ]
destempero (des.tem.pe.ro) [ê] s.m. [dˌesteɪmpˈɛɾʊ]
desvelo (des.ve.lo) [ê] s.m. [dˌezvˈɛlʊ]
diabrete (di.a.bre.te) [ê] s.m. [dʒˌiabɾˈɛtʃɪ]
diedro (di.e.dro) [ê] s.m. [dʒˌiˈɛdɾʊ]
enlevo (en.le.vo) [ê] s.m. [ˌeɪnlˈɛvʊ]
enterro (en.ter.ro) [ê] s.m. [ˌeɪntˈɛxʊ]
enxerga (en.xer.ga) [ê] s.f. [ˌeɪnʃˈɛɾɡɐ]
enxerto (en.xer.to) [ê] s.m. [ˌeɪnʃˈɛɾtʊ]
escabelo (es.ca.be.lo) [ê] s.m. [ˌeskabˈɛlʊ]
escalpelo (es.cal.pe.lo) [ê] s.m. [ˌeskaʊpˈɛlʊ]
esmero (es.me.ro) [ê] s.m. [ˌezmˈɛɾʊ]
espatuleta (es.pa.tu.le.ta) [ê] s.f. [ˌespatulˈɛtɐ]
espeto (es.pe.to) [ê] s.m. [ˌespˈɛtʊ]
estafeta (es.ta.fe.ta) [ê] s.f. [ˌestafˈɛtɐ]
esto (es.to) [ê] s.m. [ˈɛstʊ]
excerto (ex.cer.to) [ê] s.m. [ˌesˈɛɾtʊ]
faceto (fa.ce.to) [ê] adj. [fˌasˈɛtʊ]
falsete (fal.se.te) [ê] s.m. [fˌaʊsˈɛtʃɪ]
fecho (fe.cho) [ê] s.m. [fˈɛʃʊ]
felpa (fel.pa) [ê] s.f. [fˈɛʊpɐ]
feltro (fel.tro) [ê] s.m. [fˈɛʊtɾʊ]
ferrete (fer.re.te) [ê] s.m. [fˌexˈɛtʃɪ]
filipeta (fi.li.pe.ta) [ê] s.f. [fˌilipˈɛtɐ]
flerte (fler.te) [ê] s.m. [flˈɛɾtʃɪ]
galhardete (ga.lhar.de.te) [ê] s.m. [ɡˌaʎaɾdˈɛtʃɪ]
galheta (ga.lhe.ta) [ê] s.f. [ɡˌaʎˈɛtɐ]
grelo (gre.lo) [ê] s.m. [ɡɾˈɛlʊ]
greta (gre.ta) [ê] s.f. [ɡɾˈɛtɐ]
grilheta (gri.lhe.ta) [ê] s.f. [ɡɾˌiʎˈɛtɐ]
grumete (gru.me.te) [ê] s.m. [ɡɾˌumˈɛtʃɪ]
historieta (his.to.ri.e.ta) [ê] s.f. [ˌistoɾiˈɛtɐ]
jarrete (jar.re.te) [ê] s.m. [ʒˌaxˈɛtʃɪ]
labrego (la.bre.go) [ê] adj. [lˌabɾˈɛɡʊ]
lazareto (la.za.re.to) [ê] s.m. [lˌazaɾˈɛtʊ]
libreto (li.bre.to) [ê] s.m. [lˌibɾˈɛtʊ]
machete (ma.che.te) [ê] s.m. [mˌaʃˈɛtʃɪ]
malacacheta (ma.la.ca.che.ta) [ê] s.f. [mˌalakaʃˈɛtɐ]
malhete (ma.lhe.te) [ê] s.m. [mˌaʎˈɛtʃɪ]
mantelete (man.te.le.te) [ê] s.m. [mˌɐ̃ntelˈɛtʃɪ]
marchete (mar.che.te) [ê] s.m. [mˌaɾʃˈɛtʃɪ]
menosprezo (me.nos.pre.zo) [ê] s.m. [mˌenospɾˈɛzʊ]
meseta (me.se.ta) [ê] s.f. [mˌezˈɛtɐ]
micareta (mi.ca.re.ta) [ê] s.f. [mˌikaɾˈɛtɐ]
micromicete (mi.cro.mi.ce.te) [ê] s.m. [mˌikɾomisˈɛtʃɪ]
minarete (mi.na.re.te) [ê] s.m. [mˌinaɾˈɛtʃɪ]
mosquete (mos.que.te) [ê] s.m. [mˌoskˈɛtʃɪ]
motete (mo.te.te) [ê] s.m. [mˌotˈɛtʃɪ]
nega (ne.ga) [ê] s.f. [nˈɛɡɐ]
nego (ne.go) [ê] s.m. [nˈɛɡʊ]
papeleta (pa.pe.le.ta) [ê] s.f. [pˌapelˈɛtɐ]
paquete (pa.que.te) [ê] s.m. [pˌakˈɛtʃɪ]
pega (pe.ga) [ê] s.f. [pˈɛɡɐ]
pele-vermelha (pe.le-ver.me.lha) [ê] s.2g. [pˈɛlɪvˌeɾmˈeʎɐ]
peta (pe.ta) [ê] s.f. [pˈɛtɐ]
picareta (pi.ca.re.ta) [ê] s.f. [pˌikaɾˈɛtɐ]
pipeta (pi.pe.ta) [ê] s.f. [pˌipˈɛtɐ]
pontalete (pon.ta.le.te) [ê] s.m. [pˌõntalˈɛtʃɪ]
ponta-seca (pon.ta-se.ca) [ê] s.f. [pˈõntɐsˈɛkɐ]
prancheta (pran.che.ta) [ê] s.f. [pɾˌɐ̃nʃˈɛtɐ]
pré-carnavalesco (pré-car.na.va.les.co) [ê] adj. [pɾˈɛkˌaɾnavalˈeskʊ]
quebra-cabeça (que.bra-ca.be.ça) [ê] s.m. [kˈɛbɾɐkˌabˈesɐ]
quebra-gelos (que.bra-ge.los) [ê] s.m.2n. [kˈɛbɾɐʒˈelʊs]
refego (re.fe.go) [ê] s.m. [xˌefˈɛɡʊ]
rego (re.go) [ê] s.m. [xˈɛɡʊ]
remelexo (re.me.le.xo) [ê] s.m. [xˌemelˈɛksʊ]
requebro (re.que.bro) [ê] s.m. [xˌekˈɛbɾʊ]
retretra (re.tre.tra) [ê] s.f. [xˌetɾˈɛtɾɐ]
revesso (re.ves.so) [ê] adj. [xˌevˈɛsʊ]
ricochete (ri.co.che.te) [ê] s.m. [xˌikoʃˈɛtʃɪ]
roquete (ro.que.te) [ê] s.m. [xˌokˈɛtʃɪ]
roupeta (rou.pe.ta) [ê] s.f. [xˌoʊpˈɛtɐ]
sarampelo (sa.ram.pe.lo) [ê] s.m. [sˌaɾɐ̃mpˈɛlʊ]
seca (se.ca) [ê] s.f. [sˈɛkɐ]
serro (ser.ro) [ê] s.m. [sˈɛxʊ]
soquete1 (so.que.te) [ê] s.m. [sˌokˈɛtʃɪ ˈũm]
sossego (sos.se.go) [ê] s.m. [sˌosˈɛɡʊ]
subemprego (su.bem.pre.go) [ê] s.m. [sˌubeɪmpɾˈɛɡʊ]
tabuleta (ta.bu.le.ta) [ê] s.f. [tˌabulˈɛtɐ]
tamborete (tam.bo.re.te) [ê] s.m. [tˌɐ̃mboɾˈɛtʃɪ]
tarjeta (tar.je.ta) [ê] s.f. [tˌaɾʒˈɛtɐ]
tempero (tem.pe.ro) [ê] s.m. [tˌeɪmpˈɛɾʊ]
testo (tes.to) [ê] s.m. [tˈɛstʊ]
tolete (to.le.te) [ê] s.m. [tˌolˈɛtʃɪ]
torniquete (tor.ni.que.te) [ê] s.m. [tˌoɾnikˈɛtʃɪ]
traquete (tra.que.te) [ê] s.m. [tɾˌakˈɛtʃɪ]
tropeço (tro.pe.ço) [ê] s.m. [tɾˌopˈɛsʊ]
verga (ver.ga) [ê] s.m. [vˈɛɾɡɐ]
versalete (ver.sa.le.te) [ê] s.m. [vˌeɾsalˈɛtʃɪ]
verseto (ver.se.to) [ê] s.m. [vˌeɾsˈɛtʊ]
viscondessa (vis.con.des.sa) [ê] s.f. [vˌiskõndˈɛsɐ]
voltarete (vol.ta.re.te) [ê] s.m. [vˌowtaɾˈɛtʃɪ]
xarelete (xa.re.le.te) [ê] s.m. [ʃˌaɾelˈɛtʃɪ]
xepa (xe.pa) [ê] s.f. [ʃˈɛpɐ]
xerelete (xe.re.le.te) [ê] s.m. [ʃˌeɾelˈɛtʃɪ]
zelo (ze.lo) [ê] s.m. [zˈɛlʊ]
zelos (ze.los) [ê] s.m.pl. [zˈɛlʊs]
```

Listing feminine forms:

```grep
grep -Eo "Fem\. [[:alpha:]-]+" "${DICTIONARY}" | awk '{ print $2 }'
```
```
abadessa
alguma
anciã
aquela
arquiduquesa
baixota
bestalhona
bisavó
canastrona
charlatona
condessa
consulesa
dona
embaixadora
essa
esta
garçonete
giganta
grua
guardiã
guria
hebreia
heroína
ilhoa
lha
minha
miss
monja
matriarca
recomposta
ré
sandia
sua
solteirona
tua
titânide
```

Listing plural forms:

```bash
grep -Eo " Pl\. [[:alpha:]-]+" "${DICTIONARY}" | awk '{ print $2 }'
```
```
abaixo-assinados
abdômenes
abelhas-mestras
açafrões-da-índia
acintosos
açúcares-candes
açúcares-cândis
açuns-pretos
adiposos
aeroportos
afetuosos
afro-americanos
afro-asiáticos
afro-brasileiros
afrontosos
aftosos
agriões-do-norte
águas-de-colônia
águas-fortes
águas-furtadas
águas-marinhas
águas-vivas
aids
airosos
alcalino-terrosos
álcoois
aleivosos
além-mares
além-túmulos
alferes
alguns
alhos-porós
alhos-porros
almas-de-caboclo
almas-de-gato
altas-fidelidades
altares-mores
altas-rodas
alterosos
alto-falantes
altos-fornos
altos-mares
altos-relevos
alúmenes
amargosos
amarílis
amas-secas
ambiciosos
amistosos
amorosos
amores-perfeitos
amores-próprios
anciões
andrajosos
anglo-saxões
anglo-saxônicos
angulosos
angustiosos
animosos
anises-estrelados
anos-luz
anos-novos
ansiosos
anticorpos
anti-higiênicos
anti-infecciosos
antissépticos
ânus
aparatosos
apetitosos
apostos
aquosos
arcos-da-velha
arco-íris
ares-condicionados
ardilosos
ardorosos
arenosos
arraias-miúdas
arranca-rabos
arranha-céus
arrasta-pés
arrozes-doces
artesões
artificiosos
asas-delta
asquerosos
assa-fétidas
assombrosos
astuciosos
atenciosos
au-aus
audaciosos
auspiciosos
avás-canoeiros
avant-premières
ave-marias
do
do
babosos
baixa-mares
baixos-relevos
baixos-ventres
bananas-da-terra
bananeiras-de-corda
banauás-iafis
bangue-bangues
banhos-marias
barbas-azuis
barra-manteigas
barrigas-d
barrigas-verdes
barrosos
batatas-doces
batatas-inglesas
bate-bocas
bate-bolas
bate-estacas
bate-papos
bate-paus
bate-pés
bê-á-bás
do
beija-flores
beija-mãos
beira-mares
belicosos
belo-horizontinos
bel-prazeres
bem-amados
bem-apessoados
bem-aventurados
bem-aventuranças
bem-casados
bem-conceituados
bem-educados
bem-estares
bem-falantes
bem-humorados
bem-nascidos
bem-quereres
bem-te-vis
bem-vindos
bem-vistos
bestas-feras
betuminosos
bíceps
bichos-da-seda
bichos-de-pé
bichos-do-pé
bichos-papões
bichos-preguiça
bicos-de-papagaio
biliosos
bílis
boas-fés
boas-noites
boas-novas
boas-tardes
boas-vidas
boa-vistenses
bocas-livres
boias-frias
bois-bumbás
bois-cornetas
bois-surubis
bois-surubins
bolsos
bons-bocados
bons-tons
bonançosos
bondosos
bóraces
do
borra-botas
bósnios-herzegovinos
bota-foras
brincos-de-princesa
briosos
brumosos
brutamontes
bulbosos
buliçosos
busca-pés
busílis
cabeças-chatas
cabeças-de-negro
cabo-frienses
cabo-verdianos
cabras-cegas
caça-dotes
caça-minas
cachorros-quentes
cafés-concerto
caftens
cais
caixas-pretas
calamitosos
calmosos
calorosos
calosos
caluniosos
campo-grandenses
campos-santos
canas-de-açúcar
canas-verdes
cancerosos
canetas-tinteiro
cânones
capciosos
capins-limão
capins-santos
capitosos
caprichosos
caras-metades
caracteres
caridosos
carinhosos
carnes-secas
carnosos
caroços
carrapatos-estrela
cartões-postais
cartilaginosos
cartuns
casas-grandes
cascosos
castanhas-do-pará
cata-ventos
caudalosos
cautelosos
cavalos-marinhos
cavalos-vapor
cavernosos
cavilosos
caxias
células-mãe
células-tronco
centro-africanos
centro-americanos
cerimoniosos
cessar-fogo
chapéus-cocos
chapéus-panamá
charlatães
charmosos
cheirosos
cheiros-verdes
chicotes-queimados
chistosos
choramingas
chorosos
chuvosos
cidadãos
cidades-estado
cidades-dormitórios
cintas-largas
ciosos
cipós-cravo
cirurgiões-dentistas
clamorosos
clitóris
cobras-cegas
cobras-de-vidro
cobras-grandes
coisas-feitas
comatosos
compostos
consolos
cônsules
contagiosos
copiosos
corajosos
cor-de-rosa
cornes-ingleses
cornos
corpos
corre-cotias
corre-cutias
corrimãos
corta-jacas
corvos
cós
cosmos
costa-marfinenses
costa-riquenhos
couves-flor
craveiras-da-terra
cravos-da-índia
cremosos
criados-mudos
criminosos
cristãos
criteriosos
cuidadosos
culposos
curiosos
curtas-metragens
cuscuz
custosos
cútis
dadivosos
dalai-lamas
danosos
decorosos
decretos-leis
dedos-de-moça
dedos-duros
defeituosos
deleitosos
deliciosos
delituosos
dengosos
depostos
desairosos
desastrosos
desatenciosos
desdenhosos
desditosos
desejosos
desgostosos
desgraciosos
desonrosos
despojos
desportos
despretensiosos
desrespeitosos
destroços
desvantajosos
diabetes
difíceis
dificultosos
dispendiosos
dispostos
ditos-cujos
ditosos
doidivanas
dolorosos
dolosos
dorme-nenês
drive-ins
duras-máteres
duvidosos
edematosos
elogiosos
e-mails
embaraçosos
enauenês-nauês
endovenosos
do
enganosos
engenhosos
ervas-cidreiras
ervas-doces
ervas-mates
ervilhas-tortas
escabrosos
escalda-pés
escamosos
escandalosos
escolhos
esconde-esconde
escrivãos
escrupulosos
esforços
espaçosos
espalha-brasas
espalhafatosos
espantosos
espaventosos
espécimens
especiosos
esperançosos
espetaculosos
espia-marés
espinhosos
espírito-santenses
espirituosos
esplendorosos
esponjosos
espumosos
esses
és-sudestes
és-sudoestes
és-suestes
estados-maiores
estado-unidenses
estaminosos
estanosos
estes
estênceis
ésteres
estipulosos
estolhosos
estratos-cúmulos
estrelas-d
estrelas-do-mar
estrepitosos
estridulosos
estrondosos
estrumosos
estudiosos
nós
excrementosos
expostos
extra-humanos
extremas-direitas
extremas-esquerdas
extremas-unções
extremosos
ex-votos
fabulosos
facciosos
fac-similares
fac-símiles
falaciosos
faltosos
famosos
fanhosos
fantasiosos
farinhas-d
fastidiosos
faustosos
fax
faz-tudo
feijões-fradinhos
feijões-soja
feiosos
ferrosos
ferros-velhos
ferruginosos
fervorosos
fibrosos
filas-brasileiros
filamentosos
filhoses
finca-pés
físico-químicas
fogos
fogo-apagou
fogos-fátuos
fogo-pagou
fogos-selvagens
fogosos
fojos
folhosos
forçosos
formosos
fornos
fósseis
fossos
fragorosos
frondosos
frutas-do-conde
frutas-pão
frutuosos
fuliginosos
fura-bolos
furiosos
fúteis
futurosos
galibis-maruornos
galinhas-d
gananciosos
ganha-pães
garbosos
gasosos
gatos-do-mato
gelatinosos
generosos
geniosos
gibosos
gira-giras
gizes
globosos
globulosos
gloriosos
glutens
gomas-arábicas
gomas-lacas
gordurosos
gostos
gostosos
gozosos
graciosos
grã-finos
gralhas-azuis
grandiosos
granulosos
grãos-de-bico
grão-ducados
grão-duques
grão-mestres
grão-vizires
grátis
gravatas-borboletas
gravidezes
gravosos
greco-latinos
greco-romanos
gris
grossos
guarani-caiouás
guarani-mbiás
guarani-nhandevas
guarda-chuvas
guarda-comidas
guarda-costas
guarda-livros
guardas-marinha
guardas-noturnos
guarda-pós
guarda-roupas
guarda-sóis
guardiões
guidões
gulosos
habilidosos
habite-se
hambúrgueres
haras
harmoniosos
heliportos
hífenes
hímenes
hispano-americanos
hobbies
honrosos
húmus
ibero-americanos
idosos
ignominiosos
imaginosos
imperiosos
impetuosos
impiedosos
impostos
incestuosos
indecorosos
indispostos
inditosos
indo-europeus
industriosos
inescrupulosos
infantojuvenis
infecciosos
injuriosos
insidiosos
interpostos
intravenosos
invejosos
invernosos
ipês-amarelos
ipês-roxos
íris
irreligiosos
itens
jactanciosos
jasmins-do-cabo
jeans
do
jecas-tatus
jeitosos
jiu-jítsus
joões-bobos
joões-de-barro
joões-ninguém
jocosos
jogos
jubilosos
judas
judiciosos
juniores
juremas-brancas
juremas-pretas
justapostos
labiosos
laboriosos
lacrimosos
lacunosos
lambe-lambes
lamentosos
lamuriosos
lança-chamas
lança-perfumes
lança-torpedos
langorosos
lanosos
lápis
laranjas-cravo
laranjas-lima
laranjas-pera
lastimosos
látex
latino-americanos
lava-pés
leões-marinhos
leguminosos
leitosos
lenhosos
leprosos
lero-leros
lesa-humanidades
lesa-pátrias
lhos
libidinosos
licenças-maternidade
licenças-paternidade
licenças-prêmio
licenciosos
licorosos
ligamentosos
limões-cravo
limões-galegos
limosos
limpa-pastos
limpa-trilhos
limpa-trilhos
línguas-de-vaca
linhas-d
líquenes
litigiosos
livres-arbítrios
livres-docências
livres-docentes
livres-pensadores
livros-caixa
livros-texto
lobos-guará
lobos-marinhos
lodosos
logros
longas-metragens
longas-vidas
louva-a-deus
ludibriosos
lufa-lufas
lugares-comuns
lugar-tenentes
lúmenes
luminosos
lusco-fuscos
luso-brasileiros
lustra-móveis
lustrosos
lutuosos
luxuosos
macacos-da-noite
más-criações
mães-bentas
mães-d
mães-da-chuva
mães-da-lua
más-fés
mafiosos
más-formações
mais-que-perfeitos
mais-valias
maîtres
maîtres-d
majestosos
mal-acabados
mal-agradecidos
mal-ajambrados
mal-ama-nhados
malas-postas
mal-assombrados
mal-aventurados
mal-avisados
malcheirosos
maldosos
mal-educados
maleitosos
mal-encarados
mal-entendidos
mal-estares
mal-humorados
maliciosos
más-línguas
mal-intencionados
malventurosos
mana-chicas
manés-gostosos
maneirosos
mangas-largas
manganosos
manhosos
manjares-brancos
manteigosos
mãos-abertas
mãos-cheias
mãos-francesas
mãos-moles
mãos-peladas
mãos-atadas
mãos-largas
mãos-rotas
mapas-múndi
maravilhosos
marés-cheias
marias-chiquinhas
maria-é-dia
marias-fumaça
marias-isabéis
marias-moles
marias-sem-vergonha
maricas
martins-pescadores
mata-bichos
mata-borrões
mata-burros
mata-mosquitos
mata-piolhos
mata-ratos
matérias-primas
matis
mato-grossenses
mato-grossenses-do-sul
matosos
maus-caráteres
maus-olhados
maviosos
medicamentosos
médico-hospitalares
médico-legais
médicos-legistas
medrosos
meias-águas
meias-calças
meias-canas
meias-direitas
meias-entradas
meias-esquerdas
meias-estações
meias-idades
meias-luas
meias-luzes
meias-noites
meias-tintas
meias-vidas
meios-bustos
meios-corpos
meios-dias
meios-fios
meios-relevos
meios-sopranos
meios-termos
meios-tons
melindrosos
melodiosos
melosos
membranosos
meninas-moças
mentirosos
mercuriosos
mercurosos
mesas-redondas
mestres-cucas
mestres-escolas
mestres-salas
meticulosos
meus
micos-leões
micos-pretos
micro-ondas
micro-ônibus
milagrosos
mil-homens
mil-réis
mimosos
mineiros-paus
minuciosos
miolos
miosótis
miraculosos
misericordiosos
misteriosos
mistos-quentes
moedas-papéis
moléculas-gramas
momentosos
monstruosos
montanhas-russas
montanhosos
mormosos
mornos
morosos
mortos
moscas-domésticas
mucilaginosos
mucosos
munús
murmurosos
musculosos
não-me-toques
navios-tanques
nebulosos
nervosos
nevosos
nhandus-guaçus
nhô-chicos
nimbosos
nitrosos
nodosos
norte-americanos
norte-coreanos
norte-rio-grandenses
noticiosos
nova-iorquinos
novos
novos-ricos
nozes-moscadas
nozes-vômicas
numerosos
oásis
obras-primas
obsequiosos
ociosos
odiosos
office-boys
oficiosos
oleaginosos
oleosos
olhos
olorosos
ominosos
onças-pardas
onças-pintadas
ondulosos
onerosos
operosos
opiniosos
opostos
orelhas-de-padre
orelhas-de-pau
orgulhosos
ossos
ostentosos
ouriços-cacheiros
ouriços-do-mar
ourives
ovos
padre-nossos
pais-nossos
palavrosos
paludosos
pan-americanismos
pan-americanos
pan-arabismos
pâncreas
pantanosos
pães-duros
papa-arrozes
papa-bananas
papa-capins
papa-figos
papa-peixes
papa-terras
papa-ventos
papéis-alumínio
papéis-carbono
papéis-moeda
papos-furados
para-brisas
para-choques
para-lamas
para-raios
parcimoniosos
pares
passa-anéis
pastosos
patas-chocas
pataxós-hã-hã-hães
paus
paus-brasis
paus-d
paus
paus-ferro
paus-para-tudo
paus-rosa
pavorosos
pecaminosos
pés-d
pés-de-meia
pés-de-pau
pés-direitos
pedras-ímãs
pedras-pomes
pedras-sabão
pedras-umes
pedregosos
pedrosos
pés-frios
pegajosos
pegas-pegas
pega-rapazes
peixes-boi
peixes-cobra
peixes-elétricos
peixes-voadores
peles-vermelhas
peluginosos
pélvis
pênis
penosos
pentes-finos
penumbrosos
penuriosos
pés-quebrados
pequenos-burgueses
pés-quentes
pés-rapados
perde-ganha
perfumosos
perigosos
perniciosos
pesarosos
pias-máteres
pica-paus
pica-paus-amarelos
pickups
piedosos
piegas
pife-pafes
pilosos
pilotos
pimentas-do-reino
pimentas-malagueta
do
pingos-d
pingue-pongues
pinheiros-do-paraná
piolhos-de-cobra
pires
pisa-mansinho
pisca-piscas
piscosos
placas-mãe
pobres-diabos
poços
poderosos
põe-mesas
polens
pombas-rolas
pombos-correio
pomes
pomposos
ponderosos
pontas-direitas
pontas-esquerdas
pontas-secas
populosos
porcos
porcos-do-mato
porcos-espinho
porfiosos
porosos
porquinhos-da-índia
porta-agulhas
porta-aviões
porta-bagagens
porta-bandeiras
porta-chapéus
porta-chaves
porta-estandartes
porta-joias
porta-lápis
porta-luvas
porta-malas
porta-moedas
porta-níqueis
porta-retratos
porta-toalhas
porta-vozes
portentosos
portos
porto-alegrenses
portos-francos
porto-riquenhos
porto-riquenses
porto-velhenses
pós-datas
pós-diluvianos
pós-dorsais
pós-escritos
pós-glaciais
pós-graduações
pós-graduados
pós-guerras
pós-operatórios
pospostos
postas-restantes
pôsteres
postos
poucas-vergonhas
poucos-casos
povos
praças-fortes
pratos-feitos
prazerosos
pré-antepenúltimos
pré-cabralinos
Pré-Cambrianos
preciosos
pré-colombianos
pré-coloniais
preconceituosos
pré-datados
predispostos
pré-eleitorais
pré-escolas
pré-escolares
pré-estreias
pré-fabricados
pré-franqueados
pré-glaciais
preguiçosos
pré-histórias
pré-históricos
pré-incaicos
pré-lançamentos
pré-menstruais
pré-molares
pré-natais
pré-nupciais
pré-operatórios
prepostos
pré-primários
pressagiosos
pressupostos
pressurosos
prestes
prestigiosos
prestimosos
presunçosos
pretensiosos
pré-vestibulares
primas-donas
primeiras-damas
primeiros-ministros
primorosos
procelosos
prodigiosos
prontos-socorros
própolis
proto-histórias
proto-históricos
proveitosos
pruriginosos
púbis
públicas-formas
pundonorosos
puros-sangues
pustulosos
puxa-puxas
puxa-sacos
quadros-negros
quanta
quartas-feiras
quartéis-generais
quebra-cabeças
quebra-cocos
quebra-galhos
quebra-gelos
quebra-luzes
quebra-mares
quebra-nozes
quebra-paus
quebra-pedras
quebra-quebras
quebra-ventos
quedas-d
queixosos
quero-queros
quilowatts-hora
químicos-industriais
quinta-colunas
quinta-essências
quintas-feiras
quizzes
rabos-de-palha
racemosos
radicosos
radiosos
raigotosos
raivosos
ramalhosos
ramosos
rancorosos
rançosos
ranhosos
recém-casados
recém-formados
recém-nascidos
receosos
recompostos
reco-recos
reforços
refrões
regras-três
reles
religiosos
relvosos
remelosos
rendosos
renovos
repórteres
répteis
resinosos
respeitosos
resplendorosos
restolhos
reto-romanches
retroses
revoltosos
ribeirão-pretanos
rigorosos
rio-branquenses
rio-grandenses-do-norte
rio-grandenses-do-sul
rixosos
rochosos
rodas-gigantes
rodas-vivas
roletas-russas
rosa-cruzes
rostos
roupas-velhas
ruges-ruges
rugosos
ruidosos
ruinosos
rumorosos
sabe-tudo
saborosos
saburrosos
saca-rolhas
saca-trapos
sacis-pererês
sacos-rotos
sacristãos
saias-balão
saias-calças
saias-justas
saibrosos
salários-família
salários-mínimos
sais-gemas
salitrosos
salsuginosos
salva-vidas
salve-rainhas
salvo-condutos
sambas-canção
sambas-enredo
sangues-frios
santas-bárbaras
santa-catarinenses
santa-helenenses
santas-marias
são-bernardos
são-luisenses
são-tomés
são-tomenses
sapos-cururu
saterés-maués
saudosos
sebosos
sediciosos
sedimentosos
sedosos
segundas-feiras
seguros-desempregos
sem-cerimônias
sêmens
sem-fins
semianalfabetos
semianuais
semianulares
semiáridos
semi-internatos
semi-internos
semimortos
semipreciosos
sem-nome
sem-números
sempre-verdes
sempre-vivas
sem-sal
sem-terra
sem-teto
sem-vergonha
sem-vergonhices
seniores
sentenciosos
sequiosos
serosos
serra-leoneses
seus
sextas-feiras
sigilosos
silenciosos
simples
sinhás-moças
sinuosos
sírio-libaneses
sobre-humanos
sobrepostos
sobrolhos
socorros
sofás-cama
sombrosos
somenos
sonorosos
sub-raças
sub-repções
sub-reptícios
sub-rogações
sub-rogados
sub-rogadores
sub-rogantes
substanciosos
sul-africanos
sul-americanos
sul-coreanos
sulfurosos
sul-mato-grossenses
sul-rio-grandenses
suntuosos
super-heróis
super-homens
súpero-exteriores
súpero-interiores
supersticiosos
supostos
surdo-mudezes
surdos-mudos
suspeitosos
suspirosos
tabeliães
tabes
talcosos
talha-frios
tamanduás-bandeiras
tamanduás-coletes
taninosos
tapa-bocas
tapa-buracos
tapa-olhos
tartaruguinhas-da-amazônia
tatus-bolas
tatus-canastra
teco-tecos
te-déuns
tediosos
teimosos
telhas-vãs
temerosos
tempestuosos
tempos-quentes
tendenciosos
tenebrosos
tenentes-brigadeiros
tenentes-coronéis
terças-feiras
terceiros-sargentos
terras-novas
terrosos
teus
teuto-brasileiros
têxteis
tias-avós
tico-ticos
tiés-sangue
tifosos
tijolos
tinguis-botós
tinhosos
tios-avós
tique-taques
tira-dúvidas
tira-gostos
tira-linhas
tira-manchas
tira-prosas
tira-teimas
tira-teimas
toca-discos
toca-fitas
todo-poderosos
tô-fracos
tomentosos
toque-toques
tormentosos
torna-viagens
tortos
tortuosos
totens
trabalhosos
transpostos
traquinas
trava-línguas
trepa-trepas
três-setes
trincas-ferro
trinitário-tobaguenses
trombas-d
tsé-tsés
vós
tuberculosos
tuberosos
tudo-nadas
tumultuosos
tupis-guaranis
uaimiris-atroaris
ulcerosos
ultrajosos
ultravioleta
umbrosos
umbus-cajás
umbu-cajazeiros
unissex
untuosos
vacas-frias
vacas-pretas
vade-mécuns
vaga-lumes
vagarosos
vaidosos
vaimiris-atroaris
vales-refeições
vales-transportes
vale-tudo
valiosos
valorosos
vangloriosos
vantajosos
vaporosos
varicosos
variolosos
veludosos
venenosos
venosos
ventosos
venturosos
verbosos
verde-amarelos
verde-olivas
vergonhosos
verrucosos
verrugosos
vertiginosos
vesiculosos
vias-crúcis
vias-sacras
vice-almiran-tados
vice-almirantes
vice-campeões
vice-campeonatos
vice-chanceleres
vice-cônsules
vice-diretores
vice-governadores
vice-prefeitos
vice-presidências
vice-presidentes
vice-reis
vice-reinados
vice-reitores
viciosos
viçosos
vigorosos
vinhas-d
violetas-tricolores
vira-bostas
vira-casacas
vira-latas
virtuosos
vírus
viscerosos
viscosos
vistosos
vitórias-régias
vitoriosos
viúvas-negras
volumosos
voluntariosos
voluptuosos
volutuosos
voraginosos
vultosos
vultuosos
vurmosos
watts-hora
watt-horímetros
watts-segundo
xaroposos
xelins
xeques-mates
xerox
xique-xiques
xistosos
xucurus-cariris
zás-trás
zelosos
zen
zen-budismos
zés-ninguém
zé-pereiras
zé-povinhos
zero-quilômetro
```
