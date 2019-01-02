require_relative '../spec_helper'

describe "Cell" do
	let(:cell) {Cell.new(1,1)}
	describe ".new" do

		it "runs cell instance" do

			expect(cell).to be_an_instance_of Cell

		end
	end

	describe ".visited?" do
		before do
				visit_cell(cell)
			end
		it "fills gray when curren cell is visited" do

			expect(cell.visited).to be true
		end
	end

	describe ".check_neighbours" do
		let(:cell_top) {Cell.new(1,0)}
		let(:cell_right) {Cell.new(1,2)}
		let(:cell_bottom) {Cell.new(1,2)}
		let(:cell_left) {Cell.new(0,1)}
		let(:all_cells) {[nil,cell_top,nil,cell_left,cell,cell_right,nil,cell_bottom,nil]}
		it " returns array of neighbour cells" do
			expect(cell.check_neighbours(all_cells,3)).to eq [cell_top,cell_right,cell_bottom,cell_left]
		end

	end

	describe ".walls_exist?" do
		it "draws all sides if all walls exist" do
			expect(cell.walls_exist?).to eq [true,true,true,true]
		end
		it "draws only top wall " do 
			expect(cell.walls_exist?(true,false,false,false)).to eq [true,false,false,false]
		end

		it "draws other 3 sides when on side is not there" do
			expect(cell.walls_exist?(false)).to eq [false,true,true,true]
		end

		it "draws other 2 sides when 2 side is not there" do
			expect(cell.walls_exist?(false,true,false)).to eq [false,true,false,true]
		end
	end

	describe ".top_wall" do
		it "returns cell's top cordinates" do
			expect(cell.top_wall).to eq([40,40,0xff_ffffff,80,40,0xff_ffffff])
		end

	end	
	describe ".right_wall" do
		it "returns cell's right cordinates" do
			expect(cell.right_wall).to eq([80,40,0xff_ffffff,80,80,0xff_ffffff])
		end

	end	

	describe ".bottom_wall" do
		it "returns cell's bottom cordinates" do
			expect(cell.bottom_wall).to eq([40,80,0xff_ffffff,80,80,0xff_ffffff])
		end

	end	

	describe ".left_wall" do
		it "returns cell's left cordinates" do
			expect(cell.left_wall).to eq([40,40,0xff_ffffff,40,80,0xff_ffffff])
		end

	end

	private

	def visit_cell(cell)

		cell.visit
		
	end


end