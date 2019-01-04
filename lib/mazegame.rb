require 'gosu'
require 'byebug'
  

class Mazegame < Gosu::Window
  
  def initialize coloums,rows

  	@coloums = coloums
  	@rows = rows
    height = @rows*40
    width = @coloums*40
    @grids = [] #All Cells combined gives grids
    @cost_sum = []
    

    #----------- COLORS ---------------#
    @visited_color = Gosu::Color.argb(0xff_288888)
    @start_color = Gosu::Color.argb(0xff_434564)
    @destination_color = Gosu::Color.argb(0xff_234566)
    @shortest_path_color = Gosu::Color.argb(0xff_564768)

    @neighbours = []

    @visited_cells = []

    #<------------ DATA SETUP ----------->

    grids #Gathering all the cells before iteration

    @start = @grids[rand(coloums)]
    @destination = @grids[-rand(coloums)]

    @shortest_path = []
    @temp_arr = []

    @answer = @start

    @current = @start
    
    assign_value #Gives every cell value according to @destination

    super width,height
    #every cell's height and width is equal to 40px
    #so self.height = row numbers and self.width = coloum numbers
    self.caption = caption

  end
  
  def update

  	
  	# <-------------- GENERATING THE MAZE -------------------->

  	if @current != nil

  		@current.visited = true

  		@visited_cells << @current

   		neighbours = @current.check_neighbours(@grids,@coloums,@rows) # => Array of neighbour cells
   		

   		#get rid off all visited cells
		neighbours.compact.each do |neighbour|
			
			if neighbour.visited
				neighbours.delete(neighbour)
			end
			
		end
   		
   		##puts "#{@current.coloum_pos},#{@current.row_pos}"

		if neighbours.length > 0 
	   		
	   		r = rand(neighbours.length)
	   		next_cell = neighbours[r]

	   		remove_wall(@current,next_cell)
	   		@current = next_cell #Update current cell to random not visited neighbour
	   	
	   	else
	   		
	   		
	   		@current = backtrack #Current cell goes back to find not visited neighbours

	   	end
	   	
	else

		if @shortest_path.last == @destination
			puts "You WIN" 
			
		else
			
			@answer.checked = true
			
			temp_arr = nearest_cell(@answer) 
			
			temp_arr.each do |elem|
				if elem.checked
					temp_arr.delete(elem)
					
				end
				
			end

			if temp_arr.length > 0

				
				@shortest_path << temp_arr.first
				@answer = @shortest_path.last

			else
				
				@answer = backtrack_answer
				
			end
		end
   	end
   	
   	
  end
  
   def draw

   	
   	@grids.each do |cell|
   		
   		
   	
   		#Draws 4 walls of all cells
   		draw_line(*cell.top_wall) if cell.walls[0]
   		draw_line(*cell.right_wall) if cell.walls[1]
   		draw_line(*cell.bottom_wall) if cell.walls[2]
   		draw_line(*cell.left_wall) if cell.walls[3]

   		draw_rect(cell.coloum_pos*40,cell.row_pos*40,40,40,@visited_color) if cell.visited
   		draw_rect(@start.coloum_pos*40,@start.row_pos*40,40,40,@start_color)
   		draw_rect(@destination.coloum_pos*40,@destination.row_pos*40,40,40,@destination_color)

   		
   	end

   	@shortest_path.each do |cell|

   		draw_rect(cell.coloum_pos*40,cell.row_pos*40,35,35,@shortest_path_color)


   		
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

  def needs_cursor?
  		
  		true
  end


  def caption
    "Mazegame"
    
  end

  def params

  	[@grids,@visited_cells]
  	
  end

  private

  def backtrack_answer

  	@shortest_path.delete(@shortest_path.last)
  	@shortest_path.last
  	
  end

  def backtrack
  	#Keep record of visited cells and returns last visited cell
  	@visited_cells.delete(@visited_cells.last)
  	@visited_cells.last
  	
  	
  end

  def nearest_cell(cell)

  	no_wall_pos = cell.walls.each_index.select{|i| cell.walls[i] == false} #Only choose accessible cells where no wall

  	no_wall_neighbours = []

  	no_wall_pos.each do |pos|

  		case pos

  		when 0
  			no_wall_neighbours << @grids.select{|elem| elem.coloum_pos == cell.coloum_pos && elem.row_pos == cell.row_pos - 1}.first
  		when 1
  			no_wall_neighbours << @grids.select{|elem| elem.coloum_pos == cell.coloum_pos + 1 && elem.row_pos == cell.row_pos}.first
  		when 2
  			no_wall_neighbours << @grids.select{|elem| elem.coloum_pos == cell.coloum_pos && elem.row_pos == cell.row_pos + 1}.first
  		when 3
  			no_wall_neighbours << @grids.select{|elem| elem.coloum_pos == cell.coloum_pos - 1 && elem.row_pos == cell.row_pos }.first
  			
  		end
  		
  	end

  	no_wall_neighbours.each do |neighbour|

  		if neighbour.checked
  			no_wall_neighbours.delete(neighbour)
  			
  		end
  		
  	end

  	no_wall_neighbours.sort_by {|cell| cell.cost}


  end

  def assign_value

  	@grids.each do |cell|

  		cell.cost = ((@destination.coloum_pos - cell.coloum_pos) + (@destination.row_pos - cell.row_pos)).abs
  		
  	end
  	
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