# encoding: utf-8

class Chart

  attr_accessor :chart_entries

  def initialize
    @chart_entries = []
  end

  def add_entry(s, e, l, r, d)
    check = @chart_entries.select{ |i|
      i.start_index == s &&
      i.end_index == e &&
      i.left_symbol == l &&
      i.right_symbols == r &&
      i.dot_position == d
    }
    if check.empty?
      ce = ChartEntry.new(s, e, l, r, d)
      @chart_entries << ce
      return true
    else
      return false
    end
  end


  def size
    chart_entries.size
  end

  def clear!
    @chart_entries.clear
  end

  def find(opts={})

    # keys supported in opts:
    # start
    # end
    # range
    # left_symbol
    # right_symbols_start_with
    # active_part_starts_with
    # complete

    result = @chart_entries

    if opts.has_key? :start
      result = result.select{|i| i.start_index == opts[:start] }
    end

    if opts.has_key? :end
      result = result.select{|i| i.end_index == opts[:end] }
    end

    if opts.has_key? :range
      r = opts[:range]
      result = result.select{|i| i.range_is?(*r) }
    end

    if opts.has_key? :left_symbol
      result = result.select{|i| i.left_symbol == opts[:left_symbol] }
    end

    if opts.has_key? :right_symbols_start_with
      result = result.select{|i| i.right_symbols_start_with?(opts[:right_symbols_start_with]) }
    end

    if opts.has_key? :active_part_starts_with
      result = result.select{|i| i.active_part_starts_with?(opts[:active_part_starts_with]) }
    end

    if opts.has_key? :complete
      result = result.select{|i| i.complete? == opts[:complete] }
    end

    return result
  end

  def to_s
    @chart_entries.map(&:to_s).join("\n")
  end

end