class Board

	def initialize
		@board = Array.new(9) { Array.new(9) { Tile.new }  }
	end

end