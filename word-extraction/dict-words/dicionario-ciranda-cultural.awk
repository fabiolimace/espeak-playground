#!/usr/bin/gawk -f

#
# Extrai palavras do "Minidicionário Escolar Língua Portuguesa", da Ciranda Cultural.
# Este script gera um arquivo TSV de três colunas que contém apenas: as palavras, as silabações e as listas de classes gramaticais de cada palavra, separadas por ponto e vírgula.
#
# Exemplo de linhas geradas pelo script:
#
#   abstração	abs.tra.ção	s.f.
#   abstrair	abs.tra.ir	v.t.d.;v.p.
#   abstrato	abs.tra.to	adj.;s.m.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="adj.;adj.2gên.;adv.;art.def.fem.;art.def.masc.;art.indef.fem.;art.indef.masc.;conj.;contr.prep.;interj.;loc.adj.;loc.adv.;loc.lat.;loc.prep.;num.;part.irreg.;pref.;prep.;pron.;pron. dem.;pron.indef.;pron.pess.;pron.poss.;pron.rel.;s.2gên.;s.f.;s.f.pl.;s.m.;s.m.pl.;suf.adv.;sup.abs.;v.impess.;v.i.;v.lig.;v.p.;v.t.d.;v.t.d.i.;v.t.i.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];
}

{
	gsub(/contr\. da prep\./, "contr.prep.");
	gsub(/art\. def\. fem\./, "art.def.fem.");
	gsub(/art\. def\. masc\./, "art.def.masc.");
	gsub(/art\. indef\. fem\./, "art.indef.fem.");
	gsub(/art\. indef\. masc\./, "art.indef.masc.");
	gsub(/loc\. adj\./, "loc.adj.");
	gsub(/loc\. adv\./, "loc.adv.");
	gsub(/loc\. lat\./, "loc.lat.");
	gsub(/loc\. prep\./, "loc.prep.");
	gsub(/part\. irreg\./, "part.irreg.");
	gsub(/pron\. dem\./, "pron.dem.");
	gsub(/pron\. indef\./, "pron.indef.");
	gsub(/pron\. pess\./, "pron.pess.");
	gsub(/pron\. poss\./, "pron.poss.");
	gsub(/pron\. rel\./, "pron.rel.");
	gsub(/s.f\. pl\./, "s.f.pl.");
	gsub(/s.m\. pl\./, "s.m.pl.");
	gsub(/suf\. adv\./, "suf.adv.");
	gsub(/sup\. abs\./, "sup.abs.");
	gsub(/v\. impess\./, "v.impess.");
	
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

