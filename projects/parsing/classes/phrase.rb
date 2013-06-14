# encoding: utf-8

class Phrase < AdvancedTreeNode

  attr_accessor :cat

  def to_s
    "[#{display_value} #{children_to_s}]"
  end

  def display_value
    if value.kind_of? Token
      return "#{cat} #{value.wordform}"
    else
      return cat
    end

  end

end