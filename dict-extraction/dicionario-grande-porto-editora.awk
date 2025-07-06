#!/usr/bin/gawk -f

# Extrai palavras do "Grande Dicionário da Língua Portuguesa da Porto Editora", da Porto Editora.
# Este script gera um arquivo TSV de três colunas que contém apenas: as palavras, as pronúncias e as listas de classes gramaticais de cada palavra, separadas por ponto e vírgula.
#
# OBSERVAÇÃO: as pronúncias das palavras que contém a vogal /ã/ (ã, an, am, ân, âm) estão incompletas, pois a editora usou imagens em vez de caracteres para representar esses sons.
#
# Exemplo de linhas geradas pelo script:
#
#   abstração	[ɐb∫traˈs]	s.f.	// note a ausência do ditongo na pronúncia (o script tentará corrigir casos como este)
#   abstracto	[ɐb∫ˈtratu]	adj.
#   abstrair	[ɐb∫trɐˈir]	v.tr.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="abrev.;adj.;adj.2g.;adj.2g.2n;adv.;art.;art.def.;art.indef.;conj.;contr.;contr.prep.;elem.loc.;interj.;loc.;loc.adj.;loc.adv.;loc.conj.;loc.interj.;loc.prep.;loc.v.;num.card.;num.mult.;num.frac.;num.ord.;prep.;pron.;pron.dem.;pron.indef.;pron.int.;pron.pes.;pron.pos.;pron.rel.;s.2g.;s.m.;s.m.2n.;s.m.pl.;s.f.;s.f.2n.;s.f.pl.;v.;v.pron.;v.tr.;v.intr.;sig.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];

	NASAL_ENDINGS["ã"]="ɐ̃"
	NASAL_ENDINGS["ão"]="ɐ̃w"
	NASAL_ENDINGS["ãe"]="ɐ̃j"
	NASAL_ENDINGS["ãs"]="ɐ̃∫"
	NASAL_ENDINGS["em"]="ɐ̃j"
	NASAL_ENDINGS["ãos"]="ɐ̃w∫"
	NASAL_ENDINGS["ães"]="ɐ̃j∫"
	NASAL_ENDINGS["ões"]="õj∫"
	NASAL_ENDINGS["ens"]="ɐ̃j∫"
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

# tries to fix as many nasals as possible
function fix_nasals(word, pronunciation) {

	if (word !~ /(ã|[aâ][nm][^aáâãeéêiíoóôõuú]|em$|ens$)/) return pronunciation;

	gsub(/[][]/, "", pronunciation);
	
	for (i in NASAL_ENDINGS) {
		if (word ~ i "$" && pronunciation !~ NASAL_ENDINGS[i] "$") {
			if (word ~ /s$/) sub(/∫$/, "", pronunciation);
			if (word ~ /ões$/) sub(/õ∫$/, "", pronunciation);
			if (word ~ /em$/) sub(/ɐ$/, "", pronunciation);
			if (word ~ /ens$/) sub(/∫$/, "", pronunciation);
			if (pronunciation ~ /εm∫?$/) break; # modem, siemens
			pronunciation = pronunciation NASAL_ENDINGS[i];
			break;
		}
	}
	
	if (word ~ /^â[nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = "ˈɐ̃" substr(pronunciation, 2);
		else pronunciation = "ɐ̃" pronunciation;
	} else if (word ~ /^a[nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/); # the accent is ambiguous in this case
		else pronunciation = "ɐ̃" pronunciation;
	} else if (word ~ /^[^h][aâ][nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?.[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = substr(pronunciation, 1, 2) "ɐ̃" substr(pronunciation, 3);
		else pronunciation = substr(pronunciation, 1, 1) "ɐ̃" substr(pronunciation, 2);
	} else if (word ~ /^[^h].[aâ][nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?..[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = substr(pronunciation, 1, 3) "ɐ̃" substr(pronunciation, 4);
		else pronunciation = substr(pronunciation, 1, 2) "ɐ̃" substr(pronunciation, 3);
	}
	
	return "[" pronunciation "]";
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
	
	pronunciation = fix_nasals(word, pronunciation);
	
	if (tags) print word, pronunciation, tags;
}


