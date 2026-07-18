#!/bin/bash

#
# Recebe um nome e gera uma lista de nomes modificados com base nele.
#
# Este script é útil para gerar uma lista de nomes parecidos com um dado nome.
#
# Por exemplo, as seguintes variações do nome "ana" podem ser geradas por este script: ane, anna, anne, anny e any.
#
# Modo de usar:
#
#     name-spelling-modifier.sh juliana
#

function transformar {
	echo $1 | tr '[[:upper:]]' '[[:lower:]]' | awk '\
	/(á|â)/ { t=$1; sub(/(á|â)/, "a", t); print t } \
	/(é|ê)/ { t=$1; sub(/(é|ê)/, "e", t); print t } \
	/í/ { t=$1; sub(/í/, "i", t); print t } \
	/(ó|ô)/ { t=$1; sub(/(ó|ô)/, "o", t); print t } \
	/(ú|ü)/ { t=$1; sub(/(ú|ü)/, "u", t); print t } \
	/[^aeiou]ea$/ { t=$1; sub(/ea$/, "eia", t); print t } \
	/[^aeiou]eia$/ { t=$1; sub(/eia$/, "ea", t); print t } \
	/[aeiou]m$/ { t=$1; sub(/m$/, "n", t); print t } \
	/[aeiou]n$/ { t=$1; sub(/n$/, "m", t); print t } \
	/[aeiou]nn$/ { t=$1; sub(/nn$/, "n", t); print t } \
	/^h[aeiouy].*/ { t=$1; sub(/^h/, "", t); print t } \
	/^[^w]*w[aeiouy].*/ { t=$1; sub(/w/, "v", t); print t } \
	/^[^v]*v[aeiouy].*/ { t=$1; sub(/v/, "w", t); print t } \
	/^[aeiouy].*/ { t=$1; sub(//, "h&", t); print t } \
	/^.*[aiì]n?na$/ { t=$1; sub(/na$/, "ne", t); print t } \
	/^.*[aiì]n?ne$/ { t=$1; sub(/ne$/, "na", t); print t } \
	/^.+[e]l?la$/ { t=$1; sub(/la$/, "le", t); print t } \
	/^.+[e]l?le$/ { t=$1; sub(/le$/, "la", t); print t } \
	/[^s]son$/ { t=$1; sub(/son$/, "sson", t); print t } \
	/^[^i]*i[^i]*/ { t=$1; sub(/i/, "y", t); print t } \
	/^[^y]*y[^y]*/ { t=$1; sub(/y/, "i", t); print t } \
	/^[^i]+ai[^i]+/ { t=$1; sub(/ai/, "ay", t); print t } \
	/^[^i]+ei[^i]+/ { t=$1; sub(/ei/, "ey", t); print t } \
	/^[^t]*t[aeiouy][^t]*/ { t=$1; sub(/t/, "th", t); print t } \
	/^[^t]*th[aeiouy][^t]*/ { t=$1; sub(/th/, "t", t); print t } \
	/^[^tln]+t[aeiouy]/ { t=$1; sub(/t/, "tt", t); print t } \
	/^[^ln]+tt[aeiouy]/ { t=$1; sub(/tt/, "t", t); print t } \
	/^[^l]+[^lnrs]+l[aeiouy]/ { t=$1; sub(/l/, "ll", t); print t } \
	/^[^lnrs]+ll[aeiouy]/ { t=$1; sub(/ll/, "l", t); print t } \
	/^[^n]+[^nlnrs]+n[aeiouy]/ { t=$1; sub(/n/, "nn", t); print t } \
	/^[^lnrs]+nn[aeiouy]/ { t=$1; sub(/nn/, "n", t); print t } \
	/^[^m]+[^mlnrs]+m[aeiouy]/ { t=$1; sub(/m/, "mm", t); print t } \
	/^[^lnrs]+mm[aeiouy]/ { t=$1; sub(/mm/, "m", t); print t } \
	/^[^ck]+c[aou]/ { t=$1; sub(/c/, "k", t); print t } \
	/^[^ck]+k[aou]/ { t=$1; sub(/k/, "c", t); print t } \
	/^[^ck]+ique$/ { t=$1; sub(/ique$/, "ick", t); print t } \
	/^[^ck]+ick$/ { t=$1; sub(/ick$/, "ique", t); print t } \
	/^[^ck]+[ck]$/ { t=$1; sub(/[ck]$/, "ck", t); print t } \
	/^[^ck]+ck$/ { t=$1; sub(/ck$/, "k", t); print t } \
	/^[^ck]+k$/ { t=$1; sub(/k$/, "c", t); print t } \
	/^[^s]+[aeiou]s[aeiou]/ { t=$1; sub(/s/, "z", t); print t } \
	/^[^z]+[aeiou]z[aeiou]/ { t=$1; sub(/z/, "s", t); print t } \
	/[aeouh]*ph/ { t=$1; sub(/ph/, "f", t); print t } \
	/[^aeouh]us$/ { t=$1; sub(/us$/, "o", t); print t } \
	/eth$/ { t=$1; sub(/eth$/, "ete", t); print t } \
	/ã$/ { t=$1; sub(/ã$/, "an", t); print t } \
	/^g[ei]o/ { t=$1; sub(/^g[ei]o/, "jo", t); print t } \
	/[aeiouy]sc[eiy]/ { t=$1; sub(/sc/, "c", t); print t } \
	/^.+[^aeiouy]e$/ { t=$1; sub(/e$/, "y", t); print t }';
}

function variator {
	echo "$1" && \
	transformar "$1";
	transformar "$1" | while read i; do transformar "$i"; done;
	transformar "$1" | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done;
	transformar "$1" | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done;
	transformar "$1" | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done | while read i; do transformar "$i"; done;
}

variator "$1" | sort | uniq;

