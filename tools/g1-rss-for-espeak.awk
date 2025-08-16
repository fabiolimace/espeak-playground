#!/bin/awk -f

#
# Formata o arquivo Record-Jar gerado pelo `g1-rss-downloader.sh` para leitura do `espeak-ng`.
#
# Como usar:
#
#      awk -f g1-rss-for-espeak.awk g1.globo.com-*.record-jar | espeak-ng -v pt-br
#      awk -f g1-rss-for-espeak.awk g1.globo.com-*.record-jar | awk -f line-breaker.awk | espeak-ng -v pt-br
#

BEGIN {
	LINK_REGEX=LINK_REGEX ? LINK_REGEX : "(mundo|economia|politica)";
}

function get() {
	gsub(/\\n/, "\n");
	sub(/^[^:]+:/,"");
	return $0;
}

function ready() {
	return LINK && DESCRIPTION;
}

function clear() {
	LINK=null;
	TITLE=null;
	SUBTITLE=null;
	DESCRIPTION=null;
}

function output() {
	printf "\n\nA PRÓXIMA NOTÍCIA.\n\n";
	print TITLE "\n";
	print SUBTITLE "\n";
	print DESCRIPTION "\n";
	clear();
}

/^LINK:/ {
	if ($0 ~ LINK_REGEX) LINK=$0; else clear();
}

/^TITLE:/ {
	TITLE=get();
}

/^SUBTITLE:/ {
	SUBTITLE=get();
}

/^DESCRIPTION:/ {
	DESCRIPTION=get();
}

{
	if (ready()) output();
}

