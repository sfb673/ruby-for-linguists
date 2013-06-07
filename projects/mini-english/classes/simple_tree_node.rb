# encoding: utf-8

class SimpleTreeNode

  attr_accessor :tree
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def children
    @tree.children(self)
  end

  def parent
    @tree.parent(self)
  end

  def is_root?
    @tree.is_root?(self)
  end

  def is_leaf?
    @tree.is_leaf?(self)
  end

end