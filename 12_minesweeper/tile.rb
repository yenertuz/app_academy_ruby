class Tile

	attr_reader :is_mine, :is_revealed

	def initialize
		rand(0..5) == 0 ? @is_mine = 1 : @is_mine = 0
		@is_mine = @is_mine.to_i
		@is_revealed = 0
		@is_flagged = 0
		@render_character = "*"
	end

	def is_unrevealed_bomb?
		return true if @is_mine == 1 && @is_flagged == 0
		false
	end

	def render
		@render_character
	end

	def flag
		if @is_flagged == 0 && @is_revealed == 0
			@is_flagged = 1
			@render_character = "F".light_blue
		elsif @is_flagged == 1 && @is_revealed == 0
			@is_flagged = 0
			@render_character = "*"
		end
		return @render_Character
	end

	def reveal(neighbor_bomb_count=0)
		if @is_revealed == 0
			if @is_mine == 1
				@render_character = "B".red
			else
				@render_character = neighbor_bomb_count.to_s
				@render_character = "_" if neighbor_bomb_count == 0
			end
			@is_revealed = 1
		end
		@render_character
	end
end