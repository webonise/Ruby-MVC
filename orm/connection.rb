class Connection

	require 'dbi'
	require 'mysql'

	def create_connection
		begin
			conn = DBI.connect('DBI:Mysql:assesment_system','root','mohit')
		rescue DBI::DatabaseError => e
			puts " Error code: #{e.err} "
			puts " Error message: #{e.errstr}"  
		else
			puts " Connection stablished successfully. "
			return conn	    			
		end
	end
end

