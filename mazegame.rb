require 'gosu'

  # puts "Please number of coloums"
  # coloums = gets.chomp.to_i
  # puts "Please enter number of rows"
  # rows = gets.chomp.to_i

class Mazegame < Gosu::Window
  
  def initialize coloums,rows
    
    super coloums*40,rows*40 
    #every cell will be height and width will be equalt to 40px
    #so self.height = rows number and self.width = coloums number
    self.caption = caption
  end
  
  def update
    # ...
  end
  
  def draw
    # ...
  end

  def caption
    "Mazegame"
    
  end
end

# Mazegame.new(coloums,rows).show