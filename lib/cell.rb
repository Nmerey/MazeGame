class Cell
	attr_accessor :coloum_pos, :row_pos

	def initialize(coloum_pos,row_pos)
		@coloum_pos = coloum_pos
		@row_pos = row_pos
		@line_color = 0xff_ffffff
		@w = 40 #length of every wall
	end
	
	def wall_exist?

		walls
			
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

	private

	def walls
		walls = [true,true,true,true]
		
	end

	def params(i1,j1,i2,j2)

		x1 = @coloum_pos * @w + i1
		y1 = @row_pos * @w + j1

		x2 = @coloum_pos * @w + i2
		y2 = @row_pos * @w + j2

		coordinates = [x1,y1,@line_color,x2,y2,@line_color]
		
	end



end