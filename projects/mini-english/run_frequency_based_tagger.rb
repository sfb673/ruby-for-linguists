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
require './classes/frequency_based_tagger'

simple_tokenizer = SimpleTokenizer.instance
tokenized_text = simple_tokenizer.tokenize_file('./../ambiguous-english/data/ambiguousenglish-test-sentences.txt')


puts "Training."
lexicon = Lexicon.read_from_file('./../ambiguous-english/data/ambiguousenglish-lexicon.tsv')
fb_tagger = FrequencyBasedTagger.instance
fb_tagger.train('./../ambiguous-english/data/ambiguousenglish-sample-sentences.txt')
# puts fb_tagger.frequency_map.inspect
puts "----------------"
puts "Tagging."
tagged_text = fb_tagger.tag(tokenized_text, lexicon)
puts tagged_text.tokens.collect{|t| "%20s | %20s | %20s" % [t.wordform, t.pos, t.lemma.canonical_form]}

# check how well the tagger performed.

gold_standard = File.read('./../ambiguous-english/data/ambiguousenglish-test-sentences-with-cats.txt')
gold_standard = gold_standard.split /\s+/
gold_standard = gold_standard.collect{ |x| x.split("/") }

matches = 0
tagged_text.tokens.each_with_index do |t,i|
  puts "%16s | %16s | %16s" % [t.pos, gold_standard[i][1], (t.pos==gold_standard[i][1])]
  matches +=1 if (t.pos==gold_standard[i][1])
end

puts "Matches:   %i" % matches
puts "Total:     %i" % gold_standard.size
puts "Accuracy:  %4.4f%%" % (100.0*matches.to_f/gold_standard.size)

