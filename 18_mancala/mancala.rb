require "colorize"
require "./board.rb"

class Mancala

	def initialize
		system("clear")
		print "Enter player1 name (single word): "
		@player1_name = gets.chomp.split[0]
		print "Enter player2 name (single word): "
		@player2_name = gets.chomp.split[0]
		@board = [0, 4, 4, 4, 4, 0, 4, 4, 4, 4]
		@turn = 1
		@winner = 0
		self.play
	end

	def self.get_board_string(board, tur=0, turn=-1)
		str = "%2s %2s %2s %2s" % [board[0], board[1], board[2], board[3]]
		str = str.light_blue if tur == turn
		str = str.yellow if tur == 0
		str
	end

	def is_over?
		if p1_board.all?(0) || p2_board.all?(0)
			if @board[0] > @board[5]
				@winner = @player1_name
			elsif @board[5] > @board[0]
				@winner = @player2_name
			else
				@winner = ""
			end
			return true
		end
		false
	end

	def play
		while self.is_over? == false
			self.next_turn
		end
		puts
		if @winner == ""
			puts "TIE!"
		else
			puts "#{@winner} WINS!"
		end
	end


	def get_input
		puts
		print "Enter a number 0, 1, 2 or 3: "
		input = gets.chomp
		if ("0".."3").include?(input) == false
			puts "Invalid input! Try again"
			return get_input
		end
		input.to_i
	end

	def get_next_current(current)
		return current - 1 if (1..5).include?(current)
		return 6 if current == 0
		return current + 1 if (5..8).include?(current)
		return 5 if current == 9
	end

	def process_input(input)
		current = input
		stones = @board[current]
		@board[current] = 0
		self.render
		@turn == 1 ? special = 0 : special = 5
		@turn == 1 ? counter = 5 : counter = 0
		while stones > 0
			current = get_next_current(current)
			if current != counter
				@board[current] += 1
				stones -= 1
			end
		end
		if @board[current] != 1 && [0, 5].include?(current) == false
			return process_input(current)
		elsif current != special
			@turn = (@turn % 2) + 1
		end
	end

	def next_turn
		self.render
		input = get_input
		input += 1
		input += 5 if @turn == 2
		self.process_input(input)
	end

	def render
		system("clear")
		puts "%4s%s" % ["", self.class.get_board_string([0, 1, 2, 3])]
		puts
		puts "%4s%s" % ["", self.class.get_board_string(p1_board, 1, @turn)]
		puts "%2s%13s%3s" % ["P1", "", "P2"]
		puts "%2s%13s%3s" % [@board[0].to_s, "", @board[5].to_s]
		puts "%4s%s" % ["", self.class.get_board_string(p2_board, 2, @turn)]
	end

	private

	def p1_board
		@board[1..4]
	end

	def p2_board
		@board[6..-1]
	end

end


if __FILE__ == $PROGRAM_NAME
	Mancala.new
end