require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  include Enumerable

  def initialize(num_buckets = 8)
	@store = Array.new(num_buckets) { LinkedList.new }
	@max = num_buckets
    @count = 0
  end

  def include?(key)
	bucket(key).include?(key)
  end

  def set(key, val)
	resize! if @count == @max
	if self.include?(key) == false
		bucket(key).append(key, val)
		@count += 1
		return true
	else
		bucket(key).update(key, val)
	end
	false
  end

  def get(key)
	bucket(key).get(key)
  end

  def delete(key)
	if self.include?(key) == true
		bucket(key).remove(key)
		@count -= 1
		return true
	end
	false
  end

  def each
	@store.each do |bucket2|
		bucket2.each do |node|
			yield [node.key, node.val] if node.key != nil
		end
	end
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
	@max *= 2
	new_store = Array.new(@max) { LinkedList.new  }
	self.each do |(key, val)|
		new_store[key.hash % @max].append(key, val)
	end
	@store = new_store
  end

  def bucket(key)
	# optional but useful; return the bucket corresponding to `key`
	@store[key.hash % @max]
  end
end
