class MaxIntSet
  def initialize(max)
	@store = Array.new(max) {false}
	@max = max
  end

  def insert(num)
	#raise ArgumentError.new("Can only accept integers") if num.is_a? FixNum == false
	raise ArgumentError.new("Out of bounds") if num < 0
	raise ArgumentError.new("Out of bounds") if num >= @max
	if @store[num] == false
		@store[num] = true
		return true
	else
		return false
	end
  end

  def remove(num)
	#raise ArgumentError.new("Can only accept integers") if num.is_a? FixNum == false
	raise ArgumentError.new("Out of bounds") if num < 0
	raise ArgumentError.new("Out of bounds") if num >= @max
	@store[num] = false
  end

  def include?(num)
	#raise ArgumentError.new("Can only accept integers") if num.is_a? FixNum == false
	raise ArgumentError.new("Can only accept non-negative numbers") if num < 0
	raise ArgumentError.new("Invalid argument: #{num} is greater than #{@max}") if num >= @max
	return @store[num]
  end

  private

  def is_valid?(num)
	return true if 0 <= num && num < max
	false
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
	@store = Array.new(num_buckets) { Array.new }
	@size = num_buckets
  end

  def insert(num)
	if self[num].include?(num) == false
		self[num].push num
		return true
	end
	false
  end

  def remove(num)
	if self[num].include?(num) == true
		self[num].delete num
		return true
	end
	false
  end

  def include?(num)
	return self[num].include?(num)
  end

  private

  def [](num)
	# optional but useful; return the bucket corresponding to `num`
	@store[num % @size]
  end

  def num_buckets
    @size
  end
end

class ResizingIntSet
  attr_reader :count, :max, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
	@count = 0
	@max = num_buckets
  end

  def insert(num)
	resize! if @count == @max
	if self[num].include?(num) == false
		self[num].push(num)
		@count += 1
		return true
	end
	false
  end

  def remove(num)
	if self[num].include?(num) == true
		self[num].delete(num)
		@count -= 1
		return true
	end
	false
  end

  def include?(num)
	self[num].include?(num)
  end

  private

  def [](num)
	# optional but useful; return the bucket corresponding to `num`
	@store[num % @max]
  end

  def num_buckets
    @max
  end

  def resize!
	@max *= 2
	new_store = Array.new(@max) {Array.new}
	@store.each do |bucket|
		bucket.each do |number|
			new_store[number % @max].push(number)
		end
	end
	@store = new_store
  end
end
