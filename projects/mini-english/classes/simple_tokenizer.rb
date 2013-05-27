# encoding: utf-8

class SimpleTokenizer

  def tokenize(string)
    tt = TokenizedText.new
    string.split(/\s*\b/).each do |raw_token|
      tt << Token.new(raw_token)
    end
    tt
  end

  def tokenize_file(filename)
    tokenize(File.read(filename))
  end

end