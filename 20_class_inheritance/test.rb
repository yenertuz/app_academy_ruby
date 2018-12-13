require "./manager.rb"

david = Employee.new("David", 10000, "TA", "Darren")
shawna = Employee.new("Shawna", 12000, "TA", "Darren")
darren = Manager.new("Darren", 78000, "TA Manager", "Ned", [david, shawna])
ned = Manager.new("Ned", 1000000, "Founder", nil, [darren])

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)