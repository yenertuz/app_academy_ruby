class Employee

	attr_reader :name, :title, :boss, :salary

	def initialize(name, salary, title, boss)
		@name = name
		@title = title 
		@boss = boss 
		@salary = salary
	end

	def bonus(multiplier)
		@salary * multiplier
	end

end