require "./player.rb"

class Tile

	attr_reader :char

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
	end

end

test = Tile.new([0,0], :nil)
p test.char