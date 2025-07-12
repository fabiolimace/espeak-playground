#!/usr/bin/gawk -f

#
# Formats espeak-ng list files.
#
# Parameters:
#
#  *  TABS: number of tabulations. Default: 2.
#  *  COLS: number of columns per tabulaton: Default: 8.
#  *  ROWS: range of lines to be formatted (inclusive). Default: 1-2147483647 (1 to 2^31-1).
#
# Usage:
#
#     gawk -f format-espeak-list.awk en_list;
#
# This script only works with GNU's gawk.
#

BEGIN {

	TABS = TABS ? TABS : 2;
	COLS = COLS ? COLS : 8;
	MAX = TABS * COLS;
	
	if (ROWS && ROWS !~ /-/) { print "Invalid range." > "/dev/stderr"; exit 1; }
	split(ROWS, R, /-/);
	MIN_ROW=R[1]? R[1] : 1;
	MAX_ROW=R[2]? R[2] : 2^31-1;
	
	SUB = "\x1A"
}

function format_field1() {
	$1 = sprintf("%-" MAX "s", $1);
	gsub("[ ]{1," COLS "}", "\t", $1);
}

function printf_field1() {
	gsub(SUB, " ", $1);
	if ($2) gsub(/[^[:space:]]$/, "& ", $1);
	printf "%s", $1; $1 = ""; $0 = $0;
	trim();
}

function trim() {
	sub(/[[:space:]]+$/, "");
	sub(/^[[:space:]]+/, "");
}

!(NR >= MIN_ROW && NR <= MAX_ROW) {
	print; next;
}

{
	trim();
}

NF == 0 {
	print; next;
}

/^\/\// {
	print; next;
}

# FIX: ?1_10 ten
/^[?][!]?[0-9]/ {
	gsub(/^[?][!]?[0-9]/, "& ", $1); $0 = $0;
}

{
	if ($0 ~ /^[?][!]?[0-9]/) {
		$1 = $1 SUB $2;
		$2 = ""; $0 = $0;
	}

	if ($0 ~ /^([?][!]?[0-9][\x1A])?[(][^()]+[)]/) {
		for (i = 2; i <= NF; i++) {
			if ($i ~ /[)]/) stop = 1;
			$1 = $1 SUB $i;
			$i = "";
			if (stop) break;
		}
	}
	
	format_field1();
	printf_field1();
}

{
	for (i = 2; i <= NF; i++) {
		if ($i ~ /^\/\//) break;
		$1 = $1 SUB $i;
		$i = "";
	}
	if ($i ~ /^\/\//) format_field1();
	printf_field1();
}

/^\/\// {
	printf "" $0;
}

{
	printf "\n";
}

