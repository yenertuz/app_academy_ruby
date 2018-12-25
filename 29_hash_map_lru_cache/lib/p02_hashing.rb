class Fixnum
  # Fixnum#hash already implemented for you
end

class Array


  def hash
	return 0.hash if self.length == 0
	sub_result = self.reduce { |sum, num|  (sum << 5) + num  }
	to_hash = self.length ^ sub_result
	sub_result.hash
  end
end

class String
  def hash
	return 0.hash if self.length == 0
	sub_result = self.chars.reduce(0) { |sum, num| (sum << 5) + num.bytes[0] }
	to_hash = self.length ^ sub_result
	sub_result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
	return 0.hash if self.length == 0
	arr = self.to_a.sort.flatten
	arr.map! { |x| x.is_a?(Symbol) ? x.to_s.hash : x.hash }
	arr.hash
  end
end
