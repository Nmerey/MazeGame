require_relative '../spec_helper'

describe "Cell" do
	let(:cell) {Cell.new(1,1)}
	describe ".new" do
		it "runs cell instance" do
			expect(cell).to be_an_instance_of Cell

		end
	end

	describe ".wall_exist?" do
		it "draws cell wall if wall exist" do
			expect(cell.wall_exist?).to eq [true,true,true,true]
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


end