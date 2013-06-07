# encoding: utf-8

class Lemma

  attr_accessor :canonical_form
  attr_accessor :forms

  def initialize(param_canonical_form)
    @canonical_form = param_canonical_form
    @forms = Array.new
  end

  def to_s
    "/#{@canonical_form}/ (#{@forms.join(', ')})"
  end

  def add_form(new_form)
    @forms << new_form
  end

end