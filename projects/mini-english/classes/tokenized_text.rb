# encoding: utf-8

# This class represents a text as a sequence of {Token} objects which
# can have additional information (part-of-speech, lemma, etc.)
# associated with it.
class TokenizedText

  # The internal collection of {Token} objects
  attr_accessor :tokens

  def initialize
    @tokens = Array.new
  end

  # Returns the number of tokens in this text.
  # @return [Integer] the length of the text in tokens.
  def length
    @tokens.length
  end

  alias :size :length

  # appends a single token to the end of this text.
  # @param new_token [Token] the token to append.
  def <<(new_token)
    @tokens << new_token
  end

  # Merges this text with the text given in the parameter,
  # returning a new object with the concatenation.
  # @param other_tokenized_text [TokenizedText] the text to
  #     append.
  # @return [TokenizedText] a new instance of {TokenizedText}
  #     with the contents of `self` and the text given in the
  #     parameter.
  def +(other_tokenized_text)
    result = TokenizedText.new
    self.tokens.each do |token|
      result << token
    end
    other_tokenized_text.tokens.each do |token|
      result << token
    end
    result
  end

  # retrieves the {Token} at the given index.
  # @param index [Integer] the index of the requested token.
  # @return [Token | nil] the token object, or `nil` if there
  #     is no token at the given index.
  def [](index)
    @tokens[index]
  end

end