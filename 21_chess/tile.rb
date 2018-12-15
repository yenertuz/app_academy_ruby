require "./player.rb"

class Tile

	attr_reader :char, :output, :type, :player

	CHAR_MAP = {
		king: "♚",
		queen: "♛",
		rook: "♜",
		bishop: "♝",
		knight: "♞",
		pawn: "♟",
		nil: "*"
	}

	def initialize(poz, type=:nil, player=nil)
		@row = poz[0]
		@column = poz[1]
		@type = type
		@char = CHAR_MAP[@type]
		@output = @char
		@player = player
		self.get_char
	end

	def get_char
		@char = CHAR_MAP[@type]
		return if @player == nil
		if @player.number == 1
			@char = @char.red
		elsif @player.number == 2
			@char = @char.blue
		end
		@output = @char
	end

	def place_cursor
		@output = @char.reverse_color if @output == @char
	end

	def place_select
		@output = @char.no_colors.yellow
	end

	def remove_select
		@output = @char
	end

	def remove_cursor
		@output = @char if @output == @char.reverse_color
	end

end