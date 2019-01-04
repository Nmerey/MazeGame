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

    @visited_cells = []

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

  		@visited_cells << @current

   		neighbours = @current.check_neighbours(@grids,@coloums,@rows) # => Array of neighbour cells
   		neighbours.compact
   		
   		##puts "#{@current.coloum_pos},#{@current.row_pos}"

		if neighbours.length > 0 
	   		
	   		r = rand(neighbours.length) 
	   		next_cell = neighbours[r]

	   		remove_wall(@current,next_cell)
	   		@current = next_cell #Update current cell to random not visited neighbour
	   	
	   	elsif
	   		
	   		
	   		@current = backtrack

	   	else
	   		@current.visited = true
	   	end
	   	
	else


		return self.draw

   	end
   	
   	
  end
  
   def draw

   	
   	
   	@grids.each do |cell|

   		draw_line(*cell.top_wall) if cell.walls[0]
   		draw_line(*cell.right_wall) if cell.walls[1]
   		draw_line(*cell.bottom_wall) if cell.walls[2]
   		draw_line(*cell.left_wall) if cell.walls[3]

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

  		end

  		if current.row_pos - next_cell.row_pos == 1 #If next cell is top to current cell

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

  def params

  	[@grids,@visited_cells]
  	
  end

  private

  def backtrack

  	@visited_cells.delete(@visited_cells.last)
  	@visited_cells.last
  	
  	
  end

  def find_exit(current)

  	x = current.walls.index(false)

  	reusult = 	case x

  	when 0
  		temp = @grids.select{|cell| cell.coloum_pos == current.coloum_pos && cell.row_pos == current.row_pos - 1}
  	when 2
 		temp = @grids.select{|cell| cell.coloum_pos == current.coloum_pos && cell.row_pos == current.row_pos + 1}
 	when 1
 		temp = @grids.select{|cell| cell.coloum_pos == current.coloum_pos + 1 && cell.row_pos == current.row_pos}
 	when 3
 		temp = @grids.select{|cell| cell.coloum_pos == current.coloum_pos - 1 && cell.row_pos == current.row_pos}
 		
  	end
  	
  	reusult
  end


  def grids 

  	@rows.times do |i|
   		@coloums.times do |j|
   			@grids << Cell.new(j,i)
   			
   		end
   		
   	end
  	
  end

end