class PolyTreeNode

	attr_reader :parent, :children, :value

	def initialize(value)
		@parent = nil
		@children = []
		@value = value
	end

	def parent=(new_parent)
		self.parent.children.delete(self) if @parent
		@parent = new_parent
		if new_parent != nil
			new_parent.children << self if new_parent.children.include?(self) == false
		end
	end


	def add_child(child_node)
		raise "Child node is not a Poly Tree Node object!" if child_node.is_a?(PolyTreeNode) == false
		child_node.parent = self
		@children << child_node if @children.include?(child_node) == false
	end

	def remove_child(child_node)
		raise "Child node is not a Poly Tree Node object!" if child_node.is_a?(PolyTreeNode) == false
		raise "Child node is not a child of this node" if @children.include?(child_node) == false
		child_node.parent = nil
		@children.delete(child_node)
	end

	def dfs(target_value)
		return self if @value == target_value
		@children.each do |x|
			if x != self
				result = x.dfs(target_value)
				return result if result
			end
		end
		return nil
	end

	def bfs(target_value)
		queue = []
		queue.push(self)
		while queue.length != 0
			current = queue.pop
			return current if current.value == target_value
			current.children.each { |x| queue.unshift(x)  }
		end
		nil
	end



end