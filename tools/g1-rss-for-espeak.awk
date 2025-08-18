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
	return LINK && TITLE && DESCRIPTION;
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

/^TITLE:/ {
        clear();
	TITLE=get();
	next;
}

/^LINK:/ {
	if ($0 ~ LINK_REGEX) LINK=get();
	else clear();
	next;
}

/^SUBTITLE:/ {
	SUBTITLE=get();
	next;
}

/^DESCRIPTION:/ {
	DESCRIPTION=get();
	next;
}

{
	if (ready()) output();
}

