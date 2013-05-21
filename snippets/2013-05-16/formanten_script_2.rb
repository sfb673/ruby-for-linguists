#!/usr/bin/env ruby
# encoding: utf-8

def nearest_vowel_improved(f1, f2)
  distances = VOWELS.collect do |key, value|
    [key, (value[0]-f1).abs + (value[1]-f2).abs]
  end
  matching_entry = distances.min_by{|i| i[1] }
  return matching_entry[0]
end