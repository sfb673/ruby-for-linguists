#!/usr/bin/env ruby
# encoding: utf-8

# Use SimpleTokenizer to tokenize the Dagon text.
# print result as a table (pos and lemma empty, since
# no tagger was used.)

require './classes/token'
require './classes/tokenized_text'
require './classes/lexicon'
require './classes/lex_entry'
require './classes/lemma'
require './classes/simple_tokenizer'
require './classes/simple_tagger'

simple_tokenizer = SimpleTokenizer.instance
tokenized_text = simple_tokenizer.tokenize_file('./data/minienglish-sample-sentences.txt')

lexicon = Lexicon.read_from_file('./data/minienglish-lexicon.tsv')
simple_tagger = SimpleTagger.instance
tagged_text = simple_tagger.tag(tokenized_text, lexicon)
puts tagged_text.tokens.collect{|t| "%20s | %20s | %20s" % [t.wordform, t.pos, t.lemma.canonical_form]}

