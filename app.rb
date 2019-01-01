
Dir[File.join(File.dirname(__FILE__),"lib","**.rb")].each do |file|
  require file
  
end

puts "Please number of coloums"
coloums = gets.chomp.to_i
puts "Please enter number of rows"
rows = gets.chomp.to_i


window = Mazegame.new(coloums,rows)

window.show