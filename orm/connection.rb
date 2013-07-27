class Connection

	require 'dbi'
	require 'mysql'
	require './readdb'

	def create_connection

		file = ReadDbFile.new.read_file
			driver = (file['development']['adapter']).capitalize!
			dbase = file['development']['database']
			uname = file['development']['username'] 
			password = file['development']['password']
		begin			
			conn = DBI.connect( "DBI:#{driver}:#{dbase}", "#{uname}", "#{password}" )                        
		rescue DBI::DatabaseError => e
			puts " Error code: #{e.err} "
			puts " Error message: #{e.errstr}"  
		else
			puts " Connection stablished successfully. "
			return conn	    			
		end
	end

end
