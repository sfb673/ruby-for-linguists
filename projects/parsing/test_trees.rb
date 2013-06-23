
%w(advanced_tree advanced_tree_node).each do |kl|
  require File.join(File.dirname(__FILE__), '..', 'mini-english', 'classes', kl)
end

tree = AdvancedTree.new

a = AdvancedTreeNode.new("A", tree)
b = AdvancedTreeNode.new("B", tree)
c = AdvancedTreeNode.new("C", tree)
d = AdvancedTreeNode.new("D", tree)
e = AdvancedTreeNode.new("E", tree)

tree.children << a
tree.children << b
tree.children << c
tree.children << d
tree.children << e


#tree << k
#tree.group_under_parent(k, [b, c, d])

puts "TREE"
puts tree.to_s
puts tree.children


k = AdvancedTreeNode.new("K", tree)
tree.add_node(k, 1)

puts "TREE"
puts tree.to_s
puts tree.children

k.add_child(b)
k.add_child(c)
k.add_child(d)


puts "TREE"
puts tree.to_s
puts tree.children


puts tree.leaves.to_s
puts tree.roots.to_s