About the Dictionary
================================

Overview
--------------------------------

[Aeiouadô](http://www.nilc.icmc.usp.br/aeiouado/) is a machine-readable pronunciation dictionary for Brazilian Portuguese, based on the dialect of São Paulo (city). It was designed primarily for Speech Technologies, such as Automatic Speech Recognition Systems and Speech Synthesizers. However, it may also be used by linguists, speech therapists, lexicographers, students of Brazilian Portuguese as a second language, and whoever is interested in the sound structure of Brazilian Portuguese.
Technical Information

The dictionary makes use of a hybrid approach for converting graphemes into phonemes, based on both manual transcription rules and machine learning algorithms. It makes use of a word list compiled from the Portuguese Wikipedia dump. Wikipedia articles were transformed into plain text, tokenized and word types were extracted. A language identification tool was developed to detect loanwords among data. Words' syllable boundaries and stress were identified. The transcription task was carried out in a two-step process: i) words are submitted to a set of transcription rules, in which predictable graphemes (mostly consonants) are transcribed; ii) a machine learning classifier is used to predict the transcription of the remaining graphemes (mostly vowels). The method was evaluated through 5-fold cross-validation; results show a F1-score of 0.98.
System Architecture for Building the Dictionary

More information can be found in the paper to appear in the Proceedings of the Interspeech 2014:

Gustavo Mendonca, Sandra Aluisio (2014). Using a hybrid approach to build a pronunciation dictionary for Brazilian Portuguese. To appear in: Proceedings INTERSPEECH 2014, 15th Annual Conference of the International Speech Communication Association. ISCA. Singapure, August 25-29, 2014.

Research Team
--------------------------------

Aeiouador was developed at the Interinstitutional Center for Computational Linguistics, at the University of São Paulo, by the following team:

Gustavo Augusto de Mendonça Almeida
Master's Student on Computer Science and Computer Mathematics
University of São Paulo (USP)

Sandra Maria Aluisio, PhD
Mentor - Assistant Professor
University of São Paulo (USP)

What does "Aeiouadô" mean?
--------------------------------

Aeiouadô was named after a neologism coined by the Brazilian novelist Guimarães Rosa. Rosa can be regarded as the Brazilian Joyce, his books possess a peculiar language, with many complex collations, neologisms and puns. "Aeiouadô" derives from "aeiouar", one of Rosa's neologisms, which represents the sound the wind makes.

The bird in our logo is a Blue-and-yellow Macaw, a parrot typical a parrot typical from the Brazilian Amazon Forest and Tropical Savanna.


