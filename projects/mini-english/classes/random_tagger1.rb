# encoding: utf-8

class RandomTagger1 < AbstractRandomTagger

  def get_pos_for_form(form)
    poses.sample
  end

end