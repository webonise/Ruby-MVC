class PlacesController < Surfer::Controller
	def create_place
		@places = Place.new("name"=>"Alibag", "location"=>"Maharashtra","type"=>"Beach","distance"=>"140 km" )
		@places.save
		@places=Place.all().last
	end

	def post_review
		@place=Place.where("id"=>"33").last
 		@review=Review.new("fname"=>"Swapnil","place_id"=>@place.id,"comment"=>"I like this Place")
 		@review.save
 		@review=Review.all().last
 	end

 	def show_place
 		@place=Place.all
 		@reviews=Review.all
 	end
end