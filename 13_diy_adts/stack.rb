class Stack

	def initialize
		@stack = []
	end

	def push(el)
		@stack.push(el)
	end

	def pop(el)
		@stack.pop 
	end

	def peek()
		@stack[-1]
	end

end