class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
	@count = 0
	@max = num_buckets
  end

  def insert(key)
	resize! if @count == @max
	if self[key].include?(key) == false
		self[key].push(key)
		@count += 1
		return true
	end
	false
  end

  def include?(key)
	self[key].include?(key)
  end

  def remove(key)
	if self[key].include?(key)
		self[key].delete(key)
		@count -= 1
		return true
	end
	false
  end

  private

  def [](num)
	# optional but useful; return the bucket corresponding to `num`
	@store[num.hash % @max]
  end

  def num_buckets
    @store.length
  end

  def resize!
	@max *= 2
	new_store = Array.new(@max) { Array.new }
	@store.each do |bucket|
		bucket.each do |element|
			new_store[element.hash % @max].push(element)
		end
	end
	@store = new_store
  end
end
