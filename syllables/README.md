Separate into syllables
==================================

Description
----------------------------------

The `separate-syllables-for-portuguese.awk` script separates words into syllables for Portuguese language.

Usage:

    # produces: in.cons.ti.tu.cio.na.lis.si.ma.men.te
    echo inconstitucionalissimamente | awk -f separate-syllables-for-portuguese.awk
    
    # split all words from a Linux dictionary
    awk -f separate-syllables-for-portuguese.awk /usr/share/dict/brazilian

This script can has a very low level of error or imprecision.

Demonstrations
----------------------------------

Separate into syllables the words from Linux dictionary:

```bash
cat /usr/share/dict/brazilian | awk -f separate-syllables-for-portuguese.awk | awk -f separate-syllables-for-portuguese.awk 2> /dev/null | shuf | head -n 10;
```
```
a.zu.le.ja.do
ben.zes.tes
bra.da.rá
ca.le.ja.rão
ca.mu.fla.res
de.sau.to.ri.za.ram
e.ri.ças.se
ou.çais
ra.ci.o.ci.ná.ra.mos
trans.mi.tais
```

Separate into syllables the words from Linux dictionary and then count the frequencies of every syllable:

```bash
cat /usr/share/dict/brazilian | awk -f separate-syllables-for-portuguese.awk  2> /dev/null \
    | awk '{ for (i = 1; i <= NF; i++) { split($i, sy, "."); for (s in sy) list[sy[s]]++ } } END { for (s in list) { print list[s] "\t" s } }' \
    | sort -nr | head -n 10;
```
```
56858	a
32845	mos
32199	re
23264	ra
23154	ri
21083	mo
20686	ta
19823	de
17463	ti
16933	ca
```

Separate into syllables the words from Linux dictionary and then count the frequencies of every pair of syllables (bigrams):

```bash
cat /usr/share/dict/brazilian | awk -f separate-syllables-for-portuguese.awk  2> /dev/null | awk '{ for (i = 1; i <= NF; i++) { n = split($i, sy, "."); for (j = 1; j < n; j++) list[sy[j] "." sy[j+1]]++ } } END { for (s in list) { print list[s] "\t" s } }' | sort -nr | head -n 10;
```
```
5238	a.mos
5081	ri.a
4560	ri.as
4527	re.mo
4330	ra.mos
4284	re.mos
4141	se.mos
4067	ri.am
4057	rí.a
4054	rí.eis
```

