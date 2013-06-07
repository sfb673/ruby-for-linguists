#!/usr/bin/env ruby
# encoding: utf-8

require './classes/simple_tree'
require './classes/simple_tree_node'

tree = SimpleTree.new
np = SimpleTreeNode.new "NP"
d  = SimpleTreeNode.new "D"
n  = SimpleTreeNode.new "N"
tree.add_node np
tree.add_node d
tree.add_node n
tree.link(np, d)
tree.link(np, n)
puts "NP root? %s" % np.is_root?
puts "NP leaf? %s" % np.is_leaf?
puts "D  root? %s" % d.is_root?
puts "D  leaf? %s" % d.is_leaf?
puts tree.root_count
puts tree.leaf_count