#!/usr/bin/awk -f 

#
# Convert Record-Jar formatted files to other formats such as CSV and JSON.
# 
# The Record-Jar Format is defined in The Art of Unix Programming, by Eric S. Raymond.
# 
# Usage:
# 
#     ./record-jar.awk -v "FORMAT=csv" planets.txt
# 
# TODO: support header in before the first delimiter, like in this example cookie-jar: 
#       https://raw.githubusercontent.com/espeak-ng/bcp47-data/master/bcp47-extensions
# 
# Parameters:
# 
#  *  FORMAT: one of these values: `csv`, `ssv`, `psv`, `tsv`, `json`. The default format is `csv`.
#  *  DIALECT: one of these values: `classic`, `recutils`. The default is `classic` (as defined by Eric S. Raymond).
#  *  OFFSET: the number of records to be skipped; The default value is zero. Useful for pagination. Also useful for IANA's some registry files (`OFFSET=1`).
#  *  LIMIT: the maximum number of records to be returned; The default value is 2147483647 (2^31-1). Useful for pagination.
# 
# Notes: 
# 
#  *   For CSV, SSV, PSV or TSV, multivalue fields are represented in a colon-separated values list.
#  *   For JSON, multivalue fields are represented in a JSON array.
#
# Warning: invalid lines are silently ignored.
# 
# Read:
# 
#  *  OpenJR: https://openrj.sourceforge.net
#  *  Alhadis' Record-Jar: https://github.com/Alhadis/Record-Jar
#  *  IETF Draft: https://datatracker.ietf.org/doc/html/draft-phillips-record-jar-02
#  *  Classic Record-Jar Format: http://www.catb.org/esr/writings/taoup/html/ch05s02.html#id2906931
#  *  Parsing Record Jar Formatted Files: https://filebox.ece.vt.edu/~ece2524/reading/record_jar/index.html
#  *  IANA subtag registry: https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry
#  *  IANA tag extensions registry: https://www.iana.org/assignments/language-tag-extensions-registry/language-tag-extensions-registry
#
# Repository: https://github.com/fabiolimace/awk-tools/
#

function print_records() {
    if (format == "csv") {
        print_dsv(",", "\"");
    } else if (format == "ssv") {
        print_dsv(";", "\"");
    } else if (format == "psv") {
        print_dsv("|", "");
    } else if (format == "tsv") {
        print_dsv("\t", "");
    } else if (format == "json") {
        print_json();
    }
}

function print_json(    space, comma, quote, x, y, i, j, name, value) {

    x = rec;
    y = key;
    
    space = " ";
    comma = ",";
    quote = "\"";
    scape = "\\";
    
    for (i = 1; i <= x; i++) {
        if (i == 1) printf "[";
        printf "%s", "\n" space space "{";
        for (j = 1; j <= y; j++) {
            name = quote keys[j] quote;
            value = get_value_json(i, keys[j]);
            if (!length(value)) continue;
            if (get_value_length(i, keys[j]) <= 1) {
                value = quote value quote;
            }
            if (j > 1) printf "%s", comma;
            printf "\n" space space space space "%s: %s", name, value;
        }
        printf "%s", "\n" space space "}";
        if (i < x) printf "%s", comma;
        if (i == x) printf "\n]\n";
    }
}

function get_value_json(rec, name,    quote, n, i, v, value) {
    
    quote = "\"";
    n = get_value_length(rec, name);
    
    if (n > 1) {
		value = "[";
		for (i = 1; i <= n; i++) {
			v = get_value(rec, name, i);
			gsub(/\\/, scape scape, v);
			gsub(quote, scape quote, v);
			if (i > 1) {
		    	value = value ", " quote v quote;
			} else {
				value = value quote v quote;
			}
		}
		value = value "]";
		return value;
    }
    
    value = get_value(rec, name, 1);
    gsub(/\\/, scape scape, value);
    gsub(quote, scape quote, value);
	return value;
}

function print_dsv(delimiter, quote,    x, y, i, j, value) {

    x = rec;
    y = key;
    
    for (i = 1; i <= y; i++) {
        if (i > 1) printf "%s", delimiter;
        if (quote) {
            printf "%s", quote keys[i] quote;
        } else {
            printf "%s", keys[i];
        }
    }
    
    for (i = 1; i <= x; i++) {
        if (i == 1) printf "\n";
        for (j = 1; j <= y; j++) {
            if (j > 1) printf "%s", delimiter;
	        if (quote) {
	            value = get_value_dsv(i, keys[j]);
	            gsub(quote, quote quote, value);
	            value = quote value quote;
	            printf "%s", value;
	        } else {
	            value = get_value_dsv(i, keys[j]);
	            if (format == "tsv") {
					gsub(/\t/, "\\t", value);
	            } else if (format == "psv") {
					gsub(/\|/, "\\|", value);
	            } else {
	            	gsub(delimiter, "\\" delimiter, value);
	            }
	            gsub(/\r/, "\\r", value);
	            gsub(/\n/, "\\n", value);
	            printf "%s", value;
	        }
        }
        printf "\n";
    }
}

function get_value_dsv(rec, name,    colon, n, i, v, value) {
    
    colon = ":";
    n = get_value_length(rec, name);
    
    if (n > 1) {
		for (i = 1; i <= n; i++) {
			v = get_value(rec, name, i);
			gsub(colon, "\\" colon, v);
			if (i > 1) {
		    	value = value colon v;
			} else {
				value = value v;
			}
		}
		return value;
    }
    
    value = get_value(rec, name, 1);
    gsub(colon, "\\" colon, value);
	return value;
}

function trim(str) {
    sub(/^[ ]+/, "", str);
    sub(/[ ]+$/, "", str);
    return str;
}

function min(a, b) {
    if (a <= b) {
        return a;
    }
    return b;
}

function max(a, b) {
    if (a <= b) {
        return b;
    }
    return a;
}

function push_key(name) {
    if (!has_key[name]) {
        has_key[name] = 1;
        keys[++key] = name;
    }
}

function push_value(rec, name, value,    idx) {
	has_value[rec "," name]++;
    idx = get_value_length(rec, name);
	values[rec "," name "," idx] = value;
}

function set_value(rec, name, value, idx) {
	if (!idx) {
		idx = get_value_length(rec, name);
		if (!idx) return;
	}
    values[rec "," name "," idx] = value;
}

function get_value(rec, name, idx) {
	if (!idx) {
		idx = get_value_length(rec, name);
		if (!idx) return;
	}
    return values[rec "," name "," idx];
}

function get_value_length(rec, name) {
	return has_value[rec "," name] ? has_value[rec "," name] : 0;
}

function validate(name, regex, value) {
    if (!(value ~ regex)) {
        print "Invalid " name ": '" value "'." > "/dev/stderr";
        invalid_input = 1;
        exit 1;
    }
}

function check_backslash() {
    backslash_flag = ($0 ~ /\\$/) ? 1 : 0;
}

BEGIN {

	# validate parameters
    validate("format", "^(|csv|ssv|psv|tsv|json)$", tolower(FORMAT));
    validate("dialect", "^(|classic|recutils)$", tolower(DIALECT));
    validate("offset", "^(|[0-9]+)$", OFFSET);
    validate("limit", "^(|[0-9]+)$", LIMIT);

	# adjust format and dialect
    format = FORMAT ? tolower(FORMAT) : "csv";
    dialect = DIALECT ? tolower(DIALECT) : "classic";
    
    # adjust offset and limit
    MAX = 2147483647; # 2^31-1
    offset = OFFSET ? min(OFFSET, MAX) : 0;
    limit = LIMIT ? min(LIMIT, MAX - offset) : MAX - offset;
    
    # indexes
    pas = 0;
    rec = 0;
    key = 0;
    
    # arrays
    keys[0];
    has_key[0];
    values[0];
    has_value[0];
    
    # field
    name = "";
    value = "";
    
    # control flags
    passing_record = 0;
    reading_record = 0;
    backslash_flag = 0;

	# setup the chosen dialect
    if (dialect == "recutils") {
        record_delimiter_regex = "^[\t ]*$";
        line_continuation_regex = "^[+]";
    } else {
        record_delimiter_regex = "^%%.*$";
        line_continuation_regex = "^[\t ]";
    }
}

# ignore comment
/^[\t ]*#.*$/ {
	next;
}

# begin of record field
/^[a-zA-Z0-9_-]+[ ]*:/ {
    
    if (!passing_record) {
        pas++;
        passing_record = 1;
    }

    if (pas <= offset || pas >= offset + limit + 1) {
        next;
    }
    
    if (!reading_record) {
        rec++;
        reading_record = 1;
    }
    
    x = index($0, ":");
    name = trim(substr($0, 1, x - 1));
    value = trim(substr($0, x + 1));
    
    push_key(name);
    push_value(rec, name, value);
    
	check_backslash();
    next;
}

# continuation of record field
reading_record && backslash_flag {

	# The Art of Unix Programming about line continuation:
	# "discard backslash followed by whitespace [newline?]" or...

	# remove the backslash
	sub(/\\$/, "", value);
	value = value trim($0);
	set_value(rec, name, value);
	
	check_backslash();
	next;
}

# also continuation of record field
reading_record && $0 ~ line_continuation_regex {

	# The Art of Unix Programming about line continuation:
	# ... or "interpret newline followed by whitespace equivalently to a single space".

	# ignore the first character which
	# denotes continuation of the line
    value = value " " trim(substr($0, 2));
    set_value(rec, name, value);
    
	check_backslash();
	next;
}

# end of the current record
$0 ~ record_delimiter_regex {
	name = "";
	value = "";
    passing_record = 0;
    reading_record = 0;
    backslash_flag = 0;
    next;
}

END {
    if (!invalid_input) print_records();
}

