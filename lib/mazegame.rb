require 'gosu'
require 'byebug'
  

class Mazegame < Gosu::Window
  
  def initialize coloums,rows
  	@coloums = coloums
  	@rows = rows
    height = @rows*40
    width = @coloums*40
    @grids = [] #All Cells combined gives grids
   
    super width,height
    #every cell will be height and width will be equalt to 40px
    #so self.height = rows number and self.width = coloums number
    self.caption = caption
  end
  
  def update
    # ...
  end
  
   def draw

   	grids #Gathering all the cells before iteration
   	
   	@grids.each do |cell|

   		draw_line(*cell.top_wall) if cell.wall_exist?[0]
   		draw_line(*cell.right_wall)
   		draw_line(*cell.left_wall)
   		draw_line(*cell.bottom_wall)
   		



   		
   	end

  end

  def caption
    "Mazegame"
    
  end

  private
  
  #Considerated as a good coding habit to write private methods

  def grids 

  	@coloums.times do |i|
   		@rows.times do |j|
   			@grids << Cell.new(i,j)
   			
   		end
   		
   	end
  	
  end

end