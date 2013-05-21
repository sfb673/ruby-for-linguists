#!/usr/bin/env ruby
# encoding: utf-8

def nearest_vowel(f1, f2)
  VOWELS.collect{|k,v| [k,(v[0]-f1).abs+(v[1]-f2).abs]}.min_by{|i| i[1]}[0]
end
