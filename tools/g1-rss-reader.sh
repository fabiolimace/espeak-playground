#!/bin/bash

#
# Este script lê em voz alta o feed RSS do site G1 da Globo.
#
# MODO DE USAR
#
#    g1-rss-reader.sh                                   # usando a voz padrão do espeak
#    g1-rss-reader.sh mb-br1                            # usando a primeira voz masculina do MBrola
#    g1-rss-reader.sh pt-br "(mundo|economia|politica)" # usando a voz padrão e selecionando as palavras que devem existir na URL
#

VOICE="${1-pt-br}";
LINK_REGEX="${2-(mundo|economia|politica)}";

BASEDIR=`dirname $0`

awk -f "${BASEDIR}/g1-rss-for-espeak.awk" -v "LINK_REGEX=${LINK_REGEX}" <("${BASEDIR}/g1-rss-downloader.sh") | while read line; do echo $line; espeak-ng -v ${VOICE} "$line"; done;

