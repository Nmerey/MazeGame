require 'gosu'
require 'byebug'
  

class Mazegame < Gosu::Window
  
  def initialize coloums,rows, update_interval = 250000

  	@coloums = coloums
  	@rows = rows
    height = @rows*40
    width = @coloums*40
    @grids = [] #All Cells combined gives grids
    @visited_color = Gosu::Color.argb(0xff_808080)
    @neighbours = []

    grids #Gathering all the cells before iteration

    @current = @grids.first

    super width,height
    #every cell's height and width is equal to 40px
    #so self.height = row numbers and self.width = coloum numbers
    self.caption = caption

  end
  
  def update

  	if @current != nil

  		@current.visited = true
   		neighbours = @current.check_neighbours(@grids,@coloums,@rows) # => Array of neighbour cells
   		neighbours.compact

		if neighbours.length > 0 
	   		
	   		r = rand(neighbours.length) 
	   		
	   		@current = neighbours[r] #Update current cell to random not visited neighbour

	   	end
	   	
	else

		self.close!

   	end
   	
  end
  
   def draw

   	
   	
   	@grids.each do |cell|

   		draw_line(*cell.top_wall) if cell.walls_exist?[0]
   		draw_line(*cell.right_wall) if cell.walls_exist?[1]
   		draw_line(*cell.left_wall) if cell.walls_exist?[2]
   		draw_line(*cell.bottom_wall) if cell.walls_exist?[3]

   		draw_rect(cell.coloum_pos*40,cell.row_pos*40,40,40,@visited_color) if cell.visited
   			

   		
   	end


  end

  def caption
    "Mazegame"
    
  end

  private


  def grids 

  	@rows.times do |i|
   		@coloums.times do |j|
   			@grids << Cell.new(j,i)
   			
   		end
   		
   	end
  	
  end

end