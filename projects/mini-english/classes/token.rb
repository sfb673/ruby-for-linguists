# encoding: utf-8

class Token

  attr_accessor :wordform, :pos, :lemma

  def initialize(wordform=nil, pos=nil, lemma=nil)
    @wordform = wordform
    @pos = pos
    @lemma = lemma
  end

  def is_word?
    not is_punctuation?
  end

  def is_punctuation?
    %w(. ,).include?(wordform)
  end

  def is_tagged?
    (!@pos.nil?) && (!@lemma.nil?)
  end

end