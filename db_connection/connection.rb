class Connection

	require 'dbi'
	require 'mysql'

	def create_conn
		begin
			conn = DBI.connect('DBI:Mysql:assesment_system','root','mohit')
		rescue DBI::DatabaseError => e
			puts " Error code: #{e.err} "
			puts " Error message: #{e.errstr}"  
		else
			puts " Connection stablished successfully. "	
			return conn	    			
		ensure
			conn.disconnect if conn
		end
	end
end

cn = Connection.new
cn.create_conn

