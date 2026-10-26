Open E and O in EP
==================================

Open E
----------------------------------

List words with open E

```
grep -E "^[^aeiouáéíóúâêô]e[^aeiouáéíóúâêô][aeiouáéíóúâêô][^  ]{4,}" ~/git/espeak-playground/dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv | awk '$2 ~ /\[.ε/'
```

List the and group the first letters of words with open E

```
grep -E "^[^aeiouáéíóúâêô]e[^aeiouáéíóúâêô][aeiouáéíóúâêô][^  ]{4,}" ~/git/espeak-playground/dict-extraction/PRIVATE/Grande\ Dicionário\ da\ Língua\ Portuguesa\ da\ Porto\ Editora\ -\ Porto\ Editora.tsv | awk '$2 ~ /\[.ε/'  | awk '{ print substr($1, 1, 4); }' | sort | uniq -c | sort -h
```

Referencies
----------------------------------

* https://ciberduvidas.iscte-iul.pt/consultorio/perguntas/fonetica-e-e-o-abertos/7872#

* https://www.youtube.com/watch?v=zXn8oYOuGqk



