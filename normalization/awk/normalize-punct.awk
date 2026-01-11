{
	for (i = 1; i <= NF; i++) {
		sub(/^[[:punct:]]+/, "& ", $i);
		sub(/[[:punct:]]+$/, " &", $i);
	}
	print;
}
