#!/usr/bin/env ruby

class CreateSkeleton
  require 'fileutils'
  def create_folder str
    FileUtils.mkdir "#{str}"
    FileUtils.cd "#{str}"
    FileUtils.mkdir "app"
    FileUtils.cd "app"
    FileUtils.mkdir "controllers"
    FileUtils.mkdir "models"
    FileUtils.mkdir "views"
    FileUtils.chdir "../"
    FileUtils.mkdir "config"
    FileUtils.cd "config"
    FileUtils.touch "database.yml" 																 
    FileUtils.touch "routes.rb"
    FileUtils.chdir "../"
    FileUtils.touch "config.ru"
	end

		def write_database_file
			FileUtils.cd "config"
			file = File.open("database.yml", "w+")
			file.puts "# MySQL.  Versions 4.1 and 5.0 are recommended."
			file.puts "#"
			file.puts "# Install the MYSQL driver"
			file.puts "#   gem install mysql2"
			file.puts "#"
			file.puts "development:"
			file.puts "  adapter: "
			file.puts "  encoding: utf8"
			file.puts "  database: "
			file.puts "  pool: 5"
			file.puts "  username: "
			file.puts "  password: "
			file.puts "  socket: "
			file.close()
		end

		def write_config_file str
			FileUtils.chdir "../"
			file = File.open("config.ru", "w+")
			file.puts "require ::File.expand_path('../config/application',__FILE__)"
			file.puts "run #{str.capitalize!}::Application.new"
		end

end

making = CreateSkeleton.new
puts " Enter the Application name."
name = gets.gsub!(/\s/,'')
if name.nil?
  puts " Application name is empty. "
else
  making.create_folder(name)
	making.write_database_file
	making.write_config_file(name)
	
end
