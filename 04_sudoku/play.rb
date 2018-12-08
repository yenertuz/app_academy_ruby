require "./sudoku.rb"

print "enter the path of sudoku file to solve: "
path = gets.chomp
Sudoku.new(path).play