class ReadDbFile

	require 'yaml'
	require 'fileutils'

	def read_file
		FileUtils.chdir "../"
		FileUtils.cd "file_based"
		docs = YAML::load(File.read('database.yml') ) 
		return docs
	end
	
end

