#!/usr/bin/gawk -f

# Extrai palavras do "Dicionário Global Escolar Silveira Bueno da Língua Portuguesa", de Silveira Bueno
# Este script gera um arquivo TSV de três colunas que contém apenas: as palavras, as silabações e as listas de classes gramaticais de cada palavra, separadas por ponto e vírgula.
#
# Exemplo de linhas geradas pelo script:
#
#   abstração	abs.tra.ção	s.f.
#   abstrair	abs.tra.ir	v.t.d.;v.p.
#   abstrato	abs.tra.to	adj.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="adj.;adj.2g.;adj.2g.2n.;adv.;art.;conj.;contr.prep.;interj.;num.;pref.;prep.;pron.dem.;pron.indef.;pron.inter.;pron.pos.;pron.rel.;pron.;s.2g.;s.2g.2n.;s.f.;s.f.2n.;s.f.pl.;s.m.;s.m.2n.;s.m.pl.;v.i.;v.impes.;v.lig.;v.p.;v.t.d.;v.t.d.i.;v.t.i.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];
}

{
	gsub(/Contração da preposição/, "contr.prep.");
	gsub(/pron\. dem\./, "pron.dem.");
	gsub(/pron\. indef\./, "pron.indef.");
	gsub(/pron\.ind\./, "pron.indef.");
	gsub(/pron\. inter\./, "pron.inter.");
	gsub(/pron\. pos\./,"pron.pos.");
	gsub(/pron\. rel\./,"pron.rel.");
	gsub(/v\. impes\./,"v.impes.");
	gsub(/v\. lig\./,"v.lig.");
}

$1 ~ /^[[:lower:]-]+$/ && $2 ~ /^\([[:lower:]]+(\.[[:lower:]]+)*\)$/ {

	word=$1;

	syllables=$2;
	gsub(/[()]/, "", syllables);

	tags = null;
	for (i = 2; i <= NF; i++) {
		if ($i in TAGS) tags = tags (tags ? ";" : "") $i;
	}

	if (tags) print word, syllables, tags;
}

