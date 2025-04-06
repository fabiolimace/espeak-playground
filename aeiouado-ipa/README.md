
O arquivo `aeiouado-ipa-01.csv` é o dicionário do Aeiouado em formato CSV, em sua versão 0.1, de 07/04/2014. Apesar da extensão CSV, o separador de campos utilizado é a tabulação.

Geração de uma lista de palavras:

```bash
gawk '{print tolower($1)}' aeiouado-ipa-01.csv > aeiouado-ipa.words.txt
```

Nota: só o GNU's Gawk converte caracteres acentuados para minúsculas; O Debian Mawk e o Busybox não fazem isso.

O script `aeiouado-ipa.awk` é usado para comparar cada verbete do Aeiouado com as saídas produzidas pelo `espeak-ng`.

Uso do script:

```bash
time awk -f aeiouado-ipa.awk aeiouado-ipa-01.csv | tee aeiouado-ipa.output.tsv

real	67m28,077s
user	4m47,006s
sys	14m34,670s
```

