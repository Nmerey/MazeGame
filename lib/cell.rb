class Cell

	attr_accessor :coloum_pos, :row_pos, :visited #making cell visitable
	
	@@all = []

	def initialize(coloum_pos,row_pos,visited = false)
		@coloum_pos = coloum_pos
		@row_pos = row_pos
		@line_color = 0xff_ffffff
		@w = 40 #length of every wall
		@@all << self
		@visited = visited
	end

	def check_neighbours(all_cells,coloums,rows)

		neighbours = []
		indexes = []
		
		top_index = find_index(self.coloum_pos,self.row_pos - 1,coloums,rows)
		right_index = find_index(self.coloum_pos + 1,self.row_pos,coloums,rows)
		bottom_index = find_index(self.coloum_pos,self.row_pos + 1,coloums,rows)
		left_index = find_index(self.coloum_pos - 1,self.row_pos,coloums,rows)
		
		indexes = [top_index,right_index,bottom_index,left_index]

		#Get rid off all out of box cells

		indexes.compact.each do |i|
			neighbours << all_cells[i]
			
		end

		

		#get rid off all visited cells
		neighbours.compact.each do |neighbour|
			
			if neighbour.visited
				neighbours.delete(neighbour)
			end
			
		end

		
		neighbours.compact

	end

	def visit #run this method when cell is visited

		@visited = true
		
	end

	def walls_exist?(x1 = true,y1 = true,x2 = true,y2 = true)

		walls = [x1,y1,x2,y2]
		
	end

	def top_wall
		
		params(0,0,@w,0)
	
	end

	def bottom_wall

		params(0,@w,@w,@w)

	end

	def left_wall

		params(0,0,0,@w)
		
	end

	def right_wall

		params(@w,0,@w,@w)
		
	end

	def self.all
		
		@@all

	end

	private

	# def walls(top = true,right = true ,bottom = true,left = true)

	# 	walls = [top,right,bottom,left]
		
	# end

	def find_index(i,j,coloums,rows)

		if i < 0 || j < 0 || i > coloums -1 || j > rows -1
			
			return nil

		else
			return i + j * coloums

		end
	
		
	end

	def check_index(i,all_cells,array)
		
		if i > 0 
			array << all_cells[i]
		end


		
	end

	def params(i1,j1,i2,j2)

		x1 = @coloum_pos * @w + i1
		y1 = @row_pos * @w + j1

		x2 = @coloum_pos * @w + i2
		y2 = @row_pos * @w + j2

		coordinates = [x1,y1,@line_color,x2,y2,@line_color]
		
	end



end