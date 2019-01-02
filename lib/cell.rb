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

	def check_neighbours(all_cells,coloums)

		top_index = self.coloum_pos + (self.row_pos - 1) * coloums
		right_index = self.coloum_pos + 1 + self.row_pos * coloums
		bottom_index = self.coloum_pos + (self.row_pos + 1) * coloums
		left_index = self.coloum_pos - 1 + self.row_pos * coloums
		
		neighbours = [all_cells[top_index],all_cells[right_index],all_cells[bottom_index],all_cells[left_index]]
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

	def params(i1,j1,i2,j2)

		x1 = @coloum_pos * @w + i1
		y1 = @row_pos * @w + j1

		x2 = @coloum_pos * @w + i2
		y2 = @row_pos * @w + j2

		coordinates = [x1,y1,@line_color,x2,y2,@line_color]
		
	end



end