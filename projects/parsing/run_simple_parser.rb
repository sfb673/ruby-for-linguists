
%w(lemma lex_entry lexicon simple_tokenizer simple_tagger token tokenized_text).each do |kl|
  require File.join(File.dirname(__FILE__), '..', 'mini-english', 'classes', kl)
end
%w(rule rule_set advanced_tree advanced_tree_node).each do |kl|
  require File.join(File.dirname(__FILE__), 'classes', kl)
end
require './classes/simple_parser'

# Fügen Sie hier Ihren zu testenden Satz ein. ;)
# sentence = "Fred and Hank talked to their sister whenever they stopped at the hill."
# sentence = "Dean killed the happy zombie."
# sentence = "the big zombie caught a bird and ate it."
# sentence = "the zombie with the happy bird killed Dean."
sentence = "Dean killed the zombie with the happy bird."

tt = SimpleTokenizer.instance.tokenize(sentence)
lexicon = Lexicon.read_from_file(File.join(File.dirname(__FILE__), '..', 'mini-english', 'data', 'minienglish-lexicon.tsv'))
tagged_tt = SimpleTagger.instance.tag(tt, lexicon)

puts %Q(Parsing this sentence: "#{sentence}")
rule_set = RuleSet.read_from_file(File.join(File.dirname(__FILE__), '..', 'mini-english', 'data', 'minienglish-syntax-rules.tsv'))
parser = SimpleParser.new
parser.rule_set = rule_set
resulting_tree = parser.parse(tagged_tt)
puts 'Parsing done.'
puts 'Resulting Tree:'
puts resulting_tree
