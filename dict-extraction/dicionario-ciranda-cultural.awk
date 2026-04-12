#!/usr/bin/gawk -f

#
# Extrai palavras do "Minidicionário Escolar Língua Portuguesa", da Ciranda Cultural.
# Este script gera um arquivo TSV de três colunas que contém apenas: as palavras, as silabações e as listas de classes gramaticais de cada palavra, separadas por ponto e vírgula.
#
# Exemplo de linhas geradas pelo script:
#
#   abstração	abs.tra.ção	s.f.
#   abstrair	abs.tra.ir	v.t.d.;v.pron.
#   abstrato	abs.tra.to	adj.;s.m.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="adj.;adj.2g.;adv.;art.def.f.;art.def.m.;art.indef.f.;art.indef.m.;conj.;contr.prep.;interj.;loc.adj.;loc.adv.;loc.lat.;loc.prep.;num.;part.irreg.;pref.;prep.;pron.;pron.dem.;pron.indef.;pron.int.;pron.pes.;pron.pos.;pron.rel.;s.2g.;s.f.;s.f.pl.;s.m.;s.m.pl.;suf.;suf.adv.;v.impes.;v.i.;v.lig.;v.pron.;v.t.d.;v.t.d.i.;v.t.i.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];
}

{
	gsub(/contr\. da prep\./, "contr.prep.");
	gsub(/[Cc]ontração da prep\./, "contr.prep.");
	gsub(/adj\. ?2 ?gên\./, "adj.2g.");
	gsub(/art\. ?def\. ?fem\./, "art.def.f.");
	gsub(/art\. ?def\. ?masc\./, "art.def.m.");
	gsub(/art\. ?indef\. ?fem\./, "art.indef.f.");
	gsub(/art\. ?indef\. ?masc\./, "art.indef.m.");
	gsub(/loc\. ?adj\./, "loc.adj.");
	gsub(/loc\. ?adv\./, "loc.adv.");
	gsub(/loc\. ?lat\./, "loc.lat.");
	gsub(/loc\. ?prep\./, "loc.prep.");
	gsub(/part\. ?irreg\./, "part.irreg.");
	gsub(/pron\. ?dem\./, "pron.dem.");
	gsub(/pron\. ?ind\./, "pron.indef.");
	gsub(/pron\. ?indef\./, "pron.indef.");
	gsub(/pron\. ?inter\./, "pron.int.");
	gsub(/pron\. ?pess\./, "pron.pes.");
	gsub(/pron\. ?poss\./, "pron.pos.");
	gsub(/pron\. ?rel\./, "pron.rel.");
	gsub(/pron\. ?relat\./, "pron.rel.");
	gsub(/s\. ?f\./, "s.f.");
	gsub(/s\. ?m\./, "s.m.");
	gsub(/s\.f\. ?pl\./, "s.f.pl.");
	gsub(/s\.m\. ?pl\./, "s.m.pl.");
	gsub(/s\. ?2 ?gên\./, "s.2g.");
	gsub(/suf\. ?adv\./, "suf.adv.");
	gsub(/v\. ?impess\./, "v.impes.");
	gsub(/v\. ?p\./, "v.pron.");
	
}

$1 ~ /^[[:upper:]]+(\.[[:upper:]]+)*$/ {

	$1 = tolower($1);

	word=$1;
	gsub(/\./, "", word);

	syllables=$1;

	tags = null;
	for (i = 2; i <= NF; i++) {
		if ($i in TAGS) tags = tags (tags ? ";" : "") $i;
	}

	if (tags) print word, syllables, tags;
}

