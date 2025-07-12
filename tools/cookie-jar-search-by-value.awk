#!/usr/bin/awk -f

#
# Search records in a Cookie-Jar format file
#
# If it finds the VALUE in the content of records, it prints these records.
#
# The VALUE is a regula expression.
#
# Usage:
#
#     # prints the record that contains "value2"
#     cookie-jar-search-by-value.awk -v VALUE="value2" example.txt
#
# Content of `example.txt`:
#
# %% key1
# value1
# %% key2
# value2
# %% key3
# value3
#
# Repository: https://github.com/fabiolimace/awk-tools/
#

function save() {
	if (buff) {
		buff = buff "\n" $0;
	} else {
		buff = $0;
	}
}

function flush() {
	if (buff) {
		print buff;
	}
	buff = NULL;
}

function empty() {
	buff = NULL;
}

$0 !~ /^%%/ && VALUE {
	if ($0 ~ VALUE) {
		show=1;
	}
	save();
}

/^%%/ {
	if (show) {
		flush();
	} else {
		empty();
	}
	show=0;
	save();
}

END {
	if (show) {
		flush();
	}
}

