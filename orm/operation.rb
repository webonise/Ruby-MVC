class Operation
	require './connection'
	require './support'

	CONN = Connection.new.create_connection   #single pattern.
	SUPPORT = Support.new
	def create
		query = SUPPORT.create_table(ARGV)
		begin
			CONN.do("#{query}")
			CONN.commit
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
			CONN.rollback
		else
			puts "Table is created."
		end
	end


	def drop argv
		begin
			table_name = SUPPORT.get_pluralize( argv )  #self.class)
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


	def select_all
		table_name = SUPPORT.get_pluralize(self.class)
		begin
			record = CONN.prepare( " SELECT * FROM #{table_name} " )
			record.execute()
			return record
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
		end
	end



	def insert #argv
		table_name = SUPPORT.get_pluralize( "coach" )  #self.class)
		argv = Hash.new
		argv["name"] = "'Mohit'"
		#argv["fname"] = "'Mohit'"
		#argv["lname"] = "'singh'"
		#argv["age"] = 22
		#h = { "a" => 100, "b" => 200, "c" => 300, "d" => 400 }
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



	def update #argv
		table_name = SUPPORT.get_pluralize( "coach" ) #self.class )
		query = SUPPORT.generate_update( table_name, { "name" => " 'xyz' " } , { "id" => "1" } )

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


	def remove #argv
		table_name = SUPPORT.get_pluralize( "coach" ) #self.class )
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


	def where #argv
		table_name = SUPPORT.get_pluralize( "post" ) #self.class )
		query = SUPPORT.generate_where( table_name, { "id" => "3" }, [ "id", "owner", "description" ] )
		begin
			record = CONN.prepare( "#{query}" )
			record.execute()
			record.map { |r| printf " ID : %d, OWNER : %s, DISCRIPTION : %s \n",r[0], r[1], r[2] }	

		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
			
		end

	end

	def joins argv
		
		table_name = SUPPORT.get_pluralize("#{self.class}")
		query = SUPPORT.generate_join( table_name, argv )

		begin
			record = CONN.prepare( query )
			record.execute()
			return record			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
			
		end
	end


	def index argv
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
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

	def dindex argv
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
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


	def test
		puts " Its successfully inherited. "
		#puts self.class
	end

	def show
		#puts "Enter a choice..."
		#puts "1.Create Table."
		#puts "2.Drop Table."
		#puts "3.Insert Record."
		#puts "4.Quit"
		#choice = gets.chomp
		#case choice
			#while 1
			#end
		#puts "Enter a table name."
		#create()			
		#insert()
		#remove()
		#update()
		#drop(gets.chomp)
		#where()
	end
	
end