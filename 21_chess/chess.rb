require "./tile.rb"
require "./move.rb"
require "./player.rb"
require "io/console"

class String
	def black;          "\e[30m#{self}\e[0m" end
	def red;            "\e[31m#{self}\e[0m" end
	def green;          "\e[32m#{self}\e[0m" end
	def brown;          "\e[33m#{self}\e[0m" end
	def blue;           "\e[34m#{self}\e[0m" end
	def magenta;        "\e[35m#{self}\e[0m" end
	def cyan;           "\e[36m#{self}\e[0m" end
	def gray;           "\e[37m#{self}\e[0m" end
	def yellow;         "\e[33m#{self}\e[0m" end
	def pink;           "\e[35m#{self}\e[0m" end
	
	def bg_black;       "\e[40m#{self}\e[0m" end
	def bg_red;         "\e[41m#{self}\e[0m" end
	def bg_green;       "\e[42m#{self}\e[0m" end
	def bg_brown;       "\e[43m#{self}\e[0m" end
	def bg_blue;        "\e[44m#{self}\e[0m" end
	def bg_magenta;     "\e[45m#{self}\e[0m" end
	def bg_cyan;        "\e[46m#{self}\e[0m" end
	def bg_gray;        "\e[47m#{self}\e[0m" end 
	def bg_white;       "\e[47;1m#{self}\e[0m" end
	
	def bold;           "\e[1m#{self}\e[22m" end
	def italic;         "\e[3m#{self}\e[23m" end
	def underline;      "\e[4m#{self}\e[24m" end
	def blink;          "\e[5m#{self}\e[25m" end
	def reverse_color;  "\e[7m#{self}\e[27m" end
	def no_colors
		self.gsub /\e\[\d+m/, ""
	  end
end

class Chess

	KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

	def self.start_game
		system "clear"
		@player1 = Player.from_input
		@player2 = Player.from_input
		@turn = @player1
		@selection = false
		@cursor = [0, 0]
		@board = Array.new(8) do |row|
			Array.new(8) do |column|
				type = ""
				case column
				when 0, 7
					type = :rook
				when 1, 6
					type = :knight
				when 2, 5
					type = :bishop
				when 3
					type = :king
				when 4
					type = :queen
				end

				poz = [row, column]
				case row
				when 0
					Tile.new(poz, type, @player1)
				when 1
					Tile.new(poz, :pawn, @player1)
				when 6
					Tile.new(poz, :pawn, @player2)
				when 7
					Tile.new(poz, type, @player2)
				else
					Tile.new(poz, :nil)
				end
			end
		end
		@is_over = false
		@board[@cursor[0]][@cursor[1]].place_cursor
		@check = false
		play
	end

	def self.read_char
		STDIN.echo = false # stops the console from printing return values
	
		STDIN.raw! # in raw mode data is given as is to the program--the system
					 # doesn't preprocess special characters such as control-c
	
		input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
								 # numeric keycode. chr returns a string of the
								 # character represented by the keycode.
								 # (e.g. 65.chr => "A")
	
		if input == "\e" then
		  input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
													   # at most maxlen bytes from a
													   # data stream; it's nonblocking,
													   # meaning the method executes
													   # asynchronously; it raises an
													   # error if no data is available,
													   # hence the need for rescue
	
		  input << STDIN.read_nonblock(2) rescue nil
		end
	
		STDIN.echo = true # the console prints return values again
		STDIN.cooked! # the opposite of raw mode :)
	
		return input
	  end

	def self.print_board(board)
		system "clear"
		board.each do |row|
			row.each do |tile|
				print tile.output + "  "
			end
			puts; puts
		end
	end

	def self.play
		while @is_over == false
			print_board(@board)
			print "\nCHECK!" if @check == true
			move = KEYMAP[read_char]
			temp = @turn
			process_move(move)
		end
	end

	def self.valid_move?(move)
		new_cursor = [@cursor[0], @cursor[1]]
		case move
		when :left
			new_cursor[1] -= 1
		when :right
			new_cursor[1] += 1
		when :up
			new_cursor[0] -= 1
		when :down
			new_cursor[0] += 1
		end
		new_cursor.all? { |x| (0..7).include?(x)  }
	end

	def self.update_cursor(move)
		new_cursor = [@cursor[0], @cursor[1]]
		case move
		when :left
			new_cursor[1] -= 1
		when :right
			new_cursor[1] += 1
		when :up
			new_cursor[0] -= 1
		when :down
			new_cursor[0] += 1
		end
		@board[@cursor[0]][@cursor[1]].remove_cursor
		@cursor = new_cursor
		@board[@cursor[0]][@cursor[1]].place_cursor
	end

	def self.process_selection 
		if @selection == false && @board[@cursor[0]][@cursor[1]].player == @turn
			@selection = [@cursor[0], @cursor[1]]
			@board[@selection[0]][@selection[1]].place_select
		elsif @selection != false && @cursor == @selection
			remove_selection
			@board[@cursor[0]][@cursor[1]].place_cursor
		elsif @selection != false && moves(@selection).include?(@cursor)
			@board[@selection[0]][@selection[1]].remove_select
			@board[@selection[0]][@selection[1]].place_cursor
			@board[@cursor[0]][@cursor[1]] = @board[@selection[0]][@selection[1]]
			@board[@selection[0]][@selection[1]] = Tile.new(0, :nil)
			@selection = false
			@check = is_check(@turn)
			@turn == @player1 ? @turn = @player2 : @turn = @player1
		end
	end

	def self.remove_selection
		if @selection
			@board[@selection[0]][@selection[1]].remove_select
			@selection = false
		end
	end

	def self.process_move(move)
		case move
		when :up, :down, :left, :right
			update_cursor(move) if valid_move?(move)
		when :return, :newline, :space
			process_selection
		when :escape
			remove_selection
		when :ctrl_c
			Process.exit(0)
		end
	end

	def self.is_check(turn)
		r = []
		@board.each_with_index do |row, idx|
			row.each_with_index do |tile, idx2|
				if tile.type == :king && tile.player != turn
					r = [idx, idx2]
				end
			end
		end
		@board.each_with_index do |x, x_i|
			x.each_with_index do |y, y_i|
				return true if y.player == turn &&  moves([x_i, y_i]).include?(r) 
			end
		end
		false
	end


	# MOVES

	def self.moves_rook(start)
		r = []
		temp = [start[0], start[1] + 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[1] += 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0], start[1] - 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[1] -= 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0] + 1, start[1]]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] += 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0] - 1, start[1]]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] -= 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		r
	end

	def self.moves_bishop(start)
		r = []
		temp = [start[0] + 1, start[1] + 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] += 1
			temp[1] += 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0] + 1, start[1] - 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] += 1
			temp[1] -= 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0] - 1, start[1] + 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] -= 1
			temp[1] += 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		temp = [start[0] - 1, start[1] - 1]
		while (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].type == :nil
			r << temp.dup
			temp[0] -= 1
			temp[1] -= 1
		end
		r << temp.dup if (temp.all? { |x|  (0..7).include?(x)  })  && @board[temp[0]][temp[1]].player != @turn
		r
	end

	def self.moves_king(start)
		a = start[0]
		b = start[1]
		r = [
			[a, b + 1],
			[a, b - 1],
			[a + 1, b],
			[a + 1, b + 1],
			[a + 1, b - 1],
			[a - 1, b],
			[a - 1, b + 1],
			[a - 1, b - 1]
	]
		r.select! { |x|  (0..7).include?(x[0]) && (0..7).include?(x[1])   }
		r.reject { |x| @board[x[0]][x[1]].player == @turn   }
	end

	def self.moves_knight(start)
		a = start[0]
		b = start[1]
		r = [
			[a - 1, b + 2],
			[a + 1, b + 2],
			[a + 2, b + 1],
			[a + 2, b - 1],
			[a + 1, b - 2],
			[a - 1, b - 2],
			[a - 2, b - 1],
			[a - 2, b + 1]
	]
		r.select! { |x|  (0..7).include?(x[0]) && (0..7).include?(x[1])   }
		r.reject {|x|  @board[x[0]][x[1]].player == @turn        }
	end

	def self.moves_pawn(start)
		r = []
		a = start[0]
		b = start[1]
		@turn == @player1 ? to_add = 1 : to_add = -1
		return [] if (0..7).include?(a) == false
		r << [a + to_add, b] if @board[a + to_add][b].type == :nil
		r << [a + to_add, b + 1] if (0..7).include?(b + 1) && @board[a + to_add][b + 1].player != @turn
		r << [a + to_add, b - 1] if (0..7).include?(b - 1) && @board[a + to_add][b - 1].player != @turn
		r
	end

	def self.moves(start)
		type = @board[start[0]][start[1]].type
		case type
		when :rook 
			moves_rook(start)
		when :bishop
			moves_bishop(start)
		when :king 
			moves_king(start)
		when :pawn
			moves_pawn(start)
		when :queen
			moves_rook(start) + moves_bishop(start)
		when :knight
			moves_knight(start) 
		end
	end





	# END MOVES




end

Chess.start_game