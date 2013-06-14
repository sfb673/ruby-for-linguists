class Array

  def most_common_value
    self.group_by do |e|
      e
    end.values.max_by(&:size).first
  end

end

puts [1,1,1,1,2,3,4,4,5].most_common_value
