#!/bin/awk -f
#
# Format espeak-ng word list in dictsource directory
#
# Usage:
# 
#     awk -f ~/espeak-ng-format-dictsource-list.awk ~/git/espeak-ng/dictsource/pt_list | less
#

BEGIN {

	spc="([ \t]+)"
	cnd="(?[0-9][ \t]+)"
	wrd="([[:alpha:]]+)"
	pho="([ \t]+[^ \t$][[:alnum:][:punct:]]+)"
	flg="([ \t]+[$][[:alnum:][:punct:]]+)"
	com="([ \t]*//.*)"
	
	rex = "^" spc "?" cnd "?" wrd pho "?" flg "*" com "?" "$" 
	
	print rex
}

$0 ~ rex {
	print $0
}

