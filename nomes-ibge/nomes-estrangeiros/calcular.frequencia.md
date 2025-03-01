
```bash
cat nomes.estrangeiros.output.txt | tr [:upper:] [:lower:] | awk -F, -v OFS="," '/^\[.*\]/ {print substr($3, 8), substr($4, 14) , substr($2, 8)}' | sort --human-numeric-sort > nomes.estrangeiros.frequencia.csv
```
