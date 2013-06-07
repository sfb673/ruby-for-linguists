# encoding: utf-8

class SimpleTree

  attr_accessor :nodes

  def initialize
    @nodes = Array.new
    @edges = Array.new
  end

  def roots()
    @nodes - @edges.collect{|e| e[1]}
  end

  def leaves()
    @nodes - @edges.collect{|e| e[0]}
  end

  def add_node(node)
    node.tree=self
    @nodes << node
  end

  def link(parent, child)
    # remove all other links where child has another parent
    @edges.reject!{|e| e[1]==child}
    @edges << [parent, child]
  end

  def size
    @nodes.size
  end

  def empty?
    size==0
  end

  def child_count(node)
    @edges.select{|e| e[0]==node }.size
  end

  def is_root?(node)
    @edges.select{|e| e[1]==node }.empty?
  end

  def is_leaf?(node)
    child_count(node)==0
  end

  def root_count()
    roots.size
  end

  def leaf_count()
    leaves.size
  end

  def children(node)
    @edges.select{|e| e[0]==node }.collect{|e| e[1] }
  end

  def parent(node)
    @edges.select{|e| e[1]==node }.collect{|e| e[0] }.first
  end

end