class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @count += 1
      resize! if count > num_buckets
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_set = HashSet.new(num_buckets * 2)
    store.each do |bucket|
      bucket.each do |ele|
        temp_set.insert(ele)
      end
    end
    @store = temp_set.store
  end

end