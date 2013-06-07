# encoding: utf-8

class LexEntry

  attr_accessor :lexicon
  attr_accessor :form
  attr_accessor :pos
  attr_accessor :lemma

  def initialize(param_lexicon, param_form, param_pos, param_lemma)
    @lexicon = param_lexicon
    @form = param_form
    @pos = param_pos

    if @lexicon.has_lemma?(param_lemma)
      @lemma = @lexicon.get_lemma(param_lemma)
    else
      @lemma = Lemma.new(param_lemma)
      @lexicon.add_lemma(@lemma)
    end
    @lexicon.get_lemma(param_lemma).add_form param_form
  end

  def to_s
    "#{form} <#{pos}> /#{lemma.to_s}/"
  end

end