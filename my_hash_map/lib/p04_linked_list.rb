class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    # each_with_index { |link, j| return link if i == j }
    # nil
    idx = -1
    check_node = @head
    until i == idx
      check_node = check_node.next
      idx += 1
    end
    check_node
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil if empty?
    check_node = @head
    until check_node == @tail
      check_node = check_node.next
      break if check_node.key == key
    end
    check_node == @tail ? nil : check_node.val
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    if include?(key)
      check_node = @head
      until check_node.key == key
        check_node = check_node.next
      end
      check_node.val = val
    end
  end

  def remove(key)
    if include?(key)
      check_node = @head
      until check_node.key == key
        check_node = check_node.next
      end
      prev_node = check_node.prev
      next_node = check_node.next
      prev_node.next, next_node.prev = next_node, prev_node
    end
  end

  def each(&prc)
    unless empty? 
      check_node = first
      until check_node == @tail
        prc.call(check_node)
        check_node = check_node.next
      end
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
