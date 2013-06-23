# encoding: utf-8

class ChartEntry

  # Symbol to represent the dot with when creating
  # a string representation of the chart.
  DOT = "#"

  attr_accessor :start_index
  attr_accessor :end_index
  attr_accessor :left_symbol
  attr_accessor :right_symbols
  attr_accessor :dot_position

  def initialize(start_ind, end_ind, left, rights, dot_position=0)

    @start_index = start_ind
    @end_index = end_ind
    @left_symbol = left
    @right_symbols = rights
    @dot_position = dot_position
  end

  def inactive_part
    @right_symbols.slice(0,@dot_position)
  end

  def active_part
    @right_symbols.slice(@dot_position..@right_symbols.size)
  end

  # checking methods

  def range_is?(i,j)
    #puts "%i, %i, %i, %i" % [@start_index, @end_index, i, j]
    @start_index==i && @end_index==j
  end

  def left_symbol_matches?(test)
    @left_symbol == test
  end

  def right_symbols_start_with?(ary)
    @right_symbols.slice(0,ary.size) == [*ary]
  end

  def active_part_starts_with?(ary)
    active_part.slice(0,ary.size) == [*ary]
  end

  def complete?
    @dot_position == @right_symbols.size
  end

  # helping methods

  def rhs_to_s
    r = Array.new(right_symbols) # copy array contents, so we can insert the dot string
    r.insert @dot_position, DOT
    r.join ' '
  end

  # string representation of the chart contents
  def to_s
    "%2i %2i   <%1i>   %4s -> %s" % [@start_index, @end_index, @dot_position, @left_symbol, rhs_to_s]
  end

end