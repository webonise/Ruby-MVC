require ::File.expand_path('../../models/biker',__FILE__)

class BikersController < Surfer::Controller
  def index
  	# @bikers = Biker.new("fname" => "'webonise'")
  	# @bikers.save
  	# puts "inside controlller"
  	# puts @bikers.id 
  	# @data = "Hey -----------------------"

  	# Biker.drop
  	# puts "*"*100
  	# puts @bikers.inspect
	# data=[]
  	 @bikers=Biker.where("fname" => "APPLE").first
     puts @bikers.inspect
  	  # @bikers.update( "fname" => "'GOOGLE'")
      # @bikers=Biker.all
      # puts @bikers.inspect

      # @bikers=Biker.new("fname"=>"Mohit")
      # @bikers.save
      # puts " ID :#{@bikers.inspect}"
      # @bikers.remove



    # Biker.

  end
end