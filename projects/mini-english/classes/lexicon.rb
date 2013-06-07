# encoding: utf-8

class Lexicon

  attr_accessor :lex_entries
  attr_accessor :lemmas


  def self.read_from_file(filename)

    tsv_data = File.read(filename)
    tsv_data = tsv_data.split /\n/
    tsv_data.reject!{ |line| line =~ /^\s*#/ }

    tsv_data = tsv_data.collect do |line|
      line.split /\t/
    end

    lexicon = Lexicon.new

    tsv_data.each do |entry|
      # use form as lemma if no lemma is present
      if entry.size == 2
        entry[2] = entry[0]
      end
      lex_entry = LexEntry.new(lexicon, *entry)
      lexicon.lex_entries << lex_entry
    end

    lexicon
  end

  def initialize
    @lemmas = Array.new
    @lex_entries = Array.new
  end

  def has_lemma?(lemma)
    @lemmas.include?(lemma) || @lemmas.index{|l| l.canonical_form == lemma}
  end

  def get_lemma(lemma)
    @lemmas.find{|l| l.canonical_form == lemma}
  end

  def add_lemma(lemma)
    @lemmas << (lemma.kind_of?(Lemma) ? lemma : Lemma.new(lemma) )
  end

  def all_lex_entries_by_form(form)
    lex_entries.select{|e| e.form == form}
  end

  def all_lex_entries_by_pos(pos)
    lex_entries.select{|e| e.pos == pos}
  end

  def all_lex_entries_by_lemma(lemma)
    lex_entries.select{|e| e.lemma == lemma}
  end

  def all_lex_entries_by_form_and_pos(form, pos)
    lex_entries.select{|e| e.form == form && e.pos == pos}
  end

end