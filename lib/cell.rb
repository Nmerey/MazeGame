class Cell
	attr_accessor :coloum_pos, :row_pos

	def initialize(coloum_pos,row_pos)
		@coloum_pos = coloum_pos
		@row_pos = row_pos
		@line_color = 0xff_ffffff
		@w = 40 #length of every wall
	end

	def top_wall
		x1 = @coloum_pos * @w
		x2 = x1 + @w
		y1 = row_pos * @w
		y2 = y1
		coordinates = [x1,y1,0xff_ffffff,x2,y2,0xff_ffffff]
	end

	def bottom_wall
		x1 = @coloum_pos * @w
		x2 = x1 + @w
		y1 = row_pos * @w + @w
		y2 = y1
	end

	def left_wall
		
	end

	def right_wall
		x1 = @coloum_pos * @w + @w
		x2 = x1
		y1 = @row_pos * @w
		y2 = y1 + @w

		coordinates = [x1,y1,0xff_ffffff,x2,y2,0xff_ffffff]	
	end

end