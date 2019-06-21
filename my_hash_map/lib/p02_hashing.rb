class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    string_element_ints = self.map.with_index do |el,i|
      if el.is_a?(String)
        (el.ord ^ i).to_s(2)
      else
        (el ^ i).to_s(2)
      end
    end
    string_element_ints.join("").to_i.hash
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |k,v|
      arr << (k.to_s.hash ^ v.to_s.hash).to_s
    end
    arr.map(&:to_i).sort.hash
  end
end
