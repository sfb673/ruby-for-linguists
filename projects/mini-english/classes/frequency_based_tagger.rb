# encoding: utf-8

require 'singleton'

class FrequencyBasedTagger

  include Singleton

  attr_reader :frequency_map

  def train(corpus_file)
    corpus = File.read(corpus_file)
    corpus_items = corpus.split /\n/
    @frequency_map = Hash.new
    corpus_items.each do |i|
      j = i.strip
      tokens = j.split /\s+/
      tokens.each do |t|
        token_parts = t.split '/'
        frm = token_parts[0]
        cat = token_parts[1]
        # add map entry, if there is no entry for this form
        frequency_map[frm] = [] unless frequency_map.has_key?(frm)
        # just put cat to the end of the array.
        # COULD BE MORE EFFICIENT!
        frequency_map[frm] << cat
      end
    end
  end

  def tag(tokenized_text, lexicon)
    result = TokenizedText.new
    tokenized_text.tokens.each do |token|
      r_token = Token.new(token.wordform)
      # more advanced: ask frequency map for most frequent pos, then take the
      # matching entry from the lexicon.
      pos = get_pos_for_form(token.wordform)
      lex_entries = lexicon.all_lex_entries_by_form_and_pos(token.wordform, pos)
      if lex_entries.size > 0
        r_token.pos = lex_entries.first.pos
        r_token.lemma = lex_entries.first.lemma
      end
      result << r_token
    end

    result
  end

  # looks for the most frequent pos associated with the given form and returns it.
  def get_pos_for_form(form)
    entry = @frequency_map[form]
    most_common_value(entry)
  end

  private

  # Returns the entry from an array that has the most occurrences.
  # For [1,1,1,2,2,3] this would return 1.
  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first
  end

end