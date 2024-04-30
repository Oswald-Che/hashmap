require_relative 'node'
class LinkedList
  attr_accessor :head
  def intizialize
    @head = nil
  end

  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    tmp = @head
    tmp = tmp.next_node until tmp.next_node.nil?
    tmp.next_node = Node.new(key, value)
  end

  def prepend(key, value)
    @head = Node.new(key, value, @head)
  end

  def size
    return 0 if @head.nil?

    tmp = @head
    count = 0
    until tmp.nil?
      count += 0
      tmp = tmp.next_node
    end
    count
  end

  def tail
    tmp = @head
    tmp = tmp.next_node until tmp.next_node.nil?
    tmp
  end

  def at(index)
    tmp = @head
    count = 0
    until count == index
      tmp = tmp.next_node
      count += 1
    end
    tmp
  end

  def pop
    tmp = @head
    tmp = tmp.next_node while tmp.next_node != tail
    last = tmp.next_node
    tmp.next_node = nil
    last
  end

  def contains?(key)
    tmp = @head
    until tmp.nil?
      return true if tmp.key == key
      tmp = tmp.next_node
    end
    false
  end

  def find(key)
    tmp = @head
    count = 0
    index = nil
    until tmp.nil?
      index = count if tmp.key == key
      tmp = tmp.next_node
      count += 1
    end
    index
  end

  def to_s
    tmp = @head
    str = ''
    until tmp.nil?
      str += "( #{[tmp.key, tmp.value]}  ) -> "
      tmp = tmp.next_node
    end
    str + 'nil'
  end

  def insert_at(key, value, index)
    return prepend(key, value) if index.zero?

    tmp = at(index - 1)
    tmp.next_node = Node.new(key, value, tmp.next_node)
  end

  def delete_at(index)
    return @head = @head.next_node if index.zero?

    tmp = at(index - 1)
    tmp.next_node = tmp.next_node.next_node
  end
end

