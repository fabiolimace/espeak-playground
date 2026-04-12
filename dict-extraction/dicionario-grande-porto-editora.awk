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
#   abstrair	[ɐb∫trɐˈir]	v.t.
#

BEGIN {
	OFS="\t";

	PARTS_OF_SPEECH="abrev.;adj.;adj.2g.;adj.2g.2n;adv.;art.;art.def.;art.indef.;conj.;contr.;contr.prep.;elem.loc.;elem.expr.;interj.;loc.;loc.adj.;loc.adv.;loc.conj.;loc.interj.;loc.prep.;loc.v.;num.card.;num.mult.;num.frac.;num.ord.;prep.;pron.;pron.dem.;pron.indef.;pron.int.;pron.pes.;pron.pos.;pron.rel.;s.2g.;s.m.;s.m.2n.;s.m.pl.;s.f.;s.f.2n.;s.f.pl.;v.;v.pron.;v.t.;v.i.;sig.";
	
	split(PARTS_OF_SPEECH, POS, /;/);
	for (x in POS) TAGS[POS[x]];

	# ɐ̃w̃ ɐ̃j̃ õj̃
	NASAL_ENDINGS["ã$"]="$;ɐ̃"
	NASAL_ENDINGS["ão$"]="$;ɐ̃w̃"
	NASAL_ENDINGS["ãe$"]="$;ɐ̃j̃"
	NASAL_ENDINGS["ãs$"]="∫$;ɐ̃∫"
	NASAL_ENDINGS["en$"]="ɐ?$;ɐ̃j̃"
	NASAL_ENDINGS["em$"]="ɐ?$;ɐ̃j̃"
	NASAL_ENDINGS["ém$"]="$;ɐ̃j̃"
	NASAL_ENDINGS["êm$"]="$;ɐ̃j̃"
	NASAL_ENDINGS["ens$"]="∫$;ɐ̃j̃∫"
	NASAL_ENDINGS["ãos$"]="∫$;ɐ̃w̃∫"
	NASAL_ENDINGS["ães$"]="∫$;ɐ̃j̃∫"
	NASAL_ENDINGS["ões$"]="õ∫$;õj̃∫"

	NASAL_ZINHOS["ãzinh"]="ˈziɲ;ɐ̃ˈziɲ"
	NASAL_ZINHOS["ãozinh"]="ˈziɲ;ɐ̃w̃ˈziɲ"
	NASAL_ZINHOS["ãezinh"]="ˈziɲ;ɐ̃j̃ˈziɲ"
	NASAL_ZINHOS["enzinh"]="ɐ?ˈziɲ;ɐ̃j̃ˈziɲ"
	NASAL_ZINHOS["õezinh"]="õˈziɲ;õj̃ˈziɲ"
}

{
	gsub(/■/, "");
	gsub(/,/, " , ");
	gsub(/[()]/, "");
	gsub(/\//, " / ");
	gsub("sigla de", "sig.");
	gsub(/art\. ?def\./, "art.def.");
	gsub(/art\. ?indef\./, "art.indef.");
	gsub(/contr\. ?prep\./, "contr.prep.");
	gsub(/elem\. da expr\./, "elem.expr.");
	gsub(/v\. ?tr\./, "v.t.");
	gsub(/v\. ?intr\./, "v.i.");
}

/^ETIM./ {
	next;
}

# tries to fix as many nasals as possible
function fix_nasals(word, pronunciation) {

	if (word !~ /(ã|[aâ][nm][^aáâãeéêiíoóôõuú]|em$|ens$|ões$)/) return pronunciation;

	gsub(/[][]/, "", pronunciation);
	
	for (i in NASAL_ENDINGS) { # ão- ãoz ãos
		split(NASAL_ENDINGS[i], NASAL_REPLACE, ";");
		if (word ~ i) {
			if (pronunciation ~ /εm∫?$/) break; # modem, siemens
			sub(NASAL_REPLACE[1], NASAL_REPLACE[2], pronunciation);
			break;
		}
	}

	for (i in NASAL_ZINHOS) {
		split(NASAL_ZINHOS[i], NASAL_REPLACE, ";");
		if (word ~ i) {
			sub(NASAL_REPLACE[1], NASAL_REPLACE[2], pronunciation);
			break;
		}
	}
	
	if (word ~ /^â[nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = "ˈɐ̃" substr(pronunciation, 2);
		else pronunciation = "ɐ̃" pronunciation;
	} else if (word ~ /^a[nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = "ˈɐ̃" substr(pronunciation, 2);
		else pronunciation = "ɐ̃" pronunciation;
	} else if (word ~ /^[^h][aâ][nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?.[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = substr(pronunciation, 1, 2) "ɐ̃" substr(pronunciation, 3);
		else pronunciation = substr(pronunciation, 1, 1) "ɐ̃" substr(pronunciation, 2);
	} else if (word ~ /^[^h].[aâ][nm][^aáâãeéêiíoóôõuú]/ && pronunciation !~ /^ˈ?..[ɐ̃ɐ]/) {
		if (pronunciation ~ /^ˈ/) pronunciation = substr(pronunciation, 1, 3) "ɐ̃" substr(pronunciation, 4);
		else pronunciation = substr(pronunciation, 1, 2) "ɐ̃" substr(pronunciation, 3);
	}
	
	split("ch;lh;nh;rr;ss;sc;sç;xc;qu;gu;[eéê]n;[eéê]m;[ií]n;[ií]m;[oóô]n;[oóô]m;[uú]n;[uú]m;c;g;s;x", REPL, ";")
	if (word ~ /[aâ][nm][^aáâãeéêiíoóôõuú]/) {

		match(word, /[aâ][nm][^aáâãeéêiíoóôõuú]/);

		w1 = substr(word, 1, RSTART-1)
		w2 = substr(word, RSTART+2)

		sub(/^h/, "", w1);

		for(i in REPL) {
			if (REPL[i] ~ "(sc|xc|gu|qu|c|g)") { sub(REPL[i] "[eéêií]", "..", w1); sub(REPL[i] "[eéêií]", "..", w2); }
			else { sub(REPL[i], ".", w1); sub(REPL[i], ".", w2); }
		}

		if (word ~ /[aâ][nm][^aáâãeéêiíoóôõuú]/) {
			if ( length(pronunciation) == length( w1 "ˈ" w2 ) ) {
				if ( pronunciation ~ "^" substr(w1, 1, length(w1)-1) "ˈ" ) {
					pronunciation = substr(pronunciation, 1, length(w1) + 1) "ɐ̃" substr(pronunciation, length(w1) + 2);
				} else if ( pronunciation ~ "ˈ" w2 "$" ) {
					pronunciation = substr(pronunciation, 1, length(w1)) "ɐ̃" substr(pronunciation, length(w1) + 1);
				}
			}
		}
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


