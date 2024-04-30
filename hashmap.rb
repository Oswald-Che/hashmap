require_relative 'linked_list'
require_relative 'node'

class HashMap
  attr
  def initialize
    @bucket_length = 16
    @buckets = Array.new(@bucket_length)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = hash(key) % @bucket_length
    if @buckets[index].nil?
      @buckets[index] = LinkedList.new
      @buckets[index].append(key, value)
    elsif @buckets[index].contains?(key)
      tmp = @buckets[index].at(@buckets[index].find(key))
      tmp.value = value
    else
      @buckets[index].append(key, value)
    end
    load_factor
  end

  def get(key)
    index = hash(key) % @bucket_length
    return nil if @buckets[index].nil?

    @buckets[index].at(@buckets[index].find(key)).value
  end

  def load_factor
    return unless (@buckets.compact.length / @bucket_length.to_f) > 0.75

    @bucket_length *= 2
    buckets_old = @buckets
    @buckets = Array.new(@bucket_length)
    buckets_old.each do |item|
      next if item.nil?

      tmp = item.head
      until tmp.nil?
        set(item.key, item.value)
        tmp = tmp.next_node
      end
    end
  end

  def has?(key)
    index = hash(key) % @bucket_length
    return false if @buckets[index].nil?

    @buckets[index].contains?(key)
  end

  def remove_key(key)
    index = hash(key) % @bucket_length
    return nil if @buckets[index].nil?

    tmp = @buckets[index]
    pos = tmp.find(key)
    item = tmp.at(pos)
    tmp.delete_at(pos)
    item.value
  end

  def length
    @buckets.inject(0) do |count, item|
      next(count) if item.nil?

      count = count + 1 + item.size
      count
    end
  end
  
  def clear
    @buckets = Array.new(@bucket_length)
  end

  def keys
    @buckets.inject([]) do |key_array, item|
      next(key_array) if item.nil?

      tmp = item.head
      until tmp.nil?
        key_array << tmp.key
        tmp = tmp.next_node
      end
      key_array
    end
  end

  def values
    @buckets.inject([]) do |value_array, item|
      next(value_array) if item.nil?

      tmp = item.head
      until tmp.nil?
        value_array << tmp.value
        tmp = tmp.next_node
      end
      value_array
    end
  end

  def entries
    @buckets.inject([]) do |array, item|
      next(array) if item.nil?

      tmp = item.head
      until tmp.nil?
        array << [tmp.key, tmp.value]
        tmp = tmp.next_node
      end
      array
    end
  end
  
end

hashmap = HashMap.new
