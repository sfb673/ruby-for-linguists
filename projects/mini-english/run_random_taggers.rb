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
require './classes/abstract_random_tagger'
require './classes/random_tagger1'
require './classes/random_tagger2'
require './classes/random_tagger3'
require './classes/frequency_based_tagger'


simple_tokenizer = SimpleTokenizer.instance
tokenized_text = simple_tokenizer.tokenize_file('./../ambiguous-english/data/ambiguousenglish-test-sentences.txt')

lexicon = Lexicon.read_from_file('./../ambiguous-english/data/ambiguousenglish-lexicon.tsv')

# FIRST TAGGER
tagger_1 = RandomTagger1.instance
tagger_1.train('./../ambiguous-english/data/ambiguousenglish-sample-sentences.txt')
tagged_text_1 = tagger_1.tag(tokenized_text, lexicon)
# puts tagged_text_1.tokens.collect{|t| "%20s | %20s" % [t.wordform, t.pos]}

tagger_2 = RandomTagger2.instance
tagger_2.train('./../ambiguous-english/data/ambiguousenglish-sample-sentences.txt')
tagged_text_2 = tagger_2.tag(tokenized_text, lexicon)
# puts tagged_text_2.tokens.collect{|t| "%20s | %20s" % [t.wordform, t.pos]}

tagger_3 = RandomTagger3.instance
tagger_3.train('./../ambiguous-english/data/ambiguousenglish-sample-sentences.txt')
tagged_text_3 = tagger_3.tag(tokenized_text, lexicon)
# puts tagged_text_3.tokens.collect{|t| "%20s | %20s" % [t.wordform, t.pos]}

tagger_4 = FrequencyBasedTagger.instance
tagger_4.train('./../ambiguous-english/data/ambiguousenglish-sample-sentences.txt')
tagged_text_4 = tagger_4.tag(tokenized_text, lexicon)
# puts tagged_text_3.tokens.collect{|t| "%20s | %20s" % [t.wordform, t.pos]}


# check how well the tagger performed.

gold_standard = File.read('./../ambiguous-english/data/ambiguousenglish-test-sentences-with-cats.txt')
gold_standard = gold_standard.split /\s+/
gold_standard = gold_standard.collect{ |x| x.split("/") }


labels = ['Completely random', 'Random from possible cats, unweighted', 'Random from possible cats, weighted', 'Frequency based tagger']

[tagged_text_1, tagged_text_2, tagged_text_3, tagged_text_4].each_with_index do |text,index|

  matches = 0

  text.tokens.each_with_index do |t,i|
    #puts "%16s | %16s | %16s" % [t.pos, gold_standard[i][1], (t.pos==gold_standard[i][1])]
    matches +=1 if (t.pos==gold_standard[i][1])
  end

  puts
  puts "-" * 40
  puts labels[index]
  puts "-" * 40
  puts "Matches:   %i" % matches
  puts "Total:     %i" % gold_standard.size
  puts "Accuracy:  %4.4f%%" % (100.0*matches.to_f/gold_standard.size)

end
