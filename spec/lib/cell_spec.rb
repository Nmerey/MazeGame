require_relative '../spec_helper'

describe "Cell" do
	let(:cell) {Cell.new(10,9)}
	describe ".new" do
		it "runs cell instance" do
			expect(cell).to be_an_instance_of Cell

		end
	end
end