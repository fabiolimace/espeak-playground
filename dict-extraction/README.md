Extract entries from dictionaries
=========================================

The scripts in this folder were implemented to extract entries for the purpose of testing `espeak-ng`.

If you want to use the scripts, you need to buy the ebooks and find a way to extract the text content yourself. Don't ask me.

Extract entries
----------------

Extracts words from [Minidicionário Escolar Língua Portuguesa](https://www.amazon.com.br/dp/B0BVRVGD7L):

```bash
gawk -f dicionario-ciranda-cultural.awk "PRIVATE/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.txt" | sort > "PRIVATE/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.tsv"

awk '{ n = split($3, A, ";"); for (i in A) print A[i]; }' "PRIVATE/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.tsv" | sort | uniq -c | sort -rh > "PRIVATE/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.pos.txt"
```

Extracts words from [Dicionário Global Escolar Silveira Bueno da Língua Portuguesa](https://www.amazon.com.br/dp/B072BZHTSF):

```bash
gawk -f dicionario-silveira-bueno.awk "PRIVATE/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.txt" | sort > "PRIVATE/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.tsv"

awk '{ n = split($3, A, ";"); for (i in A) print A[i]; }' "PRIVATE/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.tsv" | sort | uniq -c | sort -rh > "PRIVATE/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.pos.txt"
```

Extracts words from [Dicionário Porto Editora da Língua Portuguesa](https://www.amazon.com.br/dp/B00E059B74):

```bash
gawk -f dicionario-porto-editora.awk "PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.txt" | sort > "PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.tsv"

awk '{ n = split($3, A, ";"); for (i in A) print A[i]; }' "PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.tsv" | sort | uniq -c | sort -rh > "PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.pos.txt"
```

Extracts words from [Grande Dicionário da Língua Portuguesa da Porto Editora](https://www.amazon.com.br/dp/B00HGW83U4):

```bash
gawk -f dicionario-grande-porto-editora.awk "PRIVATE/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.txt" | sort > "PRIVATE/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.tsv"

awk '{ n = split($3, A, ";"); for (i in A) print A[i]; }' "PRIVATE/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.tsv" | sort | uniq -c | sort -rh > "PRIVATE/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.pos.txt"
```

