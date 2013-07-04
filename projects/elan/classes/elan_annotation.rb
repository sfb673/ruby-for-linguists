# encoding: utf-8

class ElanAnnotation

  attr_accessor :tier, :min, :max, :value

  def initialize(tier, min, max, value)
    @tier = tier
    @min = min
    @max = max
    @value = value

  end

  def duration
    @max - @min
  end


  def describe
    "[%i,%i] (%i): %s" % [min, max, duration, value]
  end

end