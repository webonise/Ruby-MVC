module Surfer
	require ::File.expand_path('../readdb',__FILE__)
	class Connection
		@conn=nil
		def create_connection
			file = ReadDbFile.new.read_file
				# puts (file['development']['adapter']).emtpy?
				if (!(file['development']['adapter']).nil?)
					driver = (file['development']['adapter']).capitalize!
					dbase = file['development']['database']
					uname = file['development']['username'] 
					password = file['development']['password']
				else
					abort ( " Please Complete the database.yml file first " )
				end
			begin			
				@conn = DBI.connect( "DBI:#{driver}:#{dbase}", "#{uname}", "#{password}" )                        
			rescue DBI::DatabaseError => e  
				if (e.err == 1049)
					@conq= DBI.connect( "DBI:#{driver}:test", "#{uname}", "#{password}" )
					@conq.do( " create database #{dbase}; " )
					@conq.commit()
					@conq.disconnect if @conq
					@conq= DBI.connect( "DBI:#{driver}:#{dbase}", "#{uname}", "#{password}" )
					# @conq.disconnect if @conq
					puts " #{dbase} Created successfully "
					connection = @conq
					return connection
					# abort ("please create database #{dbase} manually before creating model")
					
				else
					puts " Error code: #{e.err} "
					puts " Error message: #{e.errstr}"

				end
			else
				puts " Connection stablished successfully. "
				connection = @conn
				return connection	    			
			end
		end

		def close_connection
			
			if @conn
				@conn.disconnect
				puts "Connection closed"
			end
		end

	end
end