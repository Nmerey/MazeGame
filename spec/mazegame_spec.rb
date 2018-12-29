require 'spec_helper'


describe "Mazegame" do
	describe ".name" do
		it "returns name of game" do
			expect(Mazegame.new.name).to eq 'Mazegame'
		end
	end
end