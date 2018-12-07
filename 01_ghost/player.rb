class Player

	def initialize(name)
		@name = name
		@losses = 0
	end


	def announce_turn
		puts "current player: " + @name
	end

	def get_guess
		print "enter a letter: "
		gets.chomp
	end

	def invalid_guess
		puts
		puts "invalid guess! try again"
		puts
	end

	def lose_round
		puts @name + " lost this round :( "
		@losses += 1
	end

	def lost?
		@losses >= 5
	end

	def lose_game
		puts @name + " lost the game :( "
	end

end