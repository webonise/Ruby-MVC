require File.expand_path('../operation.rb', __FILE__)
class User < Operation

	#User.new.test
	#record = User.new.joins( 'LEFT OUTER JOIN products ON products.id = users.id' )
	#record = User.new.joins( 'RIGHT OUTER JOIN products ON products.id = users.id' )
	#record.map { |e| puts e }
	#User.new.index({ "name" => "make_it_faster", "col" => "address" })
	User.new.dindex( "name" => "make_it_faster" )

end
