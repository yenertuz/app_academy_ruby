class Array
	def my_each
		i = 0
		while i < self.length
			yield self[i]
			i += 1
		end
	end

	def my_select(&prc)
		r = []
		self.my_each { |n| r << n if prc.(n) }
		r
	end

	def my_reject(&prc)
		r = []
		self.my_each { |n| r << n unless prc.(n) }
		r 
	end

	def my_any?(&prc)
		self.my_each { |n| return true if prc.(n)  }
		false 
	end

	def my_flatten
		self.map { |x| x.is_a?(Array) ? x.flatten : x }
	end

	def my_zip(*arg)
		r = Array.new([])
		self.each_with_index { |x, i| r[i] << self[i] }
		args.each_with_index { |x, i| r[i] << x[i] }
		r
	end

	def my_rotate(p1 = 1)
		r = self.dup
		p1.times { r.push(r.shift) }
		r 
	end

	def my_join(p1 = "")
		self.reduce() { |sum, num| sum.to_s + p1 + num.to_s }
	end

	def my_reverse
		(0...l).map { |i|  }
	end

end
