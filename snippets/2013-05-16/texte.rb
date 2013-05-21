#!/usr/bin/env ruby
# encoding: utf-8

def run(filename)
  f = File.read(filename)
  tokens = f.split /\s+/
  dc_tokens = tokens.collect{|t| t.strip.downcase}
  s_tokens = dc_tokens.sort{|t,u| t.length <=> u.length} # most frequent word
  counter_hash = Hash.new
  s_tokens.each do |t|
    counter_hash[t] = 0 unless counter_hash.has_key?(t)
    counter_hash[t] = counter_hash[t] + 1
  end
  [
    s_tokens.collect{|t| "<#{t}>"}.join(" "),
    s_tokens.reverse.collect{|t| "<#{t}>"}.join(" "),
    (s_tokens.collect{|t|t.size}.inject{|s,x|s+x}/s_tokens.size.to_f),
    counter_hash.max_by{|k,v| v }
  ]
end