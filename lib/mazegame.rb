require 'gosu'
require 'byebug'
  

class Mazegame < Gosu::Window
  
  def initialize coloums,rows

  	@coloums = coloums
  	@rows = rows
    height = @rows*40
    width = @coloums*40
    @grids = [] #All Cells combined gives grids
    @current = Cell.all.first #Just for now starting point is first cell
    @visite_color = Gosu::Color.argb(0xff_808080)
    @neighbours = []

    grids #Gathering all the cells before iteration

    super width,height
    #every cell's height and width is equal to 40px
    #so self.height = row numbers and self.width = coloum numbers
    self.caption = caption

  end
  
  def update
    
    
  	@current = @grids.first
   	@current.visit

   	@current.check_neighbours(@grids,@coloums + 1)
   	byebug
   	

  end
  
   def draw

   	
   	
   	@grids.each do |cell|

   		draw_line(*cell.top_wall) if cell.walls_exist?[0]
   		draw_line(*cell.right_wall) if cell.walls_exist?[1]
   		draw_line(*cell.left_wall) if cell.walls_exist?[2]
   		draw_line(*cell.bottom_wall) if cell.walls_exist?[3]
   		
   	end

   

   	if @current.visited
   		draw_rect(@current.coloum_pos,@current.row_pos,40,40,@visite_color)
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
   			@grids << Cell.new(j,i)
   			
   		end
   		
   	end
  	
  end

end