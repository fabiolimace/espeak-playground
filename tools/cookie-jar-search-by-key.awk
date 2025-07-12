#!/usr/bin/awk -f

#
# Search records in a Cookie-Jar format file
#
# If it finds the KEY in a line that starts with `%%`, it prints the corresponding records.
#
# The text in the same line as the record separator `%%` is used as a record KEY.
#
# The KEY is a regula expression.
#
# Usage:
#
#     # prints the content of "key2" record
#     cookie-jar-search-by-key.awk -v KEY="key2" example.txt
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

/^%%/ && KEY {
	if ($2 ~ KEY) {
		show=1;
		print;
	}
	else {
		show=0;
	}
	next;
}

show == 1 {
	print;
}

