require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_accessor :count
  attr_reader :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if list.include?(key)
      list.update(key,val) unless list.get(key) == val
    else
      @count += 1
      resize! if @count > num_buckets
      list = bucket(key)
      list.append(key,val)
    end    
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_map = HashMap.new(num_buckets * 2)
    store.each do |linked_list|
      linked_list.each do |node|
        temp_map.set(node.key, node.val)
      end
    end
    @store = temp_map.store
  end

  def bucket(key)
    store[key.hash % num_buckets]
  end

end