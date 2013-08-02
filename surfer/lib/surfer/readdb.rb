module Surfer
	require ::File.expand_path('../config',__FILE__)
	class ReadDbFile
		require 'yaml'
		require 'fileutils'
		def read_file
			db_path= Config.root_path+"/config/database.yml"
			puts "DataBase Configuration Path #{db_path}"
			begin 
				docs = YAML::load(File.read(db_path) )
			rescue
				abort ("Your Not Inside any Application\n Please change your directory to Application Directory")
			end
			return docs
		end
	end
end
