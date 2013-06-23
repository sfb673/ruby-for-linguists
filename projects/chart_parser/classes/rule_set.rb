# encoding: utf-8

class RuleSet

  attr_accessor :rules

  def self.read_from_file(filename)

    tsv_data = File.read(filename)
    tsv_data = tsv_data.split /\n/
    tsv_data.reject!{ |line| line =~ /^\s*#/ }
    tsv_data = tsv_data.collect do |line|
      line.split /\t/
    end

    rule_set = RuleSet.new

    tsv_data.each do |entry|
      cat = entry[0]
      r   = entry[1..-1]
      new_rule = Rule.new(cat, r)
      rule_set.add_rule(new_rule)
    end

    rule_set

  end

  def initialize
    @rules = Array.new
  end

  def add_rule(r)
    @rules << r
  end

  def all_rules_for_left_symbol(l)
    @rules.select{|r| r.left_symbol == l }
  end

  def all_left_symbols
    @rules.map(&:left_symbol).uniq
  end

end