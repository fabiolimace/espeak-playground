#!/usr/bin/gawk -f

# Extrai palavras do "Grande Dicionário da Língua Portuguesa da Porto Editora", da Porto Editora.
# Este script gera um arquivo TSV de três colunas que contém apenas: as palavras, as pronúncias e as listas de classes gramaticais de cada palavra, separadas por ponto e vírgula.
#
# OBSERVAÇÃO: as pronúncias das palavras que contém a vogal /ã/ (ã, an, am, ân, âm) estão incompletas, pois a editora usou imagens em vez de caracteres para representar esses sons.
#
# Exemplo de linhas geradas pelo script:
#
#   abstração	[ɐb∫traˈs]	s.f.	// note a ausência do ditongo na pronúncia
#   abstracto	[ɐb∫ˈtratu]	adj.
#   abstrair	[ɐb∫trɐˈir]	v.tr.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="abrev.;adj.;adj.2g.;adj.2g.2n;adv.;art.;art.def.;art.indef.;conj.;contr.;contr.prep.;elem.loc.;interj.;loc.;loc.adj.;loc.adv.;loc.conj.;loc.interj.;loc.prep.;loc.v.;num.card.;num.mult.;num.frac.;num.ord.;prep.;pron.;pron.dem.;pron.indef.;pron.int.;pron.pes.;pron.pos.;pron.rel.;s.2g.;s.m.;s.m.2n.;s.m.pl.;s.f.;s.f.2n.;s.f.pl.;v.;v.pron.;v.tr.;v.intr.;sig.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];
}

{
	gsub(/■/, "");
	gsub(/,/, " , ");
	gsub(/[()]/, "");
	gsub(/\//, " / ");
	gsub("sigla de", "sig.");
	gsub(/art\. def\./, "art.def.");
	gsub(/art\. indef\./, "art.indef.");
	gsub(/contr\. prep\./, "contr.prep.");
	gsub(/elem\. da expr\./, "elem.expr.");
}

/^ETIM./ {
	next;
}

$1 ~ /^[[:alpha:].-]+$/ && $2 ~ /\[[^]]+\]/ && $3 ~ /([[:alnum:]]+\.)+/ {

	word=$1;
	pronunciation=$2;

	tags = null;
	if (word ~ /(-se|\(-se\))$/) {
		gsub(/(-se|\(-se\))$/, "", word);
		tags = "v.pron.";
	}
	for (i = 3; i <= NF; i++) {
		if ($i in TAGS) tags = tags (tags ? ";" : "") $i;
	}
	
	if (tags) print word, pronunciation, tags;
}

