
# R$ 1       -> 1 real
# R$ 10      -> 10 reais
# R$ 1 mi    -> 1 milhão de reais
# R$ 100 bi  -> 100 bilhões de reais
# R$ 1,5 tri -> 1,5 trilhão de reais
BEGIN {
	MON["R$"]="reais"
	MON["US$"]="dólares"
	MON["£"]="libras"
	MON["€"]="euros"
	MON["¥"]="ienes"

	GRP["mil"]="mil"
	GRP["mi"]="milhões de"
	GRP["milhão"]="milhão de"
	GRP["milhões"]="milhões de"
	GRP["bi"]="bilhões de"
	GRP["bilhão"]="bilhão de"
	GRP["bilhões"]="bilhões de"
	GRP["tri"]="trilhões de"
	GRP["trilhão"]="trilhão de"
	GRP["trilhões"]="trilhões de"

	SIN["R$"]="real"
	SIN["US$"]="dólar"
	SIN["£"]="libra"
	SIN["€"]="euro"
	SIN["¥"]="iene"
	SIN["mi"]="milhão de"
	SIN["bi"]="bilhão de"
	SIN["tri"]="trilhão de"
}

function is_money(s) {
	return (s in MON);
}

function is_number(s) {
	return (s ~ /^([0-9]{1,3}|[.]?[0-9]{3})*([,][0-9]+)?$/);
}

function is_singular(s) {
	return (s ~ /^1([,][0-9]+)?$/);
}

{
	for (i = 1; i < NF; i++) {
		if ( is_money($i) && is_number($(i+1)) ) {
			if ($(i+2) in GRP) {
				$i = $(i+1) " " (is_singular($(i+1)) ? SIN[$(i+2)] : GRP[$(i+2)]) " " MON[$i];
				$(i+1) = NULL;
				$(i+2) = NULL;
			}
			else {
				$i = $(i+1) " " (is_singular($(i+1)) ? SIN[$i] : MON[$i]);
				$(i+1) = NULL;
			};
		}
	}
	print;
}
