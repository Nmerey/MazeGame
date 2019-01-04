require_relative '../spec_helper'


describe Mazegame do
	before do
		@game_window = Mazegame.new(4,3)
		12.times do @game_window.update end
		#For all tests to have same window setups 
		@cell = Cell.new(1,1)
		@cell2 = Cell.new(2,1)
		@cell_bottom = Cell.new(1,2)
		@cell_left = Cell.new(0,1)

		@cell_current = Cell.new(5,5,visited = true)
		@cell_next = Cell.new(6,5,visited = true)
		@all_cells = [@cell_current,@cell_next]

		@game_window.remove_wall(@cell,@cell2)
		@game_window.remove_wall(@cell,@cell_bottom)
		@game_window.remove_wall(@cell,@cell_left)
		@game_window.remove_wall(@cell_current,@cell_next)
	end
	
	describe ".new" do

		it "returns game window" do
			expect(@game_window).to be_an_instance_of Mazegame

		end

		it "when given parameters is rectangular" do
			
			expect(@game_window.width).not_to be @game_window.height
			expect(@game_window.height).not_to be @game_window.width
		end

	end

	describe ".remove_wall" do
		
		it " when next cell is right to current cell" do
			
			expect([@cell.walls[1],@cell2.walls[3]]).to eq([false,false])
		end

		it " whne current is top to next" do
			expect([@cell.walls[2],@cell_bottom.walls[0]]).to eq([false,false])
		end

		it "when current cell is right to next" do
			expect([@cell.walls[3],@cell_left.walls[1]]).to eq([false,false])
		end

	end


	describe ".caption" do
		it "returns caption of game" do
			expect(@game_window.caption).to eq 'Mazegame'
		end
	end
	
	describe ".draw" do

	end

	describe ".update" do

		it "when all neighbour cells are not valid" do
			
			expect(@game_window.params[1].last.visited).to eq(@cell_next.visited)


		end


	end

	private

	def destroying_walls(cell_a,cell_b)
		
		Mazegame.new(15,12).remove_wall(cell_a: cell_a,cell_b: cell_b)

		result = [cell_a.walls[3],cell_b.walls[1]]
		
	end
end

