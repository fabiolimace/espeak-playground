IPA Transformation
==================================

Character Tables
----------------------------------

Oral vowels:

| Vowel | Unicode |
|-------|---------|
|   a   |         |
|   ɐ   | U+0250  |
|   ə   | U+0259  |
|   ɑ   | U+0251  |
|   e   |         |
|   ɛ   | U+025B  |
|   i   |         |
|   ɪ   | U+026A  |
|   ɨ   | U+0268  |
|   o   |         |
|   ɔ   | U+0254  |
|   u   |         |
|   ʊ   | U+028A  |

Nasal vowels:

| Vowel | Unicode       |
|-------|---------------|
|   ã   | a      U+0303 |
|   ɐ̃   | U+0250 U+0303 |
|   ẽ   | e      U+0303 |
|   ĩ   | i      U+0303 |
|   ɪ̃   | U+026A U+0303 |
|   õ   | o      U+0303 |
|   ũ   | u      U+0303 |
|   ʊ̃   | U+028A U+0303 |

Oral Semivowels:

| Vowel | Unicode       |
|-------|---------------|
|   j   |               |
|   ɪ̯   | U+026A U+032F |
|   w   |               |
|   ʊ̯   | U+028A U+032F |

Nasal Semivowels:

| Vowel | Unicode              |
|-------|----------------------|
|   j̃   | j      U+0303        |
|   ɪ̯̃   | U+026A U+0303 U+032F |
|   w̃   | w      U+0303        |
|   ʊ̯̃   | U+028A U+0303 U+032F |

Consonants:

| Cons. | Unicode |
|-------|---------|
|   b   |         |
|   β   | U+03B2? |
|   d   |         |
|   ð   | U+00F0? |
|   f   |         |
|   ɡ   | U+0261  |
|   ɣ   | U+0263  |
|   ʒ   | U+0292  |
|   h   |         |
|   ɦ   | U+0266  |
|   k   |         |
|   l   |         |
|   ɫ   | U+026B  |
|   m   |         |
|   n   |         |
|   ɲ   | U+0272  |
|   ŋ   | U+014B? |
|   p   |         |
|   r   |         |
|   ɾ   | U+027E  |
|   ɹ   | U+0279  |
|   ɻ   | U+027B  |
|   ʁ   | U+0281  |
|   ʀ   | U+0280  |
|   χ   | U+03C7? |
|   s   |         |
|   ʃ   | U+0283  |
|   t   |         |
|   v   |         |
|   x   |         |
|   z   |         |

Diacritics:

| Diac. | Unicode |
|-------|---------|
|   ̃    | U+0303  |
|   ̯    | U+032F  |
|   ̥    | U+0325  |
|       |         |
|   ͡   | U+0361  |
|   ͜    | U+035C  |
|       |         |

Other:

| Other | Unicode |
|-------|---------|
|   ʲ   | U+02B2  |
|   ʷ   | U+02B7  |
|   ⁿ   | U+207F? |
|   ᵑ   | U+1D51  |
|   ᵐ   | U+1D50  |
|   ᶬ   | U+1DAC? |
|   ˠ   | U+02E0  |
|   ʰ   | U+02B0  |

Regular Expressions
----------------------------------

Regex for a possible stress:

	[ˈˌ]?

Regex for oral vowels:

	[aɐəɑeɛiɪɨoɔuʊ]

Regex for nasal vowels:

	(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)

Unicode Decomposition
----------------------------------

You must decompose the nasal vowels first:

	s/ã/ã/g; # ã --> a + U+0303
	s/ẽ/ẽ/g; # ẽ --> e + U+0303
	s/ĩ/ĩ/g; # ĩ --> i + U+0303
	s/õ/õ/g; # õ --> o + U+0303
	s/ũ/ũ/g; # ũ --> u + U+0303

In the end, you may compose the nasals back:

	s/ã/ã/g; # a + U+0303 --> ã
	s/ẽ/ẽ/g; # e + U+0303 --> ẽ
	s/ĩ/ĩ/g; # i + U+0303 --> ĩ
	s/õ/õ/g; # o + U+0303 --> õ
	s/ũ/ũ/g; # u + U+0303 --> ũ

Change Vowels
----------------------------------

Sed script to replace /ɐ/ with /a/:

	s/ɐ/a/g;

Sed script to replace /ɐ/ with /ə/:

	s/ɐ/ə/g;

Sed script to replace /ɐ̃/ with /ã/:

	s/ɐ̃/ã/g;

Sed script to replace /ɨ/ with /ɨ̥/:

	s/ɨ/ɨ̥/g;

Sed script to replace /ʊ/ with /u/:

	s/ʊ/u/g;

Sed script to replace /eɪ/ with /ɐɪ/:

	s/eɪ/ɐɪ/g;

Sed script to replace /ej/ with /ɐj/:

	s/ej/ɐj/g;

Change Nasal Vowels
----------------------------------

Sed script to replace /ẽĩ/ with /ɐ̃ĩ/:

	s/ẽĩ/ɐ̃ĩ/g;

Sed script to replace /ẽj̃/ with /ɐ̃j̃/:

	s/ẽj̃/ɐ̃j̃/g;

Sed script to replace /eɪ[nŋm]/ with /ẽĩ/:

	s/eɪ([nŋm])/ẽĩ/g;

Sed script to replace /eɪ[nŋm]/ with /ẽj̃/:

	s/eɪ([nŋm])/ẽj̃/g;

Sed script to replace /eɪ[nŋm]/ with /ẽĩ[nŋm]/:

	s/eɪ([nŋm])/ẽĩ\1/g;

Sed script to replace /eɪ[nŋm]/ with /ẽj̃[nŋm]/:

	s/eɪ([nŋm])/ẽj̃\1/g;

Change Vowels With Context
----------------------------------

Sed script to replace /al/ with /ɑɫ/:

	s/([^aɐəɑeɛiɪɨoɔuʊ]?[ˈˌ]?)al([^aɐəɑeɛiɪɨoɔuʊ]?)/\1ɑɫ\2/g;

Sed script to replace /al/ with /ɑɫ/:

	s/([^aɐəɑeɛiɪɨoɔuʊ]?[ˈˌ]?)aʊ([^aɐəɑeɛiɪɨoɔuʊ]?)/\1ɑʊ\2/g;

Sed script to replace /lɨ/ with /ɫɨ̥/:

	s/([aɐəɑeɛiɪɨoɔuʊ])lɨ\>/\1ɫɨ̥/g;

Sed script to replace /aɪa/ with /aɪʲa/:

	s/([aɐəɑeɛiɪɨoɔuʊ])ɪ([aɐəɑeɛiɪɨoɔuʊ])/\1ɪʲ\2/g;

Sed script to replace /aja/ with /ajʲa/:

	s/([aɐəɑeɛiɪɨoɔuʊ])j([aɐəɑeɛiɪɨoɔuʊ])/\1jʲ\2/g;

Change Nasal Vowels With Context
----------------------------------

Sed script to replace /ɐ̃[nŋm]/ with /ɐ̃/:

	s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)[nŋm]([^aɐəɑeɛiɪɨoɔuʊ]|\>)/\1\2/g;

Sed script to replace /ɐ̃n/ with /ɐ̃ⁿ/:

	s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)n([^aɐəɑeɛiɪɨoɔuʊ]|\>)/\1ⁿ\2/g;

Sed script to replace /ɐ̃n/ with /ɐ̃ⁿ/:

	s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)ŋ([^aɐəɑeɛiɪɨoɔuʊ]|\>)/\1ᵑ\2/g;

Sed script to replace /ɐ̃m/ with /ɐ̃ᵐ/:

	s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)m([pb]|\>)/\1ᵐ\2/g;

Sed script to replace /ɐ̃n/ with /ɐ̃ᶬ/:

	s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)n([fv])/\1ᶬ\2/g;

Change Consonants
----------------------------------

Sed script to replace /g/ with /ɡ/(U+0261):

	s/g/ɡ/g;

Sed script to replace /ɡ/(U+0261) with /g/:

	s/ɡ/g/g;

Sed script to replace /x/ with /h/(U+0280):

	s/x/h/g;

Sed script to replace /x/ with /ʀ/(U+0280):

	s/x/ʀ/g;

Sed script to replace /x/ with /ʁ/:

	s/x/ʁ/g;

Sed script to replace /x/ with /χ/(U+0280):

	s/x/χ/g;

Sed script to replace /R/ with /ʀ/(U+0280):

	s/R/ʀ/g;

Sed script to replace /ʀ/(U+0280) with /ʁ/:

	s/ʀ/ʁ/g;

Sed script to replace /ʁ/ with /ʀ/(U+0280):

	s/ʁ/ʀ/g;

Sed script to replace /ʁ/ with /r/:

	s/ʁ/r/g;

Sed script to replace /ʁ/ with /χ/:

	s/ʁ/χ/g;

Sed script to replace /r/ with /ɾ/(U+027E):

	s/r/ɾ/g;

Sed script to replace /ɾ/(U+027E) with /r/:

	s/ɾ/r/g;

Sed script to replace /ɾ/ with /h/:

	s/ɾ/h/g;

Sed script to replace /ɾ/ with /ɹ/:

	s/ɾ/ɹ/g;

Sed script to replace /ɾ/ with /ɻ/:

	s/ɾ/ɻ/g;

Sed script to replace /ɾ/ with /x/:

	s/ɾ/x/g;

Sed script to replace /ɾ/ with /ʁ/:

	s/ɾ/ʁ/g;

Sed script to replace /ɾ/ with /χ/:

	s/ɾ/χ/g;

Change Consonants With Context
----------------------------------

Sed script to replace /ɡw/(U+0261) with /ɡʷ/:

	s/ɡw([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/ɡʷ\1/g;

Sed script to replace /kw/(U+0261) with /kʷ/:

	s/kw([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/kʷ\1/g;

Sed script to replace intervocalic /b/(U+0261) with /β/:

	s/([aɐəɑeɛiɪɨoɔuʊ])b([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1β\2/g;

Sed script to replace intervocalic /bɾ/(U+0261) with /βɾ/:

	s/([aɐəɑeɛiɪɨoɔuʊ])bɾ([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1βɾ\2/g;

Sed script to replace intervocalic /bl/(U+0261) with /βl/:

	s/([aɐəɑeɛiɪɨoɔuʊ])bl([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1βl\2/g;

Sed script to replace intervocalic /d/(U+0261) with /ð/:

	s/([aɐəɑeɛiɪɨoɔuʊ])d([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ð\2/g;

Sed script to replace intervocalic /dɾ/(U+0261) with /ðɾ/:

	s/([aɐəɑeɛiɪɨoɔuʊ])dɾ([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ðɾ\2/g;

Sed script to replace intervocalic /dl/(U+0261) with /ðl/:

	s/([aɐəɑeɛiɪɨoɔuʊ])dl([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ðl\2/g;

Sed script to replace intervocalic /ɡ/(U+0261) with /ɣ/:

	s/([aɐəɑeɛiɪɨoɔuʊ])ɡ([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ɣ\2/g;

Sed script to replace intervocalic /ɡɾ/(U+0261) with /ɣɾ/:

	s/([aɐəɑeɛiɪɨoɔuʊ])ɡɾ([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ɣɾ\2/g;

Sed script to replace intervocalic /ɡl/(U+0261) with /ɣl/:

	s/([aɐəɑeɛiɪɨoɔuʊ])ɡl([ˈˌ]?[aɐəɑeɛiɪɨoɔuʊ])/\1ɣl\2/g;
	
Sed script to replace /bˈa/ and /bɾˈa/ with /ˈba/ and /ˈbɾa/:

	s/([^aɐəɑeɛiɪɨoɔuʊˈˌjw][ɾlw]?)([ˈˌ])([aɐəɑeɛiɪɨoɔuʊ])/\2\1\3/g;

Change Crescent Diphthongs with /j, ɪ̯/
----------------------------------

Sed script to replace /ja/ with /ɪa/:

	s/ja/ɪa/g;
	s/jɐ/ɪɐ/g;
	s/jə/ɪə/g;
	s/jɑ/ɪɑ/g;
	s/je/ɪe/g;
	s/jɛ/ɪɛ/g;
	s/ji/ɪi/g;
	s/jɪ/ɪɪ/g;
	s/jɨ/ɪɨ/g;
	s/jo/ɪo/g;
	s/jɔ/ɪɔ/g;
	s/ju/ɪu/g;
	s/jʊ/ɪʊ/g;

Sed script to replace /ɪa/ with /ja/:

	s/ɪa/ja/g;
	s/ɪɐ/jɐ/g;
	s/ɪə/jə/g;
	s/ɪɑ/jɑ/g;
	s/ɪe/je/g;
	s/ɪɛ/jɛ/g;
	s/ɪi/ji/g;
	s/ɪɪ/jɪ/g;
	s/ɪɨ/jɨ/g;
	s/ɪo/jo/g;
	s/ɪɔ/jɔ/g;
	s/ɪu/ju/g;
	s/ɪʊ/jʊ/g;

Sed script to replace /ɪa/ with /ɪ̯a/:

	s/ɪa/ɪ̯a/g;
	s/ɪɐ/ɪ̯ɐ/g;
	s/ɪə/ɪ̯ə/g;
	s/ɪɑ/ɪ̯ɑ/g;
	s/ɪe/ɪ̯e/g;
	s/ɪɛ/ɪ̯ɛ/g;
	s/ɪi/ɪ̯i/g;
	s/ɪɪ/ɪ̯ɪ/g;
	s/ɪɨ/ɪ̯ɨ/g;
	s/ɪo/ɪ̯o/g;
	s/ɪɔ/ɪ̯ɔ/g;
	s/ɪu/ɪ̯u/g;
	s/ɪʊ/ɪ̯ʊ/g;

Change Decrescent Diphthongs with /j, ɪ̯/
----------------------------------

Sed script to replace /aj/ with /aɪ/:

	s/aj/aɪ/g;
	s/ɐj/ɐɪ/g;
	s/əj/əɪ/g;
	s/ɑj/ɑɪ/g;
	s/ej/eɪ/g;
	s/ɛj/ɛɪ/g;
	s/ij/iɪ/g;
	s/ɪj/ɪɪ/g;
	s/ɨj/ɨɪ/g;
	s/oj/oɪ/g;
	s/ɔj/ɔɪ/g;
	s/uj/uɪ/g;
	s/ʊj/ʊɪ/g;

Sed script to replace /aɪ/ with /aj/:

	s/aɪ/aj/g;
	s/ɐɪ/ɐj/g;
	s/əɪ/əj/g;
	s/ɑɪ/ɑj/g;
	s/eɪ/ej/g;
	s/ɛɪ/ɛj/g;
	s/iɪ/ij/g;
	s/ɪɪ/ɪj/g;
	s/ɨɪ/ɨj/g;
	s/oɪ/oj/g;
	s/ɔɪ/ɔj/g;
	s/uɪ/uj/g;
	s/ʊɪ/ʊj/g;

Sed script to replace /aɪ/ with /aɪ̯/:

	s/aɪ/aɪ̯/g;
	s/ɐɪ/ɐɪ̯/g;
	s/əɪ/əɪ̯/g;
	s/ɑɪ/ɑɪ̯/g;
	s/eɪ/eɪ̯/g;
	s/ɛɪ/ɛɪ̯/g;
	s/iɪ/iɪ̯/g;
	s/ɪɪ/ɪɪ̯/g;
	s/ɨɪ/ɨɪ̯/g;
	s/oɪ/oɪ̯/g;
	s/ɔɪ/ɔɪ̯/g;
	s/uɪ/uɪ̯/g;
	s/ʊɪ/ʊɪ̯/g;

Change Nasal Decrescent Diphthongs with /j̃, ɪ̯̃/
----------------------------------

Sed script to replace /ɐ̃j̃/ with /ɐ̃ɪ̃/:

	s/ãj̃/ãɪ̃/g;
	s/ɐ̃j̃/ɐ̃ɪ̃/g;
	s/ẽj̃/ẽɪ̃/g;
	s/ĩj̃/ĩɪ̃/g;
	s/ɪ̃j̃/ɪ̃ɪ̃/g;
	s/õj̃/õɪ̃/g;
	s/ũj̃/ũɪ̃/g;
	s/ʊ̃j̃/ʊ̃ɪ̃/g;

Sed script to replace /ɐ̃ɪ̃/ with /ɐ̃j̃/:

	s/ãɪ̃/ãj̃/g;
	s/ɐ̃ɪ̃/ɐ̃j̃/g;
	s/ẽɪ̃/ẽj̃/g;
	s/ĩɪ̃/ĩj̃/g;
	s/ɪ̃ɪ̃/ɪ̃j̃/g;
	s/õɪ̃/õj̃/g;
	s/ũɪ̃/ũj̃/g;
	s/ʊ̃ɪ̃/ʊ̃j̃/g;

Sed script to replace /ɐ̃ɪ̃/ with /ɐ̃ɪ̯̃/:

	s/ãɪ̃/ãɪ̯̃/g;
	s/ɐ̃ɪ̃/ɐ̃ɪ̯̃/g;
	s/ẽɪ̃/ẽɪ̯̃/g;
	s/ĩɪ̃/ĩɪ̯̃/g;
	s/ɪ̃ɪ̃/ɪ̃ɪ̯̃/g;
	s/õɪ̃/õɪ̯̃/g;
	s/ũɪ̃/ũɪ̯̃/g;
	s/ʊ̃ɪ̃/ʊ̃ɪ̯̃/g;

Change Crescent Diphthongs with /w, ʊ̯/
----------------------------------

Sed script to replace /wa/ with /ʊa/:

	s/wa/ʊa/g;
	s/wɐ/ʊɐ/g;
	s/wə/ʊə/g;
	s/wɑ/ʊɑ/g;
	s/we/ʊe/g;
	s/wɛ/ʊɛ/g;
	s/wi/ʊi/g;
	s/wɪ/ʊɪ/g;
	s/wɨ/ʊɨ/g;
	s/wo/ʊo/g;
	s/wɔ/ʊɔ/g;
	s/wu/ʊu/g;
	s/wʊ/ʊʊ/g;

Sed script to replace /ʊa/ with /wa/:

	s/ʊa/wa/g;
	s/ʊɐ/wɐ/g;
	s/ʊə/wə/g;
	s/ʊɑ/wɑ/g;
	s/ʊe/we/g;
	s/ʊɛ/wɛ/g;
	s/ʊi/wi/g;
	s/ʊɪ/wɪ/g;
	s/ʊɨ/wɨ/g;
	s/ʊo/wo/g;
	s/ʊɔ/wɔ/g;
	s/ʊu/wu/g;
	s/ʊʊ/wʊ/g;

Sed script to replace /ʊa/ with /ʊ̯a/:

	s/ʊa/ʊ̯a/g;
	s/ʊɐ/ʊ̯ɐ/g;
	s/ʊə/ʊ̯ə/g;
	s/ʊɑ/ʊ̯ɑ/g;
	s/ʊe/ʊ̯e/g;
	s/ʊɛ/ʊ̯ɛ/g;
	s/ʊi/ʊ̯i/g;
	s/ʊɪ/ʊ̯ɪ/g;
	s/ʊɨ/ʊ̯ɨ/g;
	s/ʊo/ʊ̯o/g;
	s/ʊɔ/ʊ̯ɔ/g;
	s/ʊu/ʊ̯u/g;
	s/ʊʊ/ʊ̯ʊ/g;

Change Decrescent Diphthongs with /w, ʊ̯/
----------------------------------

Sed script to replace /aw/ with /aʊ/:

	s/aw/aʊ/g;
	s/ɐw/ɐʊ/g;
	s/əw/əʊ/g;
	s/ɑw/ɑʊ/g;
	s/ew/eʊ/g;
	s/ɛw/ɛʊ/g;
	s/iw/iʊ/g;
	s/ɪw/ɪʊ/g;
	s/ɨw/ɨʊ/g;
	s/ow/oʊ/g;
	s/ɔw/ɔʊ/g;
	s/uw/uʊ/g;
	s/ʊw/ʊʊ/g;

Sed script to replace /aʊ/ with /aw/:

	s/aʊ/aw/g;
	s/ɐʊ/ɐw/g;
	s/əʊ/əw/g;
	s/ɑʊ/ɑw/g;
	s/eʊ/ew/g;
	s/ɛʊ/ɛw/g;
	s/iʊ/iw/g;
	s/ɪʊ/ɪw/g;
	s/ɨʊ/ɨw/g;
	s/oʊ/ow/g;
	s/ɔʊ/ɔw/g;
	s/uʊ/uw/g;
	s/ʊʊ/ʊw/g;

Sed script to replace /aʊ/ with /aʊ̯/:

	s/aʊ/aʊ̯/g;
	s/ɐʊ/ɐʊ̯/g;
	s/əʊ/əʊ̯/g;
	s/ɑʊ/ɑʊ̯/g;
	s/eʊ/eʊ̯/g;
	s/ɛʊ/ɛʊ̯/g;
	s/iʊ/iʊ̯/g;
	s/ɪʊ/ɪʊ̯/g;
	s/ɨʊ/ɨʊ̯/g;
	s/oʊ/oʊ̯/g;
	s/ɔʊ/ɔʊ̯/g;
	s/uʊ/uʊ̯/g;
	s/ʊʊ/ʊʊ̯/g;

Change Nasal Decrescent Diphthongs with /w̃, ʊ̯̃/
----------------------------------

Sed script to replace /ɐ̃w̃/ with /ɐ̃ʊ̃/:

	s/ãw̃/ãʊ̃/g;
	s/ɐ̃w̃/ɐ̃ʊ̃/g;
	s/ẽw̃/ẽʊ̃/g;
	s/ĩw̃/ĩʊ̃/g;
	s/ɪ̃w̃/ɪ̃ʊ̃/g;
	s/õw̃/õʊ̃/g;
	s/ũw̃/ũʊ̃/g;
	s/ʊ̃w̃/ʊ̃ʊ̃/g;

Sed script to replace /ɐ̃ʊ̃/ with /ɐ̃w̃/:

	s/ãʊ̃/ãw̃/g;
	s/ɐ̃ʊ̃/ɐ̃w̃/g;
	s/ẽʊ̃/ẽw̃/g;
	s/ĩʊ̃/ĩw̃/g;
	s/ɪ̃ʊ̃/ɪ̃w̃/g;
	s/õʊ̃/õw̃/g;
	s/ũʊ̃/ũw̃/g;
	s/ʊ̃ʊ̃/ʊ̃w̃/g;

Sed script to replace /ɐ̃ʊ̃/ with /ɐ̃ʊ̯̃/:

	s/ãʊ̃/ãʊ̯̃/g;
	s/ɐ̃ʊ̃/ɐ̃ʊ̯̃/g;
	s/ẽʊ̃/ẽʊ̯̃/g;
	s/ĩʊ̃/ĩʊ̯̃/g;
	s/ɪ̃ʊ̃/ɪ̃ʊ̯̃/g;
	s/õʊ̃/õʊ̯̃/g;
	s/ũʊ̃/ũʊ̯̃/g;
	s/ʊ̃ʊ̃/ʊ̃ʊ̯̃/g;


