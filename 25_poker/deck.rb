require_relative "./card.rb"

class Deck


	def initialize
		@deck = Card.all_cards
		@deck.shuffle!
		@deck.shuffle!
	end


	def draw
		return @deck.pop
	end

	def start_over
		@deck = Card.all_cards 
		@deck.shuffle!
		@deck.shuffle!
	end

end