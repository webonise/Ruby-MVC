class BikersController < Surfer::Controller
	def show
		@data = "Instance Variable Accessed !! :P"
	end

	def index
		@data ="index Action"
	end
	
end