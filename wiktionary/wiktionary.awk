#!/usr/bin/mawk -f

# 
# Extract phonetic representation of words from Portuguese Wiktionary.
#
# The output stream is a Record-Jar file.
# 

BEGIN {
	separator = "%%"
}

function clear() {

	title=null;
	parsing_page=0;
	parsing_text=0;
	parsing_pron=0;
	parsing_pron_br=0;
	parsing_pron_pt=0;
	dialect=null; # Brazilian dialects only

	for (i in pron) {
		delete pron[i];
	}
}

function prop(name, value) {
	return name ": " value;
}

function sanitize(str) {
	gsub(/\t/, "", str); # remove tabs
	gsub(/''/, "", str); # remove italic
	return str;
}

function write() {
	if (title) {
		if (length(pron)) {
		        print "\n" separator;
			print prop("WORD", title);
			for (i in pron) {
				pron[i]=sanitize(pron[i]);
				if (pron[i]) print prop(i, pron[i]);
			}
		}
	}
}

function trim(str) {
	sub(/^[ ]+/, "", str);
	sub(/[ ]+$/, "", str);
	return str;
}

function strip(str, tag) {
	gsub("<[/]?" tag ">", "", str);
	return str;
}

function extract_pron(str) {

	# {{AFI|/STRING/}} or {{AFI|[STRING]}}
	match(str, /\{\{AFI\|(\/[^/]+\/|\[[^]]+\])\}\}/);
	if (RSTART) {
		return substr(str, RSTART+6, RLENGTH-8);
	}

	# {{AFI2|pt|/STRING/}} or {{AFI2|pt|[STRING]}}
	match(str, /\{\{AFI2\|pt\|(\/[^/]+\/|\[[^]]+\])\}\}/);
	if (RSTART) {
		return substr(str, RSTART+10, RLENGTH-12);
	}



	# /STRING/
	match(str, /\/[^/]+\//);
	if (RSTART) {
		return substr(str, RSTART, RLENGTH);
	}
}

/^[ ]+<page/ {
	parsing_page=1;
	clear();
	next;
}

/<\/page>$/ {
	parsing_page=0;
	write();
	next;
}

/^[ ]+<text/ {
	parsing_text=1;
	next;
}

/<\/text>$/ {
	parsing_text=0;
	next;
}

/^[ ]+<title>.*<\/title>$/ {
	title=trim(strip($0, "title"));
	next;
}

/^[ ]+<ns>.*<\/ns>$/ {
	ns=trim(strip($0, "ns"));
	if (ns != 0) {
		clear(); # ignore other namespaces
	}
	next;
}

parsing_text && /^==[ ]?(\{\{)?[Pp]ronúncia(\|pt)?(\}\})?[ ]?==$/ {
	parsing_pron=1;
	parsing_pron_pt=0;
	parsing_pron_br=0;
	next;
}

parsing_pron && /^={1,2}[^=]/ {
	parsing_pron=0;
	parsing_pron_pt=0;
	parsing_pron_br=0;
	dialect=null;
	next;
}

parsing_pron && /^===[ ]?(Portugal|Portuguesa)[ ]?===$/ {
	parsing_pron_br=0;
	parsing_pron_pt=1;
	dialect=null;
	next;
}

parsing_pron && /^===[ ]?(Brasil|Brasileira)[ ]?===$/ {
	parsing_pron_br=1;
	parsing_pron_pt=0;
	dialect=null;
	next;
}

parsing_pron_br && /^====[^=]+====$/ {
	gsub(/=+/,"");
	dialect=$0;
	next;
}

parsing_pron_pt && !dialect && (/\{\{AFI\|\/[^/]+\/\}\}/ || /\{\{AFI2\|pt\|\/[^/]+\/\}\}/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["PT"]=extract_pron($0);
		next;
	}
}

parsing_pron_pt && !dialect && (/AFI:/ || /\[\[AFI\]\]:/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["PT"]=extract_pron($0);
		next;
	}
}

parsing_pron_br && !dialect && (/\{\{AFI\|\/[^/]+\/\}\}/ || /\{\{AFI2\|pt\|\/[^/]+\/\}\}/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["BR"]=extract_pron($0);
		next;
	}
}

parsing_pron_br && !dialect && (/AFI:/ || /\[\[AFI\]\]:/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["BR"]=extract_pron($0);
		next;
	}
}

parsing_pron && (!parsing_pron_pt && !parsing_pron_br) && !dialect && (/\{\{AFI\|\/[^/]+\/\}\}/ || /\{\{AFI2\|pt\|\/[^/]+\/\}\}/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["UNDEFINED"]=extract_pron($0);
		next;
	}
}

parsing_pron && (!parsing_pron_pt && !parsing_pron_br) && !dialect && (/AFI:/ || /\[\[AFI\]\]:/) {
	# avoid scoped lines
	if (!/\{\{escopo2/) {
		pron["UNDEFINED"]=extract_pron($0);
		next;
	}
}

parsing_pron_br && !dialect && /\{\{escopo2/ {

	if (/[Bb]a[h]ia(n[ao])?/) {
		pron["BR_BAIANA"]=extract_pron($0);
	}

	if (/[Cc]aipira/) {
		pron["BR_CAIPIRA"]=extract_pron($0);
	}

	if (/[Cc]arioca/) {
		pron["BR_CARIOCA"]=extract_pron($0);
	}

	if (/[Mm]inas [Gg]erais/) {
		pron["BR_MINEIRA"]=extract_pron($0);
	}

	if (/[Pp]aulista(n[ao])?/) {
		pron["BR_PAULISTA"]=extract_pron($0);
	}

	if (/Rio de Janeiro/) {
		pron["BR_CARIOCA"]=extract_pron($0);
	}

	if (/[Rr]egião [Nn]orte/) {
		pron["BR_NORTISTA"]=extract_pron($0);
	}

	if (/[Rr]egião [Nn]ordeste/) {
		pron["BR_NORDESTINA"]=extract_pron($0);
	}

	if (/[Rr]egião [Ss]udeste/) {
		pron["BR_SUDESTINA"]=extract_pron($0);
	}

	if (/[Rr]egião [Ss]ul/) {
		pron["BR_SULISTA"]=extract_pron($0);
	}

	if (/São Paulo/) { # Estado
		pron["BR_PAULISTA"]=extract_pron($0);
	}

	next;
}

parsing_pron_br && dialect && (/AFI:/ || /\[\[AFI\]\]:/) {

	if (dialect ~ /[Cc]aipira/) {
		pron["BR_CAIPIRA"]=extract_pron($0);
	}

	if (dialect ~ /[Cc]arioca/) {
		pron["BR_CARIOCA"]=extract_pron($0);
	}

	if (dialect ~ /[Pp]aulista(n[ao])?/) {
		pron["BR_PAULISTA"]=extract_pron($0);
	}

	if (dialect ~ /[Pp]aranaense/) {
		pron["BR_PARANAENSE"]=extract_pron($0);
	}

	if (dialect ~ /[Ss]ulista/) {
		pron["BR_SULISTA"]=extract_pron($0);
	}

	next;
}

END {
}
