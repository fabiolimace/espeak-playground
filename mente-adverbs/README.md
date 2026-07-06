Adverbs with -mente
======================

## subtonic rules for pt_rules file

Add these lines to `dictsource/pt_rules` to revive the old orthography rule:

	?1      à (@       ,A          // secondary stress in adverbs with -mente
	?2      à (@       ,a
	        à (nA      ,&~
	        à (mA      ,&~
	        àn (C      ,&~N
	        àm (C      ,&~N
	
	        è (@       ,E          // secondary stress in adverbs with -mente
	?1      è (nA      ,E
	?1      è (mA      ,E
	?2      è (nA      ,e
	?2      è (mA      ,e
	        èn (C      ,e~N
	        èm (C      ,e~N

	        ì (@       ,i          // secondary stress in adverbs with -mente
	        ìn (C      ,i~N
	        ìm (C      ,i~N

	        ò (@       ,O          // secondary stress in adverbs with -mente
	?1      ò (nA      ,O
	?1      ò (mA      ,O
	?2      ò (nA      ,o
	?2      ò (mA      ,o
	        òn (C      ,o~N
	        òm (C      ,o~N

	        ù (@       ,u          // secondary stress in adverbs with -mente
	        ùn (C      ,u~N
	        ùn (C      ,u~N
	
Notes:

1. add rules for d and t before ì.
3. adjust "sub-reptìlicamente"

## list of adverbs

List all adverbs ended with `/[aelmrsz]mente/`:

	cat ../dict-extraction/PRIVATE/*.tsv \
	| awk 'BEGIN { FS="\t" } $3 ~ /adv[.]/ && $1 ~ /[aelmrsz]mente$/ { print $1 }' \
	| sort | uniq > adverbs.txt

Also list the same adverbs from Linux dictionaries:

	cat /usr/share/dict/*(brazilian|portuguese) \
	| awk '$1 ~ /[aelmrsz]mente$/ { print $1 }' \
	| sort | uniq > adverbs-linux.txt

## list of adjectiives

List all adjectives ended with `/[elor]/` and containing `/[áéíóúâôê]/`:

	cat ../dict-extraction/PRIVATE/*.tsv \
	| awk 'BEGIN { FS="\t" } $3 ~ /adj[.]/ && $1 ~ /[elor]$/ && $1 ~ /[áéíóúâôê]/ { print $1 }' \
	| sort | uniq > adjectives.txt

Replace masculine endings with feminine ones:

	sed -E 's/o$/a/;s/or$/ora/' adjectives.txt > fake-adjectives.txt

## fake list of adjectives

List of fake adverbs using grave accent to indicate subtonic syllable:

	awk '{ print $0 "mente" }' fake-adjectives.txt > fake-adverbs.txt

## list of exceptions

List of exceptions to be added to espeak-ng's `dictsource/pt_list` file:

	cat fake-adverbs.txt | \
	while read fakeword; do \
	    word=`echo -n "$fakeword" | sed "s/á/a/;s/é/e/;s/í/i/;s/ó/o/;s/ú/u/;s/â/a/;s/ê/e/;s/ô/o/;"`; \
	    pron=`echo -n "$fakeword" | sed "s/á/à/;s/é/è/;s/í/ì/;s/ó/ò/;s/ú/ù/;s/â/à/;s/ê/è/;s/ô/ò/;"`; \
	    [ "`sort adverbs.txt adverbs-linux.txt | uniq | grep -E "^$word\$"`" ] && echo -e "$word\t\t$pron \$text"; \
	done | sort | uniq | sed -E "s|^([^-]+-[^\t]+)\t|(\1)\t|" > pt_list-additions.txt

--------------------------------------------------

# APPENDIX

## Irretocavelmente

Caetano Veloso, O Globo, 13/04/2014.

Link: https://oglobo.globo.com/cultura/irrecalcavelmente-12179825

Eu gostava mais quando havia mais e não menos acentos

Na semana passada, quis dizer que a canção “O império da lei” se impôs como uma inspiração impossível de recalcar, escolhendo, em vez de “irreprimivelmente”, armar o advérbio de modo a partir de “irrecalcável”. Parei duas vezes diante da palavra porque, primeiro, a nascida do adjetivo “irreprimível” soava mais usual, e, segundo, porque senti falta do acento grave que, até os anos 1970, indicava a sílaba subtônica. Tive vontade de escrever “irrecalcàvelmente”, como fazíamos até aquele acerto (que não se chamou assim tão imponentemente de “acordo ortográfico” como o de agora). Hoje muita gente atribui ao novo acordo o desaparecimento dos acentos diferenciais e desses que indicam subtônicas. Mas isso foi nos anos 70. Os subtônicos eram muito frequentes nos advérbios de modo: se o adjetivo de que nascia o advérbio fosse proparoxítono a gente tinha de indicar, no advérbio, onde caía a tônica no adjetivo de origem. Assim, um advérbio como “heraldicamente” se grafava “heràldicamente”, para que quem o lesse não pronunciasse “heraldìcamente”, se é que vocês me entendem. Na verdade, ninguém põe tonicidade no “i” de “rapidamente”: todo mundo sabe que “rápido” não é “rapido”. Escolhi “heraldicamente” porque é palavra mais longa e menos usual. Mas há exemplos de possível confusão. O acento subtônico não aparecia somente nos advérbios de modo. Há os casos de aumentativos e diminutivos em que a pronúncia do substantivo original parecia precisar ser anotada na grafia de sua forma aumentada ou diminuída. Na verdade, o nome do governador do Rio, Pezão — se é, como parece, um aumentativo de “pé” — muitas vezes pede a volta do acento indicativo da pronúncia aberta do “e”. Ouvi vários comentaristas de TV pronunciando “pezão” com o “e” fechado das breves cariocas e sulistas, como se o apelido do governador falasse, não de um pé grande, mas de um grande peso. Em suma, eu gostava mais quando havia mais e não menos acentos.

Daí que fiquei pensando nisso e não vi que não tinha digitado o ele (“ele” era, até os 1970, uma palavra diferente de “êle”), o que deixou a palavra com uma caca que assustou o meu querido professor André Crim Valente. Em vez de “irrecalcavelmente” (ou, melhor para mim, “irrecalcàvelmente”), enviei para a redação “irecacavelmente”. Não posso me queixar da revisão, amiga, que a editoria do Segundo Caderno faz: sempre ouvi que quem escreve para jornal deve evitar advérbios de modo. E esse era longo, infrequente e usado ali de forma um tanto enigmática. Na verdade, armei o advérbio sem nem me preocupar em ir olhar no dicionário se “irrecalcável” existia. Bem, acabo de ver agora que “recalcável” existe, portanto, posso acrescentar-lhe o prefixo “i”, de negação, e o sufixo “mente”, que caracteriza os advérbios de modo. O fato é que tive desejo irrecalcável de falar em recalque, em vez de repressão. O e-mail de Valente é que me fez ver que tinha escrito errado.

Outros e-mails de leitores me causaram maiores preocupações. Quando escrevi o artigo intitulado “Diapasão”, o leitor Francisco Dellamora (a quem me referi, sem nomear, nesse artigo) mandou e-mail insistindo em que eu teria dito ter “uma aversão quase sexual” ao socialismo (deve ser alguma lembrança de fala minha criticando estados socialistas em que havia clima de repressão contra os homossexuais, eu me posicionando na guerra entre gays e comunistas de que fala Verissimo) e, o que talvez seja mais sério, mostrando surpresa quanto a minhas reticências relativas à acusação de assassinatos covardes de soldados dormindo por parte dos comunistas de 1935. Bem, escrevi com a certeza de que Getúlio utilizou esse retrato cruel dos comunistas para justificar o golpe antidemocrático de 1937. Tenho essa certeza até hoje. Recebi, ao mesmo tempo, e-mail da leitora Cristina Capistrano, que assegura que seu pai, David Capistrano, que morreu vítima da tortura na Casa da Morte de Petrópolis, já na ditadura dos anos 1960/70, não matou nem mataria soldados dormindo. Nem ele nem seus companheiros da intentona de 35. Ela diz — o que corresponde ao que li no “Getúlio” de Lira Neto — que nem mesmo o rigoroso processo oficial para investigar os fatos da intentona comunista acusa os revoltosos de matarem colegas dormindo. David, no entanto, não participava da luta armada, tinha apenas estado exilado e voltava ao Brasil quando foi preso. Devemos lembrar as coisas que aconteceram não por revanchismo ou vontade de vingança, mas para sermos capazes de acabar com a tortura que ainda é praticada contra presos comuns. Ver o “Tropa de elite” do Padilha é estar diante de uma denúncia forte, não de uma apologia aos atos do Bope.



