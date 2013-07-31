require ::File.expand_path('../../models/biker',__FILE__)

class BikersController < Surfer::Controller
  def index
  	@bikers = Biker.new("fname" => "'webonise'")
  	@bikers.save
  	puts "inside controlller"
  	puts @bikers.id 
  	@data = @bikers

  	# Biker.drop
  	# puts "*"*100
  	# puts @bikers.inspect
	# data=[]
  	# @bikers=Biker.where("id" => "2")
  	# puts @bikers.class

  end
end