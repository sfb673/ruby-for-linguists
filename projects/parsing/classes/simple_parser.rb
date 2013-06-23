# encoding: utf-8

%w(lemma lex_entry lexicon simple_tokenizer token tokenized_text).each do |kl|
  require File.join(File.dirname(__FILE__), '..', '..', 'mini-english', 'classes', kl)
end

require File.join(File.dirname(__FILE__),'advanced_tree')
require File.join(File.dirname(__FILE__),'advanced_tree_node')
require File.join(File.dirname(__FILE__),'phrase')

class SimpleParser

  attr_accessor :rule_set

  def parse(sequence)

    input_sequence = sequence
    if sequence.kind_of? String
      input_sequence = SimpleTokenizer.instance.tokenize(sequence)
    end

    parsetree = AdvancedTree.new

    # create tree from this sequence
    input_sequence.tokens.each do |t|
      t_node = Phrase.new(t, parsetree)
      t_node.cat = t.pos
      parsetree.add_node t_node
    end

    matches = []
    rule_set.rules.each do |rule|
      m = rule.matches?(parsetree.roots)
      matches << [rule,m] if m
    end

    seq = parsetree.roots
    match_found = true
    new_tree = apply(parsetree, seq)
    while new_tree
      parsetree = new_tree
      seq = parsetree.roots
      new_tree = apply(parsetree, seq)
    end
    parsetree
  end

  def apply(parsetree, seq)
    matches = rule_set.rules.find do |rule|
      rule.matches?(seq)
    end
    if matches!=nil && matches!=false
      match = matches
      match = matches.first if matches.kind_of? Enumerable
      pos = match.matches?(seq)

      new_cat = match.left_symbol
      new_phrase = Phrase.new(new_cat, parsetree)
      new_phrase.cat = new_cat
      parsetree.add_node(new_phrase, pos)
      parsetree.children.slice(pos+1,match.length).each do |c|
        new_phrase.add_child(c)
      end
      return parsetree
    else
      return nil
    end
  end

end