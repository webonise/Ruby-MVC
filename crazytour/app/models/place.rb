class Place < Surfer::Operation
	set_columns
	def reviews
		Review.where("place_id"=>self.id)
	end
end


