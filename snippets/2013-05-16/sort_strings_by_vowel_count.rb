#!/usr/bin/env ruby
# encoding: utf-8

def sort_by_vowel_count(str_arr)
  str_arr.sort{|s,t| s.count("aeiou") <=> t.count("aeiou") }
end
a = "oiseau"
b = "bird"
c = "Vogel"

sort_by_vowel_count [a,b,c]
# => [”bird”, ”Vogel”, ”oiseau”]