
# 01/01/1970 -> 1ª de janeiro de 1970
# 01-01-1970 -> 1ª de janeiro de 1970
# 01.01.1970 -> 1ª de janeiro de 1970
BEGIN {
	mm[1]="janeiro"
	mm[2]="fevereiro"
	mm[3]="março"
	mm[4]="abril"
	mm[5]="maio"
	mm[6]="junho"
	mm[7]="julho"
	mm[8]="agosto"
	mm[9]="setembro"
	mm[10]="outubro"
	mm[11]="novembro"
	mm[12]="dezembro"
}

function normalize(s) {

	if (s !~ /^[0-9]{2}[/.-][0-9]{2}[/.-][0-9]{4}$/) return s;
	if (substr(s, 3, 1) != substr(s, 6, 1)) return s;

	d = int(substr(s, 1, 2));
	m = int(substr(s, 4, 2));
	y = int(substr(s, 7, 4));

	if (d > 29 && m == 2) return s;
	if (d > 30 && (m == 4 || m == 6 || m == 9 || m == 11)) return s;
	if (d > 31) return s;

	return ( d > 1 ? d : d "º" ) " de " mm[m] " de " y;
}

{
	for (i = 1; i <= NF; i++) {
		$i = normalize($i);
	}
	print;
}
