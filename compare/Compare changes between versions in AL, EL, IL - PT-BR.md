Compare changes between versions in AL, EL, IL...
=================================================

grep -Eih "[aâáeêéiíoôóuú]l[^aâáeêéiíoôóuú]" /usr/share/dict/*(brazilian|portuguese) | grep -Ev "[hmnrs]" | grep -Ev "ou$" | sort | uniq | espeak-ng -v pt-br -x -q > ~/al.old.txt # version 1.51
grep -Eih "[aâáeêéiíoôóuú]l[^aâáeêéiíoôóuú]" /usr/share/dict/*(brazilian|portuguese) | grep -Ev "[hmnrs]" | grep -Ev "ou$" | sort | uniq | espeak-ng -v pt-br -x -q > ~/al.new.txt # version 1.53 (dev)

diff ~/al.old.txt ~/al.new.txt

comm -12 <(sort ~/al.old.txt) <(sort ~/al.new.txt) | wc -l
910

comm -3 <(sort ~/al.old.txt) <(sort ~/al.new.txt) | wc -l
34

comm -3 <(sort ~/al.old.txt) <(sort ~/al.new.txt)
'al
	,aUgal'i;U
,aUgal'iU
aUg'Ol
	aUg'Ow
	'aUkoU
'aUkow
	b,aUbus'i;U
b,aUbus'iU
	b,aUdZ'i;U
baUdZ'iU
f'ulZidU
	f'uwZidU
g'aUly
g'Olgot&
	g'oly
	g'Owgot&
	h'Ol
	h,Oliw'UdZ
	l,eop'oldU
l,eop'OldU
	,O,Elyp'e
,oliw'Ud
'owp
p'ulpitU
	p'uwpitU
	s'I;Uvj&
s'IUvj&
	s'I;UvjU
s'IUvjU
	v,iv'aUdZi
v,ivaUdZ'i
	w'aIwdZ
w'iUdZy



