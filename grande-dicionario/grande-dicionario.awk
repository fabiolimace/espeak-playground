#!/usr/bin/mawk -f

#
# Produces a TSV that compares each Grande Dicionarios's entries with espeak-ng outputs.
#
# Based on and improved from `../aeiouado-ipa/aeiouado-ipa.awk`
#
# Usage:
# awk -f grande-dicionario.awk ../dict-extraction/PRIVATE/grande-dicionario.tsv | tee grande-dicionario.output.tsv
#
# EXPECTED INPUT:
# WORD	IPA1
# ABAIXA	[a.'bay.ʃə]
#
# PRODUCED OUTPUT:
# WORD	IPA1	IPA2	IPA3	IPA4	EQUALS
# abaixa	abayʃə	abaɪʃæ	aba[y]ʃ[ə]	aba[ɪ]ʃ[æ]	0
#
# FIELDS:
# * WORD: Grande Dicionarios's word
# * IPA1: Grande Dicionarios's IPA.
# * IPA2: eSpeak NG's IPA.
# * IPA3: Grande Dicionarios's IPA with brackets.
# * IPA4: eSpeak NG's IPA with brackets.
# * EQUALS: if IPA1 equals IPA2, then 1; otherwise 0.
#
# The brackets are used to highlight the differences between IPA3 and IPA4.
#

BEGIN {
    FS="\t";
    OFS="\t";
}

function max_length(a, b,    x, y) {
    x = length(a);
    y = length(b);
    
    if (x < y) return y;
    return x
}

{
    $1=tolower($1);
    gsub("\\.", "", $2);
    $2=substr($2, 2, length($2)-2);
    
    command = "espeak-ng -q -v pt-pt --ipa \"" $1 "\" 2>/dev/null | ../ipa-transformation/transformer-grande-dicionario-pt.sh"
    command | getline $3;
    close(command);
        
    n = max_length($2, $3);
    split($2, A, "");
    split($3, B, "");
    
    a = "";
    b = "";
    i = 0;
    j = 0;
    while(i <= n || j <= n) {
        i++; j++;
        if (A[i] != B[j]) {
        
            if (A[i+1] == B[j+1]) {
                a = a "[" A[i] "]";
                b = b "[" B[j] "]";
                continue;
            }
        
            if (A[i] == B[j+1]) {
                i--;
                a = a "[]";
                b = b "[" B[j] "]";
                continue;
            }

            if (A[i+1] == B[j]) {
                j--;
                a = a "[" A[i] "]";
                b = b "[]";
                continue;
            }
        }
        
        a = a A[i];
        b = b B[j];
    }
        
    $4 = a;
    $5 = b;
    
    print $1, $2, $3, $4, $5, $2 == $3;
}

