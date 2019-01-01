require_relative '../spec_helper'

describe "Cell" do
	let(:cell) {Cell.new(1,1)}
	describe ".new" do
		it "runs cell instance" do
			expect(cell).to be_an_instance_of Cell

		end
	end

	describe ".top_line" do
		it "returns cell's top cordinates" do
			expect(cell.top_wall).to eq([40,40,0xff_ffffff,80,40,0xff_ffffff])
		end

		it "returns cell's right wall cordinates" do
			expect(cell.right_wall).to eq([80,40,0xff_ffffff,80,80,0xff_ffffff])
		end
	end
end