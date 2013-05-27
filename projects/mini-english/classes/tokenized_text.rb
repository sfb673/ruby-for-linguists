# encoding: utf-8

class TokenizedText

  attr_accessor :tokens

  def initialize
    @tokens = Array.new
  end

  def add_token(new_token)
    @tokens << new_token
  end

end