class Operation
	require './connection'
	require './support'

	CONN = Connection.new.create_connection   #single pattern.

	def create
		fields = Support.new.create_table(ARGV)
		begin
			CONN.do("#{fields}")
			CONN.commit
		puts "hello"
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
			CONN.rollback
		else
			puts "Table is created."
		end
	end

	def drop argu
		begin
			table_name = Support.new.get_pluralize(argu)
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

	def all
		class_name = Support.new.get_pluralize(self.class)
		begin
			result = CONN.
		rescue DBI::DatabaseError => e
			
		end
		


	end

	def insert

	end

	def update

	end

	def delete


	end

	def show
		#puts "Enter a choice..."
		#puts "1.Create Table."
		puts "2.Drop Table."
		#puts "3.Quit."
		#choice = gets.chomp
		#case choice
			#while 1
			#end
		puts "Enter a table name."
		drop(gets.chomp)	

	end


end

Operation.new.show