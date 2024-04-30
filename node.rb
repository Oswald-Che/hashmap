# making a node class for linked_list
class Node
  attr_accessor :next_node, :value, :key

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end
