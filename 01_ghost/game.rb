class Game

	def initialize(p1, p2)
		@fragment = ""
		@players = [p1, p2].shuffle
		@dictionary = Hash.new(0)
		File.read("dictionary.txt").split("\n").each { |x| @dictionary[x] = 1 }
		@losses = Hash.new(0)
	end


	def round_over?
		if @fragment.length > 2 && @dictionary[@fragment] == 1
			return true
		end
		false
	end

	def check_guess(guess)
		return false if guess.length != 1
		return false if ("a"..."z").include?(guess.downcase) == 0
		return false if @dictionary.keys.none? { |key| key.index(@fragment + guess) == 0 }
		true
	end

	def next_turn
		current_player = @players[0]
		current_player.announce_turn
		puts "current fragment is: " + @fragment
		guess = current_player.get_guess
		while self.check_guess(guess) == false
			current_player.invalid_guess
			guess = current_player.get_guess
		end
		@fragment += guess
		@players.rotate!
		puts
		current_player.lose_round if self.round_over?
	end


	def play_round
		@fragment = ""
		puts "starting round"
		puts ""
		while self.round_over? == false
			self.next_turn
		end
		puts
		puts "end of round"
	end


	def play
		while @players.none? {|player| player.lost? }
			self.play_round
		end
		puts "game over!"
		@players.select {|player| player.lost? }[0].lose_game
	end

end