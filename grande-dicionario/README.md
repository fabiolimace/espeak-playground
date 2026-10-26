Grande Dicionario
==================================

Iteration of improvements
----------------------------------

An iteration is a session of improvements in the rules of European Portuguese.

First you generate the first OUTPUT file, with the number ZERO. All iterations will be compared with the first OUTPUT file.

Then, you start another iteration by making improvements to the rules and exceptions.

After the improvements, you generate another OUTPUT file for the current iteration.

Generate an output file for the current iteration:

	i=0
	time awk -f grande-dicionario.awk ../dict-extraction/PRIVATE/"Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.tsv" | tee OUTPUT.$i.tsv
	
Generate a file that lists all matches for the current iteration:

	awk '$6 { print $1 }' OUTPUT.$i.tsv > MATCHES.$i.txt

Count and list the words the current iteration fixed:

	diff MATCHES.0.txt MATCHES.$i.txt | grep -F '>' | wc -l
	diff MATCHES.0.txt MATCHES.$i.txt | grep -F '>' > FIXED.$i.txt

Count and list the words that the current iteration broke:

	diff MATCHES.0.txt MATCHES.$i.txt | grep -F '<' | wc -l
	diff MATCHES.0.txt MATCHES.$i.txt | grep -F '<' > BROKEN.$i.txt

Now you will try to fix the words you broke in the current iteration.

Then start another iteration.
