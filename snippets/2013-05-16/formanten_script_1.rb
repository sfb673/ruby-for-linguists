#!/usr/bin/env ruby
# encoding: utf-8

def nearest_vowel_first_attempt(f1, f2)
  resulting_distances = Array.new vowel_array = Array.new
  VOWELS.each_pair do |key,value|
    vowel_array << key
    d1 = (value[0]-f1).abs
    d2 = (value[1]-f2).abs
    resulting_distances << d1+d2
  end
  min_distance = resulting_distances.min
  min_index = resulting_distances.index(min_distance) matching_vowel = vowel_array[min_index]
  return matching_vowel
end