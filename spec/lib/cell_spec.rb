require_relative '../spec_helper'

describe "Cell" do
	let(:cell) {Cell.new(1,1)}
	let(:cell2) {Cell.new(0,0)}
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
			expect(cell.check_neighbours(all_cells,3,3)).to eq [cell_top,cell_right,cell_bottom,cell_left]
		end

		it "when one or more of the neighbours is out of box" do
			expect(cell2.check_neighbours(all_cells,3,3)).to eq ([cell_top,cell_left])
		end


		it "when one or more of the neighbours is visited already" do
			expect(visited_cells(all_cells,cell)).to eq([cell_right,cell_bottom,cell_left])
		end

	end

	describe ".walls" do

		it " draws all sides if all walls exist" do
			expect(cell.walls).to eq [true,true,true,true]
		end
	end

	describe ".top_wall" do
		it "returns cell's top cordinates" do
			expect(cell.top_wall).to eq([40,40,0xff_ffff88,80,40,0xff_ffff88])
		end

	end	
	describe ".right_wall" do
		it "returns cell's right cordinates" do
			expect(cell.right_wall).to eq([80,40,0xff_ffff88,80,80,0xff_ffff88])
		end

	end	

	describe ".bottom_wall" do
		it "returns cell's bottom cordinates" do
			expect(cell.bottom_wall).to eq([40,80,0xff_ffff88,80,80,0xff_ffff88])
		end

	end	

	describe ".left_wall" do
		it "returns cell's left cordinates" do
			expect(cell.left_wall).to eq([40,40,0xff_ffff88,40,80,0xff_ffff88])
		end

	end

	private

	def visited_cells(cells,cell)

		cells[1].visit
		unvisited = cell.check_neighbours(cells,3,3)

		unvisited.each do |cell|

			if cell.visited

				unvisited.delete(cell)
				
			end
			
		end
		
		unvisited.compact
	end
	
	def visit_cell(cell)

		cell.visit
		
	end


end