require "./tree_node.rb"

class KnightPathFinder

	def initialize(start_poz)
		@start_node = PolyTreeNode(start_poz)
		@visited_positions = [start_poz]

		self.build_move_tree
	end

	def self.valid_moves_helper(pos, x_add, y_add)
		ret = pos.dup
		ret[0] += x_add
		ret[1] += y_add 
		ret
	end

	def self.valid_moves(pos)
		r = []
		r << self.class.valid_moves_helper(pos, 1, 2)
		r << self.class.valid_moves_helper(pos, -1, 2)
		r << self.class.valid_moves_helper(pos, 1, -2)
		r << self.class.valid_moves_helper(pos, -1, -2)
		r << self.class.valid_moves_helper(pos, 2, 1)
		r << self.class.valid_moves_helper(pos, -2, 1)
		r << self.class.valid_moves_helper(pos, 2, -1)
		r << self.class.valid_moves_helper(pos, -2, -1)
		r.select {|x|  0 <= x[0] && x[0] < 8 && 0 <= x[1] && x[1] < 8   }
	end

	def new_move_positions(pos_node)
		new_moves = self.class.valid_moves(pos_node)
		new_moves.each 
	end


	def build_move_tree
		;
	end

end