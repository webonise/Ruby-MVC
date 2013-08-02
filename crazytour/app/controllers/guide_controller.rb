class GuidesController < Surfer::Controller
 def index
 	#insert Default Queries
 	# @guide = Guide.new("fname"=>"Mohit", "lname"=>"Singh", "contact_no"=>"9538574169","address"=>"Gwalior")
 	# @guide.save

 	# @places = Place.new("name"=>"Khandala", "location"=>"Maharashtra","type"=>"Hill Station","distance"=>"68 km" )
 	# @places.save

 	# @guide=Guide.all

 	# @places=Place.all
 	# puts @places.inspect

 	# @places =Place.where("type"=>"Hill Station")
 	# puts @places.inspect

 	# @places =Place.where("type"=>"Hill Station").first
 	# @places.update("name"=>"Khandala" , "distance"=>"68 km")
 	# @places=Place.all
 	# puts @places.inspect

 	@places =Place.where("id"=>"2").last
 	@places.remove
 	@places=Place.all

 	# puts "Inside show_guides"
 	# @guide = Guide.new("fname"=>"Mohit", "lname"=>"Singh", "contact_no"=>"9538574169","address"=>"Gwalior")
 	# @guide.save
 	# @guide=Guide.all
 end

 def show_guides
 	puts "Inside show_guides"
 	@guide = Guide.new("fname"=>"Mohit", "lname"=>"Singh", "contact_no"=>"9538574169","address"=>"Gwalior")
 	@guide.save
 	@guide=Guide.all
 end

end