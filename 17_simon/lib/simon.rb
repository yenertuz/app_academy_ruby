require "colorize"

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
	@sequence_length = 1
	@game_over = false
	@seq = []
  end

  def play
	self.take_turn while @game_over == false
	self.game_over_message
	self.reset_game
  end

  def take_turn
	self.show_sequence
	self.require_sequence
	if @game_over == false
		self.round_success_message
		@sequence_length += 1
	end
  end

  def show_sequence
	self.add_random_color
  end

  def require_sequence
	seq = gets.chomp.split
	@game_over == 1 if seq != @seq
  end

  def add_random_color
	@seq += COLORS.sample(1)
  end

  def round_success_message

  end

  def game_over_message
	puts "GAME OVER :( ".red
  end

  def reset_game
	@sequence_length = 1
	@seq = []
	@game_over = false
  end
end

Simon.new.play