class WordChainer

	def initialize(first_word, second_word)
		@first_word = first_word
		@second_word = second_word
		raise "First word and second word cannot be of different length" if first_word.length != second_word.length
		raise "First word and second word are the same ..." if first_word == second_word
		@dictionary = Hash.new(0)
		File.read("dictionary.txt").split("\n").each { |x| @dictionary[x] = 1 }
		raise "First word does not exist!" if @dictionary[@first_word] != 1
		raise "Second word does not exist!" if @dictionary[@second_word] != 1
		l = first_word.length
		@dictionary = @dictionary.keys.select { |x| x.length == l }
		@is_solved = 0
		self.try
	end

	def try
		@stack = [[@first_word.dup, []]]
		while @stack.length > 0 && @dictionary.length > 0 && @is_solved == 0
			self.next_word
		end
		if @is_solved == 1
			puts @solution
		else
			puts "Cannot find a word chain between #{@first_word} and #{@second_word}"
		end
	end


	def char_diffs(word1, word2)
		word1_chars = word1.chars 
		word2_chars = word2.chars
		matches = 0
		(0...word1_chars.length).each { |i| matches += 1 if word1_chars[i] == word2_chars[i] }
		return word2_chars.length - matches
	end

	def is_match?(p1, p2)
		return false if p1.length != p2.length
		return false if self.char_diffs(p1, p2) != 1
		true
	end


	def get_matches(word)
		r = []
		@dictionary.each_with_index {|x, i| (r << x ; @dictionary.delete(x))  if self.is_match?(word, x)   }
		r 
	end

	def next_word
		current = @stack[0]
		current_word = current[0]
		current_history = current[1]
		matches = self.get_matches(current_word)
		if matches.length != 0
			if matches.include?(@second_word)
				@is_solved = 1
				@solution = current_history + [current_word] + [@second_word]
				return 
			end
			@stack += matches.map { |x| [x, current_history + [current_word]]   }
		end
		@stack.delete_at(0)
	end

end

if __FILE__ == $PROGRAM_NAME
	WordChainer.new(ARGV[0].to_s, ARGV[1])
end