class Player

	@@counter = 1

	def initialize(name)
		@name = name
		@number = @@counter
		@@counter += 1
	end

	def self.from_input
		print "Enter name for Player #{@@counter}:"
		name = gets.chomp.split[0]
		return self.new(name)
	end

end