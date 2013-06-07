#!/usr/bin/env ruby
# encoding: utf-8

# Use SimpleTokenizer to tokenize the Dagon text.
# print result as a table (pos and lemma empty, since
# no tagger was used.)

require './classes/token'
require './classes/tokenized_text'
require './classes/simple_tokenizer'

simple_tokenizer = SimpleTokenizer.instance
tokenized_text = simple_tokenizer.tokenize_file('../../material/dagon.txt')

puts tokenized_text.tokens.collect{|t| "%20s | %20s | %20s" % [t.wordform, t.pos, t.lemma.canonical_form]}

