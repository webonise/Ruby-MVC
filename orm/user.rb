require File.expand_path('../operation.rb', __FILE__)
class User < Operation

	# attr_accessor :id, :fname, :lname, :age, :address
	#User.new.test
	#record = User.new.joins( 'LEFT OUTER JOIN products ON products.id = users.id' )
	#record = User.new.joins( 'RIGHT OUTER JOIN products ON products.id = users.id' )
	#record.map { |e| puts e }
	#User.new.index({ "name" => "make_it_faster", "col" => "address" })
	#User.new.dindex( "name" => "make_it_faster" )
	# obj = User.all
	# puts obj.last.fname
	# obj = obj.last
	# obj.update(fname: "A", lname: "b")

	#user = User.where( "id" => "1" ) #all #new(fname: "Abcd")
	#puts user.inspect
	# puts "#{User.all}
	str = "yes"
	while not str == "not"
		puts " Enter a choice."
		puts "1.insert ."
		puts "2.update ."
		puts "3.delete ."
		puts "4. List all"
		puts "5.Quit ."
		choice = gets.chomp.to_i
		case choice
		when 1
			user = User.new( "fname" => "'Abhishek'", "lname" => "'Gupta'","address" => "'H-3 New dehli'", "age"=> 26 )
			puts user.save 
			puts user.id
		when 2	
			user.update( "fname" => "'Abhishek'", "lname" => "'Gupta'","address" => "'Hhhhhhhhhh-3 New dehli'" )
			puts user.id
		when 3
			user.remove
			puts user.id
		when 4
			puts User.all("fname,address").inspect
			puts User.all("").inspect
		when 5
			str = "not"
		else
			puts "Wrong choice."
		end		

	#puts User.where( "address" => "'Hhhhhhhhhh-3 New dehli'", "condition" => "AND", "fname" => "'Abhishek'")
	#User.where("fname=? AND lname=?","abc", "xyz")
end
	


	#user.save
	#puts "#{user.save}"
	#puts User.columns
	#user = User.all
	#puts user.fname
end
