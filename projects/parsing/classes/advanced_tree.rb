# encoding: utf-8

class AdvancedTree

  attr_accessor :children

  def initialize
    @children = []
  end


  def add_node(node, position=nil)
    if position.nil?
      children << node
    else
      children.insert(position, node)
    end
  end

  def to_s
    children.collect{|c| c.to_s}.join(' ')
  end

  def leaves
    children.collect{|c| c.collect_leaves}.flatten
  end

  def roots
    children
  end

end