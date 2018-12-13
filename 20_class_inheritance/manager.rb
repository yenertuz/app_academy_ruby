require "./employee.rb"

class Manager < Employee

	def initialize(name, title, salary, boss, team=[])
		super(name, title, salary, boss)
		@team = team
	end

	def bonus(multiplier)
		@team.reduce(0) { |sum, num| sum + num.bonus(multiplier) + (num.is_a?(Manager)  ? num.salary * multiplier : 0 )  }
	end

end