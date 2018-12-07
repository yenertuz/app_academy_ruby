class Game

	def initialize
		@cards = Array.new(5) { ("A".."Z").to_a.sample(1) }
		@cards += @cards 
		@cards.shuffle!
		@remaining = 10
		@index = nil
		@index2 = nil
	end

	def first_pick
		system("clear")
		self.line_cards
		puts "Pick a card by entering a number between 0 and " + (@remaining - 1).to_s + " :"
		@index = gets.chomp
		while ("0".."9").include?(@index) == false || @index.to_i >= @remaining
			puts "\nInvalid input! Try again: "
			@index = gets.chomp
		end
		@index = @index.to_i
	end

	def second_pick
		system("clear")
		self.line_cards
		puts "Pick another card by entering a number between 0 and " + (@remaining - 1).to_s + " :"
		@index2 = gets.chomp
		while ("0".."9").include?(@index2) == false || @index2.to_i >= @remaining || @index2 == @index
			puts "\nInvalid input! Try again: "
			@index2 = gets.chomp
		end
		@index2 = @index2.to_i
	end


	def line_cards
		indices = [@index, @index2].reject { |x| x == nil }
		to_display = @cards.map.with_index { |x, i| indices.include?(i) ? x : "*" }
		puts to_display.join(" ")
		puts (0...@remaining).to_a.map {|x| x.to_s }.join(" ")
	end

	def process
		system("clear")
		self.line_cards
		sleep(1)
		if @cards[@index] == @cards[@index2]
			to_del = @cards[@index]
			@cards.delete(to_del)
			@remaining -= 2
		end
		@index = nil
		@index2 = nil
	end

	def next_turn
		self.first_pick
		self.second_pick
		self.process
	end

	def play
		puts "\nStarting Game!"
		while @remaining > 0
			self.next_turn
		end
		puts "\nGame Over!"
	end





end