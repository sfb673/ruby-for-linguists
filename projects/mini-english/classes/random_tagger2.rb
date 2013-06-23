# encoding: utf-8

class RandomTagger2 < AbstractRandomTagger

  def get_pos_for_form(form)
    entry = @frequency_map[form]
    available_entries = entry.uniq
    return available_entries.sample
  end

end