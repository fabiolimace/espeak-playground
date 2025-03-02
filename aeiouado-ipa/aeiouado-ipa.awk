#!/usr/bin/mawk -f

#
# Produces a TSV that compares each Aeiouado's entries with espeak-ng outputs.
#
# Usage:
# awk -f aeiouado-ipa.awk aeiouado-ipa-01.csv | tee aeiouado-ipa.output.tsv
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
# * WORD: a word
# * IPA1: the Aeiouado's IPA.
# * IPA2: the espeak-ng's IPA.
# * IPA3: the Aeiouado's IPA with brackets.
# * IPA4: the espeak-ng's IPA with brackets.
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
    b = length(b);
    
    if (x < y) return y;
    return x
}

{
    $1=tolower($1);
    
    gsub("'", "", $2);
    gsub("\\.", "", $2);
    $2=substr($2, 2, length($2)-2);
    
    command = "espeak-ng -q -v pt-br --ipa \"" $1 "\" 2>/dev/null"
    command | getline $3;
    close(command);
    
    gsub("ˈ", "", $3);
    gsub("ˌ", "", $3);
    
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

