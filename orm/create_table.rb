class CreateTable	

	require './connection'
	require './support'

	CONN = Connection.new.create_connection   #singlton design pattern.
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
end

CreateTable.new.create