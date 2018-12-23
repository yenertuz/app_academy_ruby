class LRUCache

	def initialize(num=0)
		@cache = Array.new(num)
		@num = num
	end

	def add(element)
		@cache.delete(element)
		@cache.push(element)
		if @cache.length > @num
			@cache.shift
		end
	end

	def show
		p @cache
	end

	def count
		@cache.length
	end

end

