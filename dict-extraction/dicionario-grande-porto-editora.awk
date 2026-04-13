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

	if (word !~ /(ã|[aâ][nm][bcdfgjklmnpqrstvxzç]|em$|ens$|ões$)/) return pronunciation;

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

	split("ch;lh;nh;rr;ss;sc;sç;xc;qu;gu;[eéê]n;[eéê]m;[ií]n;[ií]m;[oóô]n;[oóô]m;[uú]n;[uú]m", REPL, ";")
	if (word ~ /[aâ][nm][bcdfgjklmnpqrstvxzç]/) {

		match(word, /[aâ][nm][bcdfgjklmnpqrstvxzç]/);

		if (RSTART > 0)  {
			w1 = substr(word, 1, RSTART-1)
			w2 = substr(word, RSTART+2)
		}

		sub(/^h/, "", w1);

		for(i in REPL) {
			if (REPL[i] ~ "(sc|xc|gu|qu)") { sub(REPL[i] "[eéêií]", "..", w1); sub(REPL[i] "[eéêií]", "..", w2); }
			else if (REPL[i] ~ ".[nm]") { sub(REPL[i] "[bcdfgjklmnpqrstvxzç]", "..", w1); sub(REPL[i] "[bcdfgjklmnpqrstvxzç]", "..", w2); }
			else { sub(REPL[i], ".", w1); sub(REPL[i], ".", w2); }
		}

		pronunciation_for_length = pronunciation
		sub(/ˈ/, "", pronunciation_for_length); # remove prime
		sub(/ɐ̃w̃/, "ɐw", pronunciation_for_length); # remove tilde
		sub(/ɐ̃j̃/, "ɐj", pronunciation_for_length); # remove tilde
		if ( length(pronunciation_for_length) == length( w1 w2 ) ) {
		
			if (substr(pronunciation, 1, length(w1)) ~ /ˈ/) {
				pronunciation = substr(pronunciation, 1, length(w1) + 1) "ɐ̃" substr(pronunciation, length(w1) + 2);
			} else {
				if (word ~ /^[â][nm][bcdfgjklmnpqrstvxzç]/ && pronunciation ~ /^ˈ/) {
					pronunciation = "ˈ" "ɐ̃" substr(pronunciation, 2);
				} else {
					pronunciation = substr(pronunciation, 1, length(w1)) "ɐ̃" substr(pronunciation, length(w1) + 1);
				}
			}
		}
	}

	return pronunciation;
}

$1 ~ /^[[:alpha:].-]+$/ && $2 ~ /\[[^]]+\]/ && $3 ~ /([[:alnum:]]+\.)+/ {

	word=$1;
	pronunciation=$2;
	
	gsub(/[][]/, "", pronunciation);

	tags = null;
	if (word ~ /-se$/) {
		sub(/-se$/, "", word);
		sub(/sɨ$/, "", pronunciation);
		tags = "v.pron.";
	}
	for (i = 3; i <= NF; i++) {
		if ($i in TAGS && !index(";" tags ";", ";" $i ";")) tags = tags (tags ? ";" : "") $i;
	}

	pronunciation = fix_nasals(word, pronunciation);
	
	if (tags) print word, "[" pronunciation "]", tags;
}


