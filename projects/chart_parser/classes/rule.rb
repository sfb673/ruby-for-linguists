# encoding: utf-8

class Rule

  attr_accessor :left_symbol
  attr_accessor :right_symbols
  attr_accessor :weight

  def initialize(left, right, weight=1)
    @left_symbol = left
    @right_symbols = right
    @weight = weight.to_i
  end

  def length
    @right_symbols.size
  end

  # true if this rule matches the Phrases somewhere.
  def matches?(sequence)
    (0..(sequence.size-length)).each do |pos|
      return pos if matches_at?(pos, sequence)
    end
    return false
  end

  # true if this rule matches the sequence at the given position
  def matches_at?(position, sequence)
    length.times do |t|
      sub_pos = position+t
      return false if sequence[sub_pos].cat != @right_symbols[t]
    end
    return true
  end

  def to_s
    "#{@left_symbol} -> #{@right_symbols.join(' ')}"
  end

end