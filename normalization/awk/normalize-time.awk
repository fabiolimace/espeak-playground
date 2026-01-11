
# 01:00 -> 1 hora
# 02h00 -> 2 horas
# 23H59 -> 23 horas e 59 minutos
function normalize(s) {

	if (s !~ /^[0-9]{2}[:hH][0-9]{2}$/) return s;

	h = int(substr(s, 1, 2));
	m = int(substr(s, 4, 2));

	if (h > 24) return s;
	if (m > 59) return s;

	return h " hora" (h == 1 ? "" : "s") (m == 0 ? "" : " e " m " minuto" (m == 1 ? "" : "s"));
}

{
	for (i = 1; i <= NF; i++) {
		$i = normalize($i);
	}
	print;
}
