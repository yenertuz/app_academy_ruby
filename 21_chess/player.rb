class Player

	@@counter = 1

	attr_reader :number, :name

	def initialize(name)
		@name = name
		@number = @@counter
		@@counter += 1
	end

	def self.from_input
		print "Enter name for Player #{@@counter}: "
		name = gets.chomp.split[0]
		puts
		return self.new(name)
	end

end