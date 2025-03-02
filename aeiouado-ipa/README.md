
O arquivo `aeiouado-ipa-01.csv` é o dicionário do Aeiouado em formato CSV, em sua versão 0.1, de 07/04/2014. Apesar da extensão CSV, o separador de campos utilizado é a tabulação.

O script `aeiouado-ipa.awk` é usado para comparar cada verbete do Aeiouado com as saídas produzidas pelo `espeak-ng`.

Uso do script:

```bash
time awk -f aeiouado-ipa.awk aeiouado-ipa-01.csv | tee aeiouado-ipa.output.tsv

real	67m28,077s
user	4m47,006s
sys	14m34,670s
```

