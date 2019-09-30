#!/bin/bash

# The directory with Imsky's wordlists in it.
# Imsky's Wordlists: https://github.com/imsky/wordlists
WORDLIST_DIR="$HOME/projects/wordlists/imsky_wordlists"

function adverbize {
	verb="$1"
	i=$((${#verb}-1))
	if [[ "${verb:$i:1}" == "e" ]]; then
		echo "${verb:0:$i}ing"
	else
		echo "$verb"ing
	fi
}

# These are the names of files which I feel have nouns which sound "noun-y".
# There are many noun files with nouns that don't sound like nouns. For
# example, the `nouns/cats.txt` file has nouns like "siberian" and "ginger"
# wich sound like adjectives to me, though they're technically names of cat
# breeds.
acceptable_nouns=(web_development water vcs startups storage spirits set_theory plants music_instruments minerals metals meat houses ghosts geometry geography furniture fruit food fish fast_food dogs corporate_job containers condiments coding cheese birds automobiles astronomy)
acceptable_noun_files=()
for n in ${acceptable_nouns[@]}; do
	acceptable_noun_files+=("$WORDLIST_DIR/nouns/$n.txt")
done

cat \
	<(cat "$WORDLIST_DIR"/adjectives/*.txt | shuf | head -n 2) \
	<(cat "$WORDLIST_DIR"/verbs/*.txt | shuf | head -n 1 | while read line; do printf "%s\n" $(adverbize $line) ; done) \
	<(cat ${acceptable_noun_files[@]} | shuf | head -n 2)


