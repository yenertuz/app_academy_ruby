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
	@prev.next = @next
	@next.prev = @prev
  end
end

class LinkedList
	include Enumerable

	attr_reader :length

  def initialize
	@head = Node.new
	@tail = @head
	@head.next = @tail
	@tail.prev = @head
	@length = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
	@head
  end

  def last
	@tail
  end

  def empty?
	@head.next == @tail && @head.key == nil
  end

  def get(key)
	self.each {|node| return node.val if node.key == key   }
	return nil
  end

  def include?(key)
	self.each {|node|  return true if node.key == key  }
	false
  end

  def append(key, val)
	new_node = Node.new(key, val)
	if @head.key == nil
		@head = new_node
		@tail = @head
		@head.next = @tail
		@tail.prev = @head
		@length = 1
	else
		@tail.next = new_node
		@tail.next.prev = @tail
		@tail = @tail.next
		@length += 1
	end
	new_node
  end

  def update(key, val)
	self.each { |node| node.val = val if node.key == key  }
  end

  def remove(key)
	if @length == 1 && @head.key == key
		@head = Node.new
		@tail = @head
		@head.next = @tail
		@tail.prev = @head
		@length = 0
	else
		self.each do |node|
			next if node.key != key
			if node == @head
				@head = @head.next
				@head.prev = nil
			elsif node == @tail 
				@tail = @tail.prev
				@tail.next = nil 
			else
				node.prev.next = node.next
				node.next.prev = node.prev
			end
		end
		@length -= 1
	end
  end

  def each
	pointer = @head
	while pointer != nil
		yield pointer
		break if pointer == pointer.next
		pointer = pointer.next
	end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
