class ComputersController < Surfer::Controller
	def show 
		@data="Now this is ur home page"
	end

	def display_name
		@data="display_name"
	end
end