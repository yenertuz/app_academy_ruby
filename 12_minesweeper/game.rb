require "./tile.rb"
require "colorize"

class Minesweeper

	def initialize
		@board = Array.new(10) { Array.new(10) { Tile.new } }
		@is_loss = 0
	end

	def render
		system("clear")
		puts "  0 1 2 3 4 5 6 7 8 9".yellow
		(0..9).each do |i|
			puts
			print i.to_s.yellow + " "
			@board[i].each { |tile|  print tile.render; print " "  }
			puts
		end
		puts
	end

	def game_over?
		return true if @is_loss == 1
		return false if @board.any? do |row|
			row.any? do |tile|
				tile.is_unrevealed_bomb?
			end
		end
		true
	end

	def is_valid_input?(input)
		return false if "rf".include?(input[0]) == false
		return false if (0..9).include?(input[1]) == false 
		return false if (0..9).include?(input[2]) == false
		return true
	end

	def get_input
		print "Enter an action (r for reveal or f for flag lowercase) and two digits (ex: r05 or f36): "
		input = gets.chomp
		while self.is_valid_input?(input) == 0
			print "Invalid input! Try again: "
			input = gets.chomp
		end
		input
	end

	def get_neighbors(coors)
		r = []
		[-1, 0, 1].each do |add_to_x|
			[-1, 0, 1].each do |add_to_y|
				new_x = coors[0] + add_to_x
				new_y = coors[1] + add_to_y
				if new_x.to_s.length == 1 && new_y.to_s.length == 1
					r << [new_x, new_y]
				end
			end
		end
		r
	end

	def count_neighbors(coor_arr)
		coor_arr.reduce(0) { |sum, num|  sum + @board[num[0]][num[1]].is_mine  }
	end

	def reveal_recursively(coors)
		neighbors = self.get_neighbors(coors)
		neighbor_count = self.count_neighbors(neighbors)
		@board[coors[0]][coors[1]].reveal(neighbor_count)
		if neighbor_count == 0
			neighbors.each do |target|
				self.reveal_recursively(target) if @board[target[0]][target[1]].render == "*"
			end
		end
	end

	def process_input(input)
		x_coor = input[1].to_i 
		y_coor = input[2].to_i
		action = input[0]
		if action == "r"
			coors = [x_coor, y_coor]
			target = @board[x_coor][y_coor]
			break if target.is_revealed == 1
			if target.is_mine == 1
				target.reveal
				@is_loss = 1
			else
				self.reveal_recursively(coors)
			end
		elsif action == "f"
			@board[x_coor][y_coor].flag
		end
	end

	def next_turn
		self.render
		input = self.get_input
		self.process_input(input)
	end

	def play
		while self.game_over? == false
			self.next_turn
		end
		self.render
		puts "You win, this time ..." if @is_loss != 1
		#self.announce_result
	end
end

Minesweeper.new.play