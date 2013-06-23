# encoding: utf-8

class SimpleChartParser

  # maximale Anzahl an Iterationen, um zu vermeiden, dass der
  # Parser
  MAX_ITERATIONS = 64

  attr_reader :chart
  attr_reader :lexicon
  attr_reader :rule_set
  attr_reader :input
  attr_reader :start_symbol

  def initialize(lexicon, rule_set)
    @chart = Chart.new
    @lexicon = lexicon
    @rule_set = rule_set
  end

  def set_input(i)
    @input = i.split(/\s+/)
  end

  def register_start_values(start_symbol)
    @rule_set.all_rules_for_left_symbol(start_symbol).each do |rule|
      @chart.add_entry(0, 0, rule.left_symbol, rule.right_symbols, 0)
    end
  end

  # Der Algorithmus ist im CL&ST-Buch nicht wirklich eindeutig beschrieben,
  # speziell, in welcher Reihenfolge und Wiederholung scan, expand und
  # complete ausgeführt werden sollen. Hier
  def parse(sentence, start_symbol)
    set_input sentence
    @start_symbol=start_symbol
    @chart.clear!

    register_start_values(start_symbol)

    n = 0
    result_found = false
    begin
      ec_loop
      scan_loop
      result_found = has_complete_match?
      puts "Completed iteration #%i." % n
      complete_matches.each do |m|
        puts "Complete Match found:\n%s" % m.to_s
      end
      # puts @chart
      n=n+1
    end while (n<MAX_ITERATIONS && !result_found)
  end

  # returns true if either expand or complete created something new
  def ec_loop
    n = 0
    begin
      e = expand
      c = complete
      n=n+1
    end until (e||c||(n>MAX_ITERATIONS))
  end

  def scan_loop
    n = 0
    begin
      s = scan
      n=n+1
    end until (s||(n>MAX_ITERATIONS))
  end

  def expand
    chart_modified = false
    @chart.find.each do |entry|
      lhs = entry.active_part.first
      @rule_set.all_rules_for_left_symbol(lhs).each do |rule|
        chart_modified ||= @chart.add_entry entry.end_index, entry.end_index, lhs, rule.right_symbols, 0
      end
    end
    return chart_modified
  end

  def scan
    chart_modified = false
    @input.each do |i|
      match = @chart.find :active_part_starts_with => i
      unless match.empty?
        match.each do |entry|
          chart_modified ||= @chart.add_entry entry.start_index, entry.end_index+1, entry.left_symbol, entry.right_symbols, entry.dot_position+1
        end
      end
    end
    return chart_modified
  end

  # returns true if the chart was modified in this run.
  def complete
    chart_modified = false
    match1 = @chart.find
    match1.each do |m1|
      match2 = @chart.find :start => m1.end_index, :left_symbol => m1.active_part.first, :complete => true
      unless match2.empty?
        match2.each do |m2|
          chart_modified ||= @chart.add_entry m1.start_index, m2.end_index, m1.left_symbol, m1.right_symbols, m1.dot_position+1
        end
      end
    end
    return chart_modified
  end

  def has_complete_match?
    not complete_matches.empty?
  end

  def complete_matches
    @chart.find :range => [0,@input.size], :left_symbol => @start_symbol, :complete => true
  end

end