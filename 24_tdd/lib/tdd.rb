class Array 


	def my_uniq
		r = [] 
		self.each { |x| r << x if r.include?(x) == false}
		r
	end

	def two_sum
		r = []
		self.each_with_index do |x1, i1|
			self.each_with_index do |x2, i2|
				if x1 != 0 && x1 + x2 == 0
					r << [i1, i2].sort
				end
			end
		end
		r.uniq
	end
end


def my_transpose(array)
	raise ArgumentError.new("Argument not an array") if array.is_a?(Array) == false
	r = Array.new(array.length) { Array.new(array.length)   }
	(0...array.length).each do |i1|
		(0...array.length).each do |i2|
			r[i1][i2] = array[i2][i1]
		end
	end
	r
end

def stock_picker(stocks)
	raise ArgumentError.new("Argument not an array") if stocks.is_a?(Array) == false
	t = []
	profit = -1
	(0...stocks.length).each do |i1|
		((i1 + 1)...stocks.length).each do |i2|
			new_profit = stocks[i2][1] - stocks[i1][0]
			if new_profit > profit
				t = [i1, i2]
				profit = new_profit
			end
		end
	end
	t
end

class Toh

attr_reader :stacks

	def initialize
		@stacks = [
			[5, 3],
			[4, 1],
			[2]
		]
	end

	def move(start, end_)
		if (@stacks[start][-1] < @stacks[end_][-1])
			@stacks[end_].push(@stacks[start].pop)
			return true
		end
		return false
	end

	def end?
		return true if @stacks.count { |x|  x.empty?   } == 2
		false 
	end
end