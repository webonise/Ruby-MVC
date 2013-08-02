module Surfer
	require 'fileutils'
	require ::File.expand_path('../connection',__FILE__)
	require ::File.expand_path('../support',__FILE__)
	require ::File.expand_path('../readdb',__FILE__)
class Generate

	CONNECT = Connection.new  
	SUPPORT = Support.new

	def create(arguments) 
		query = SUPPORT.create_table(arguments)
		begin
			@conn = CONNECT.create_connection
			@conn.do("#{query}")
			@conn.commit
			create_model_files(arguments[2])
		rescue DBI::DatabaseError => e
			puts "Error code : #{e.err}"
			puts "Error message : #{e.errstr}"
			@conn.rollback
		else
			puts "Table is created."
			CONNECT.close_connection	
		end
	end


	def create_model_files (model_name)
		model_class=model_name.capitalize
		FileUtils.cd "app"
		FileUtils.cd "models"
		file = File.open("#{model_name}.rb", "w+")
		file.write "class #{model_class} < Surfer::Operation\n"
		file.write "end"
		file.close()
	end

	def create_controller_files (controller_name)
		controller_class=controller_name.capitalize
		if(!File.directory?("app"))
			abort ("Please Switch to your Application Directory")
		end
		FileUtils.cd "app"
		FileUtils.cd "controllers"
		file = File.open("#{controller_name}_controller.rb", "w+")
		file.write "class #{controller_class}sController < Surfer::Controller\n"
		file.write " def index\n"
		file.write " end\n"
		file.write "end"
		file.close()
		FileUtils.chdir "../"
		FileUtils.cd "views"
		if(!File.directory?("#{controller_name}s"))
			FileUtils.mkdir "#{controller_name}s"
			FileUtils.cd "#{controller_name}s"
			file = File.open("index.html.erb", "w+")
			file.write "#{controller_class}sController index Action"
			file.close()
		end

	end
end
end