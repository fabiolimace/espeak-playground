#!/usr/bin/mawk -f

#
# Produces a TSV that compares each Grande Dicionarios's entries with espeak-ng outputs.
#
# Based on and improved from `../aeiouado-ipa/aeiouado-ipa.awk`
#
# Usage:
# awk -f grande-dicionario.awk grande-dicionario.tsv | tee grande-dicionario.output.tsv
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
    y = length(b);
    
    if (x < y) return y;
    return x
}

{
    $1=tolower($1);
    
    gsub("ˈ", "", $2);
    gsub("\\.", "", $2);
    $2=substr($2, 2, length($2)-2);
    
    command = "espeak-ng -q -v pt-pt --ipa \"" $1 "\" 2>/dev/null"
    command | getline $3;
    close(command);
    
    gsub("ˈ", "", $3);
    gsub("ˌ", "", $3);
        
    gsub(/ɪɐ$/, "jɐ", $3);
    gsub(/ɪʊ$/, "jʊ", $3);
    gsub(/ɪɪ$/, "jɪ", $3);
    gsub(/ɪɨ$/, "jɨ", $3);
    
    gsub(/aɪ/, "aj", $3);
    gsub(/eɪ/, "ɐj", $3);
    gsub(/ɛɪ/, "ɛj", $3);
    gsub(/iɪ/, "ij", $3);
    gsub(/oɪ/, "oj", $3);
    gsub(/ɔɪ/, "ɔj", $3);
    gsub(/uɪ/, "uj", $3);
    
    gsub(/aʊ/, "aw", $3);
    gsub(/eʊ/, "ew", $3);
    gsub(/ɛʊ/, "ɛw", $3);
    gsub(/iʊ/, "iw", $3);
    gsub(/oʊ/, "ow", $3);
    gsub(/ɔʊ/, "ɔw", $3);
    gsub(/uʊ/, "uw", $3);
    
    gsub(/ɪ̃/, "j̃", $3);
    gsub(/ʊ̃/, "w̃", $3);
    gsub(/ʊ/, "u", $3);

    gsub(/ʁ/, "ʀ", $3);
    gsub(/ɾ/, "r", $3);
    gsub(/ŋ/, "n", $3);
    
    gsub(/β/, "b", $3);
    gsub(/ð/, "d", $3);
    gsub(/ɣ/, "ɡ", $3); # different bytes for g
    
    # fix $2 instead
    gsub(/ł/, "ɫ", $2); # different bytes
    gsub(/∫/, "ʃ", $2); # different bytes
    gsub(/ε/, "ɛ", $2); # different bytes
    gsub(/g/, "ɡ", $2); # different bytes
    
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

