class Sudoku

	def initialize(sudoku_path)
		@board = File.read(sudoku_path)
		@board = @board.split("\n")
		@lines = (0...9).map { |x|  (0...9).map {|y| [x, y]  }  }
		@columns = (0...9).map { |x|  (0...9).map {|y| [y, x]  }  }
		all_poz = []
		(0..9).each { |x| (0...9).each { |y| all_poz << [x, y] } }
		@squares = []
		@squares = self.get_squares(all_poz)
	end

	def win?
		!(@board.join.include?("0"))
	end

	def get_squares(all_poz)
		row_counter = 0
		column_counter = 0
		temp_array = []
		while row_counter < 3
			column_counter = 0
			while column_counter < 3
				row_min = row_counter * 3
				row_max = row_min + 3
				column_min = column_counter * 3
				column_max = column_min + 3
				temp_array = all_poz.select { |(row, column)| row_min <= row && row < row_max && column_min <= column && column < column_max }
				@squares << temp_array
				column_counter += 1
			end
			row_counter += 1
		end
		@squares
	end

	def print_board
		puts "    " + (0...9).map {|x| "[" + x.to_s + "]" } .join(" ")
		puts
		@board.each_with_index do |x, i|
			print "[" + i.to_s  + "] "
			puts x.chars.map {|x| " " + x + " " }.join(" ")
			puts
		end
	end

	def check_poz_array(poz_array, board_array)
		focus_array = poz_array.map { |(row, column)|  board_array[row][column] }
		(1...9).all? {|x| focus_array.count(x.to_s) <= 1  }
	end

	def check_if_valid(new_board)
		return false if @lines.any? {|x| self.check_poz_array(x, new_board) == false  }
		return false if @columns.any? {|x| self.check_poz_array(x, new_board) == false } 
		return false if @squares.any? {|x| self.check_poz_array(x, new_board) == false }
		true 
	end

	def ask_for_input
		print "Enter a row, columnd and number like \"1 5 3\" (without the quoation marks, separated by spaces): "
		input = gets.chomp
		input = input.split
		(0...3).each { |x| input[x] = input[x].to_i }
		input[2] = input[2].to_s
		input
	end

	def next_move
		system("clear")
		self.print_board
		input = self.ask_for_input
		new_board = @board.join(" ").split
		new_board[input[0]][input[1]] = input[2]
		if self.check_if_valid(new_board) && input[2] != 0
			@board = new_board
		else
			puts
			puts "Invalid move!"
			sleep(1)
		end
	end


	def play
		while self.win? == false
			self.next_move
		end
		system("clear")
		self.print_board
		puts "You win! :-)"
		puts
	end

end