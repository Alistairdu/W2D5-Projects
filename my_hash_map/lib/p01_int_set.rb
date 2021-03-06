class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    validate!(num)
    store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num <= store.length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end

end


class IntSet

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_reader :store

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    store.length
  end

end

class ResizingIntSet

  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      resize! if count > num_buckets
      self[num] << num
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_set = ResizingIntSet.new(num_buckets * 2)
    store.each do |bucket|
      bucket.each do |ele|
        temp_set.insert(ele)
      end
    end
    @store = temp_set.store
  end

end
