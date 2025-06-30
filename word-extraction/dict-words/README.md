Extract samples from dictionaries
===================================

The scripts in this folder were implemented to extract samples for the purpose of testing `espeak-ng`.

If you want to use the scripts, you need to buy the ebooks and find a way to extract the text content yourself. Don't ask me.

Usage examples
-----------------------------------

Extracts a sample of 100 random words from [Minidicionário Escolar Língua Portuguesa](https://www.amazon.com.br/dp/B0BVRVGD7L):

```bash
gawk -f dicionario-ciranda-cultural.awk "my-ebooks/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.txt" \
	| shuf | head -100 | sort > dicionario-ciranda-cultural.SAMPLE.tsv
```

Extracts a sample of 100 random words from [Dicionário Global Escolar Silveira Bueno da Língua Portuguesa](https://www.amazon.com.br/dp/B072BZHTSF):

```bash
gawk -f dicionario-silveira-bueno.awk "my-ebooks/Dicionário Global Escolar Silveira Bueno da Língua Portuguesa - Silveira Bueno.txt" \
	| shuf | head -100 | sort > dicionario-silveira-bueno.SAMPLE.tsv
```

Extracts a sample of 100 random words from [Dicionário Porto Editora da Língua Portuguesa](https://www.amazon.com.br/dp/B00E059B74):

```bash
gawk -f dicionario-porto-editora.awk "my-ebooks/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.txt" \
	| shuf | head -100 | sort > dicionario-porto-editora.SAMPLE.tsv
```

Extracts a sample of 100 random  words from [Grande Dicionário da Língua Portuguesa da Porto Editora](https://www.amazon.com.br/dp/B00HGW83U4):

```bash
gawk -f dicionario-grande-porto-editora.awk "my-ebooks/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.txt" \
	| grep -E -v "(ã|an|am|ân|âm)" | shuf | head -100 | sort > dicionario-grande-porto-editora.SAMPLE.tsv
```

