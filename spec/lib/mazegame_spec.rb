require 'spec_helper'


describe "Mazegame" do
	before do
		@game_window = Mazegame.new(15,12)
		#For all tests to have same window setups 

	end
	
	describe ".new" do
		it "returns game window" do
			expect(@game_window).to be_an_instance_of Mazegame

		end

		it "it is not rectangular" do
			
			expect(@game_window.width).not_to be @game_window.height
			expect(@game_window.height).not_to be @game_window.width
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

	end

	describe ""
end

