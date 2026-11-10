Wiktionary
==================================

Extract word pronunciations from Wiktionary dump.

Dump file downloaded from: https://dumps.wikimedia.org/other/mediawiki_content_current/ptwiktionary/

Generate a Record-Jar file:

	awk -f wiktionary.awk download/ptwiktionary-2026-11-01-p2p707144.xml > wiktionary.record-jar

Generate a JSON file:

	awk -f wiktionary.awk download/ptwiktionary-2026-11-01-p2p707144.xml | awk -f ~/git/espeak-playground/tools/record-jar.awk -v FORMAT=json > wiktionary.json

Generate a TSV file:

	awk -f wiktionary.awk download/ptwiktionary-2026-11-01-p2p707144.xml | awk -f ~/git/espeak-playground/tools/record-jar.awk -v FORMAT=tsv > wiktionary.tsv

