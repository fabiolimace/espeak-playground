#!/bin/bash

#
# Este script baixa o RSS do site G1 da Globo.
#
# Produz uma steam no formato de arquivo Record-Jar.
#
# O formato Record-Jar foi descrito no livro "The Art of Unix Programming", de Eric Steven Raymond.
#
# Existe um esboço da IETF que tentou padronizar o Record-Jar: https://datatracker.ietf.org/doc/html/draft-phillips-record-jar
#

RSS_URL=https://g1.globo.com/rss/g1/

# Download the XML
wget -q -O- "${RSS_URL}" \
| sed -E 's/^[ ]+//;s/[ ]+$//;s/[ ]+/ /g;' \
| tr -s '\n' '\r' | sed -E 's/\r/\\n/g' \
| sed -E 's|<item>|\n&|g;s|</item>|&\n|g' \
| grep -E -o '^<item>.*</item>$' \
| sed -E 's#<(title|link|pubDate|description|atom:subtitle)>#\n&#g' \
| sed -E 's#</(title|link|pubDate|description|atom:subtitle)>#&\n#g' \
| grep -E '^<(item|title|link|pubDate|description|atom:subtitle)>' \
| sed -E 's|[ ]*<!\[CDATA\[.*\]\]>[ ]*||' \
| sed -E 's|^<item>|%%|' \
| sed -E 's|^<link>|LINK: |' \
| sed -E 's|^<title>|TITLE: |' \
| sed -E 's|^<pubDate>|PUBDATE: |' \
| sed -E 's|^<atom:subtitle>|SUBTITLE: |' \
| sed -E 's|^<description>|DESCRIPTION: |' \
| sed -E 's#</(item|title|link|pubDate|description|atom:subtitle)>$##' \

