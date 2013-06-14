# encoding: utf-8

class RandomTagger3 < AbstractRandomTagger

  def get_pos_for_form(form)
    entry = @frequency_map[form]
    return entry.sample
  end

end