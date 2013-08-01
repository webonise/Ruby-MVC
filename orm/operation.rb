class Operation

	require './connection'
	require './support'

	@@columns = nil
	CONNECTION = Connection.new
	SUPPORT = Support.new
	@conn =nil

																		# initializer method. 
	def initialize(arg={})
		self.class.set_columns
		arg.each do |a, v|
			eval("self.#{a} = '#{v}'")
		end
		#@args = Hash.new(arg)
	end

																		# Drop commnad.

	def self.drop 
		begin
			@conn = CONNECTION.create_connection
			table_name = SUPPORT.get_pluralize( "#{self.name}" )
			@conn.do( "DROP TABLE IF EXISTS #{table_name}" )
			@conn.commit
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback
		else
			puts "Table droped successfully."
		ensure
			CONNECTION.close_connection	
		end
	end

																# select All with attribute and without attribute command.

	def self.all attribute = {}
		objects = []
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		begin
			@conn = CONNECTION.create_connection
			if attribute.empty?
				record = @conn.prepare( " SELECT * FROM #{table_name} " )
			else
				record = @conn.prepare( " SELECT #{attribute} FROM #{table_name} " )
			end
			record.execute()
			@columns = record.column_names
			record.each do |e| 
				hash = {}
				e.entries.each_with_index do |v,i|
					@columns[i].to_sym
					hash[@columns[i].to_sym] = v
				end
				obj = self.new({})
				hash.each{|k,v| obj.send("#{k}=",v)}
				objects << obj
			end
			return objects
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
		else
			puts " Records fetched successfully. "
		ensure
			CONNECTION.close_connection	
		end
	end

																				# Save command.

	def save
		hash = {}
    self.class.columns.each do |c|
	    if c != "id"
	     	hash[c] = eval "self.#{c}"
	    end		#@args[0]
    end
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
		query = SUPPORT.generate_insert( table_name, hash )
		puts query
		begin
			@conn = CONNECTION.create_connection
			@conn.do(query)
			@conn.commit		
			self.id = @conn.select_one("SELECT LAST_INSERT_ID()").last
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback
		else
			puts " Record inserted successfully. "
		ensure
			CONNECTION.close_connection	
		end
	end

																				# Update Command.

	def update argv
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
		if self.id != nil
			query = SUPPORT.generate_update( table_name, argv, "id" => "#{self.id}" )
		else 
			puts " Record does not persist in database. "
			return
		end	
		begin
			@conn = CONNECTION.create_connection
			@conn.do(query)
			@conn.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback
		else
			puts " Record updated successfully. "			
		ensure
			CONNECTION.close_connection
		end
	end

																				# Remove Command

	def remove
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
		if self.id != nil
			query = SUPPORT.generate_remove( table_name, "id" => "#{self.id}" ) 
		else 
			puts " Record does not persist in database. "
			return
		end		
		puts query
		begin
			@conn = CONNECTION.create_connection
			if @conn.do(query) == 1
				@conn.commit
				self.id = nil
				puts " Record remove successfully. "	
			else
				puts " Record does not exist in database. "
			end	
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback	
		ensure
			CONNECTION.close_connection
		end
	end

																			# Where clouse.

	def self.where argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_where( table_name, argv )
		begin
			@conn = CONNECTION.create_connection
			objects = []
			record = @conn.prepare( "#{query}" )
			record.execute()
			@columns = record.column_names
			record.each do |e| 
				hash = {}
				e.entries.each_with_index do |v,i|
					@columns[i].to_sym
					hash[@columns[i].to_sym] = v
				end
				obj = self.new({})
				hash.each{|k,v| obj.send("#{k}=",v)}
				objects << obj
			end
			return objects
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
		else
			puts " Records fetched successfully. "	
		ensure
			CONNECTION.close_connection		
		end
	end

																				# Index creation.	

	def self.index argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_index( table_name, argv )

		begin
			@conn = CONNECTION.create_connection
			@conn.do(query)
			@conn.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback
		else
			puts " Index created successfully. "
		ensure
			CONNECTION.close_connection
		end
	end

																				# Index distroy.

	def self.dindex argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_dindex( table_name, argv )

		begin
			@conn = CONNECTION.create_connection
			@conn.do( query )
			@conn.commit			
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			@conn.rollback
		else
				puts " Index removes successfully. "		
			ensure
				CONNECTION.close_connection
		end
	end	

																				# Loading Table column from database.

	def self.set_columns
		unless @@columns
			table_name = SUPPORT.get_pluralize(self.name)
			begin
				if @conn==nil 
					@conn = CONNECTION.create_connection
					record = @conn.prepare( " select * from #{table_name} " )
					record.execute()
					@@columns = record.column_names
					set_accessor(self, @@columns )
				end
			rescue DBI::DatabaseError => e
				puts "Error code : #{e.err}"
				puts "Error message : #{e.errstr}"
			ensure
				if @conn
					CONNECTION.close_connection
				end				
			end			
		end
		@@columns
	end

																				# Setting Attribute accessor.

	def self.set_accessor(base,argv)
		argv.each do |c|
			base.class_eval do 
				attr_accessor c
			end
		end
	end

																			# setting column accessor. 
	def self.columns
		@@columns
	end
	
end