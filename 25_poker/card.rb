require "./libft.rb"


class Card

RANKS = [ :A, :K, :Q, :J, 10, 9, 8, 7, 6, 5, 4, 3, 2   ]

SUITS = [ :heart, :diamond, :club, :spade  ]

attr_reader :suit, :rank

	def initialize(suit, rank)
		raise ArgumentError.new("#{suit} is not a valid suit") if SUITS.include?(suit) == false
		raise ArgumentError.new("#{rank} is not a valid rank") if RANKS.include?(rank) == false
		@suit = suit
		@rank = rank
	end

	def self.all_cards
		r = []
		RANKS.each do |rank|
			SUITS.each do |suit|
				r << self.class.new(suit, rank)
			end
		end
		r
	end

	def same_suit?(other_card)
		self.suit == other_card.suit
	end

	def same_rank?(other_card)
		self.rank == other_card.rank
	end

	def >(other_card)
		RANKS.index(self.rank) < RANKS.index(other_card.rank)
	end

	def <(other_card)
		RANKS.index(self.rank) < RANKS.index(other_card.rank)
	end


end