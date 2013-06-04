# encoding: utf-8

# a simple tokenizer that splits a string into tokens
# based on a regular expression and returns a
# {TokenizedText} objecct.
class SimpleTokenizer

  include Singleton

  # Tokenizes the string contained in the given parameter and
  # returns an untagged {TokenizedText} version of it.
  # @param string [String] the raw text to be tokenized
  # @return [TokenizedText] a tokenized text version of the
  #     given parameter
  def tokenize(string)
    tt = TokenizedText.new
    string.split(/\s*\b/).each do |raw_token|
      tt << Token.new(raw_token)
    end
    tt
  end

  # Tokenizes the contents of the file whose name
  # was given as a parameter and
  # returns an untagged {TokenizedText} version of it.
  # @param filename [String] the path to the file to be tokenized
  # @return [TokenizedText] a tokenized text version of the
  #     given parameter
  def tokenize_file(filename)
    tokenize(File.read(filename))
  end

end