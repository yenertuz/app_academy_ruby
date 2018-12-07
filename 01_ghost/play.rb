require "./game.rb"
require "./player.rb"

print "Enter name for player1: "
p1_name = gets.chomp
puts
print "Enter name for player2: "
p2_name = gets.chomp
puts

puts "Starting game"
puts 

game = Game.new(Player.new(p1_name), Player.new(p2_name))
game.play