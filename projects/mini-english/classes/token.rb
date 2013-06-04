# encoding: utf-8

# This class represents a single token in a text, optionally
# extendable with annotations like part-of-speech or lemma.
class Token

  # the word form of this token, as it appears in the text.
  attr_accessor :wordform

  # the part of speech of this token, typically added by a tagger.
  attr_accessor :pos

  # the lemma (base form) of this token, typically added by a tagger.
  attr_accessor :lemma

  def initialize(wordform=nil, pos=nil, lemma=nil)
    @wordform = wordform
    @pos = pos
    @lemma = lemma
  end

  # Tells whether a token stands for a word in the text.
  # @return [true|false] `true` if this token represents a word,
  #     `false` otherwise.
  def is_word?
    not is_punctuation?
  end

  # Tells whether a token stands for a punctuation item in the text.
  # @return [true|false] `true` if this token represents punctuation,
  #     `false` otherwise.
  def is_punctuation?
    %w(. ,).include?(wordform)
  end

  # Tells whether a token has been tagged already.
  # @return [true|false] `true` if this token contains values for both
  #     part of speech and lemma fields, `false` otherwise.
  def is_tagged?
    (!@pos.nil?) && (!@lemma.nil?)
  end

end