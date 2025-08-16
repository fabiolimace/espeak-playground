#!/bin/bash

#
# Este script baixa o RSS do site G1 da Globo.
#
# Produz dois arquivos:
#
# 1. Um arquivo XML o conteúdo inalterado;
# 2. Um arquivo Record-Jar gerado a partir do XML.
#
# Os nomes dos arquivos incluem as suas datas de geração.
#
# O formato Record-Jar foi descrito no livro "The Art of Unix Programming", de Eric Steven Raymond.
#
# Existe um esboço da IETF que tentou padronizar o Record-Jar: https://datatracker.ietf.org/doc/html/draft-phillips-record-jar
#

RSS_URL=https://g1.globo.com/rss/g1/
BASENAME=g1.globo.com

DATE=`date +"%F_%T"`;
XML_FILE="${BASENAME}-${DATE}.xml";
TXT_FILE="${BASENAME}-${DATE}.record-jar";

# Download the XML
wget -q -O- "${RSS_URL}" > "${XML_FILE}";

# Convert the XML into Record-Jar
cat "${XML_FILE}" \
| sed -E 's/^[ ]+//;s/[ ]+$//;s/[ ]+/ /g;' \
| tr -s '\n' '\r' | sed -E 's/\r/\\n/g' \
| sed -E 's|<item>|\n&|g;s|</item>|&\n|g' \
| grep -E -o '^<item>.*</item>$' \
| sed -E 's#<(title|link|pubDate|description|atom:subtitle)>#\n&#g' \
| sed -E 's#</(title|link|pubDate|description|atom:subtitle)>#&\n#g' \
| grep -E '^<(item|title|link|pubDate|description|atom:subtitle)>' \
| sed -E 's|^<item>|%%|' \
| sed -E 's|^<link>|LINK:|' \
| sed -E 's|^<title>|TITLE:|' \
| sed -E 's|^<pubDate>|PUBDATE:|' \
| sed -E 's|^<atom:subtitle>|SUBTITLE:|' \
| sed -E 's|^<description>|DESCRIPTION:|' \
| sed -E 's#</(item|title|link|pubDate|description|atom:subtitle)>$##' \
| sed -E 's|[ ]*<!\[CDATA\[.*\]\]>[ ]*||' \
> "${TXT_FILE}";

