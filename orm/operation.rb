class Operation

	require './connection'
	require './support'

	CONN = Connection.new.create_connection   #single pattern.
	SUPPORT = Support.new

	def initialize(args)
		args.each do |a, v|
			eval("self.#{a} = '#{v}'")
		end
	end


	def self.drop #argv
		begin
			table_name = SUPPORT.get_pluralize( "#{self.name}" )
			puts table_name
			CONN.do( "DROP TABLE IF EXISTS #{table_name}" )
			CONN.commit
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts "Table droped successfully."
		end
	end


	def self.all
		objects = []
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		begin
			record = CONN.prepare( " SELECT * FROM #{table_name} " )
			record.execute()
			@columns = record.column_names
			record.each do |e| 
				hash = {}
				e.entries.each_with_index do |v,i|
					@columns[i].to_sym
					hash[@columns[i].to_sym] = v
				end
				objects << User.new(hash)
			end
			puts objects
			return objects
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
		else
			puts " Records fetched successfully. "
		end
	end



	def self.insert argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_insert( table_name, argv )
		puts query
		begin
			CONN.do(query)
			CONN.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts " Record inserted successfully. "
		end
	end



	def update argv
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
		query = SUPPORT.generate_update( table_name, argv )

		begin
			CONN.do(query)
			CONN.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts " Record updated successfully. "			
		end
	end


	def self.remove argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_remove( table_name, "id" => "1" ) #,  "condition" => "OR", "owner" => "'abc'" )
		begin
			CONN.do(query)
			CONN.commit
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts " Record remove successfully. "			
		end
	end


	def self.where argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_where( table_name, argv )   #{ "id" => "3" }, [ "id", "owner", "description" ]
		begin
			record = CONN.prepare( "#{query}" )
			record.execute()
			return record
			#.map { |r| printf " ID : %d, OWNER : %s, DISCRIPTION : %s \n",r[0], r[1], r[2] }
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
		else
			puts " Records fetched successfully. "			
		end

	end


	def self.joins argv
		
		table_name = SUPPORT.get_pluralize("#{self.name}")
		query = SUPPORT.generate_join( table_name, argv )

		begin
			record = CONN.prepare( query )
			record.execute()
			return record			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
		else
			puts " Records fetched successfully. "			
		end
	end


	def self.index argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_index( table_name, argv )

		begin
			CONN.do(query)
			CONN.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts " Index created successfully. "
			
		end
	end

	def self.dindex argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_dindex( table_name, argv )

		begin
			CONN.do( query )
			CONN.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
				puts " Index removes successfully. "		
		end
	end	
end