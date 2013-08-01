module Surfer
	require ::File.expand_path('../readdb',__FILE__)
	class Connection
		@conn=nil
		def create_connection
			file = ReadDbFile.new.read_file
				driver = (file['development']['adapter']).capitalize!
				dbase = file['development']['database']
				uname = file['development']['username'] 
				password = file['development']['password']
			begin			
				@conn = DBI.connect( "DBI:#{driver}:#{dbase}", "#{uname}", "#{password}" )                        
			rescue DBI::DatabaseError => e
				puts " Error code: #{e.err} "
				puts " Error message: #{e.errstr}"  
			else
				puts " Connection stablished successfully. "
				connection = @conn
				return connection	    			
			end
		end

		def close_connection
			puts @conn
			@conn.disconnect if @conn
			puts @conn
		end

	end
end