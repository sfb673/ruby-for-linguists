# encoding: utf-8

class SimpleTagger

  include Singleton

  def tag(tokenized_text, lexicon)
    result = TokenizedText.new

    tokenized_text.tokens.each do |token|
      r_token = Token.new(token.wordform)
      lex_entries = lexicon.all_lex_entries_by_form(token.wordform)
      # keep it simple: just take the first one
      if lex_entries.size > 0
        r_token.pos = lex_entries.first.pos
        r_token.lemma = lex_entries.first.lemma
      end
      result << r_token
    end

    result
  end
end