# encoding: utf-8

class AdvancedTreeNode

  attr_accessor :tree

  attr_accessor :value

  attr_accessor :children

  attr_accessor :parent

  def initialize(value, tree)
    @tree = tree
    @value = value
    @parent = nil
    @children = []
  end

  def child_count
    children.size
  end

  def is_leaf?
    children.empty?
  end

  def is_root?
    tree.is_root?(self)
  end

  def add_child(child_node, position=nil)
    child_node.tree = self.tree
    child_node.parent = self.parent
    if position.nil?
      children << child_node
    else
      children.insert(position, child_node)
    end
    tree.children.delete(child_node)
  end

  def set_parent(new_parent, position=nil)
    new_parent.add_child(self, position)
  end

  def to_s
    "[#{display_value} #{children_to_s}]"
  end

  def children_to_s
    children.collect{|c| c.to_s}.join(' ')
  end

  def collect_leaves
    return [self] if is_leaf?
    return children.collect{|c| c.collect_leaves}.flatten
  end

  def display_value
    value
  end

end