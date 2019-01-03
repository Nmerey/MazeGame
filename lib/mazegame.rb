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
	   		
	   		remove_wall(@current,neighbours[r])

	   		@current = neighbours[r] #Update current cell to random not visited neighbour

	   	end
	   	
	else


		self.close!

   	end
   	
  end
  
   def draw

   	
   	
   	@grids.each do |cell|

   		draw_line(*cell.top_wall) if cell.walls[0]
   		draw_line(*cell.right_wall) if cell.walls[1]
   		draw_line(*cell.left_wall) if cell.walls[2]
   		draw_line(*cell.bottom_wall) if cell.walls[3]

   		draw_rect(cell.coloum_pos*40,cell.row_pos*40,40,40,@visited_color) if cell.visited
   			

   		
   	end


  end

  def remove_wall(current,next_cell)
  		
  		if current.coloum_pos - next_cell.coloum_pos == 1 #If next cell is left to current cell
  			
  			current.walls[3] = false
  			next_cell.walls[1] = false

  		elsif current.coloum_pos - next_cell.coloum_pos == -1 #If next cell is right to current cell
  			
  			next_cell.walls[3] = false
  			current.walls[1] = false

  		elsif current.row_pos - next_cell.row_pos == 1 #If next cell is top to current cell

  			current.walls[0] = false
  			next_cell.walls[2] = false

  		elsif current.row_pos - next_cell.row_pos == -1 #If next cell is bottom to current cell
  			
  			current.walls[2] = false
  			next_cell.walls[0] = false

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