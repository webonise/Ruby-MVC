module Surfer
	require ::File.expand_path('../connection',__FILE__)
	require ::File.expand_path('../support',__FILE__)
	class Operation
	# @@columns = nil
	# CONN = Connection.new.create_connection
	# SUPPORT = Support.new
	# @args

																		# initializer method. 
	def initialize(arg={})
		self.class.set_columns
		arg.each do |a, v|
			eval("self.#{a} = '#{v}'")
		end
		@args = Hash.new(arg)
	end

																		# Drop commnad.

	def self.drop 
		begin
			table_name = SUPPORT.get_pluralize( "#{self.name}" )
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

																# select All with attribute and without attribute command.

	def self.all attribute = {}
		puts attribute.inspect
		objects = []
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		begin
			if attribute.empty?
				record = CONN.prepare( " SELECT * FROM #{table_name} " )
			else
				record = CONN.prepare( " SELECT #{attribute} FROM #{table_name} " )
			end
			record.execute()
			@columns = record.column_names
			record.fetch do |e| 
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
		end
	end

																				# Save command.

	def save
		table_name = SUPPORT.get_pluralize( "#{self.class}" )
		query = SUPPORT.generate_insert( table_name, @args[0] )
		puts query
		begin
			CONN.do(query)
			CONN.commit		
			self.id = CONN.select_one("SELECT LAST_INSERT_ID()").last
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback
		else
			puts " Record inserted successfully. "
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
			if CONN.do(query) == 1
				CONN.commit
				self.id = nil
				puts " Record remove successfully. "	
			else
				puts " Record does not exist in database. "
			end	
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"	
			CONN.rollback					
		end
	end

																			# Where clouse.

	def self.where argv
		table_name = SUPPORT.get_pluralize( "#{self.name}" )
		query = SUPPORT.generate_where( table_name, argv )
		begin
			objects = []
			record = CONN.prepare( "#{query}" )
			record.execute()
			@columns = record.column_names
			record.fetch do |e| 
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
		end
	end

																				# Index creation.	

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

																				# Index distroy.

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

																				# Loading Table column from database.

	def self.set_columns
		unless @@columns
			table_name = SUPPORT.get_pluralize(self.name)
			record = CONN.prepare( " select * from #{table_name} " )
			record.execute()
			@@columns = record.column_names
			set_accessor(self, @@columns )
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
end