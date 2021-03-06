module Surfer
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
    FileUtils.touch "application.rb"
    FileUtils.touch "database.yml" 																 
    FileUtils.touch "routes.rb"
    FileUtils.chdir "../"
    FileUtils.mkdir "public"
    FileUtils.cd "public"
    FileUtils.touch "index.html"
    FileUtils.touch "page_not_found.html"
    FileUtils.chdir "../"
    FileUtils.touch "Gemfile"
    FileUtils.touch "config.ru"
	end

	def write_database_file
		FileUtils.cd "config"
		file = File.open("database.yml", "w+")
		file.write "# MySQL.  Versions 4.1 and 5.0 are recommended.\n"
		file.write "#\n"
		file.write "# Install the MYSQL driver\n"
		file.write "#   gem install mysql2\n"
		file.write "#\n"
		file.write "development:\n"
		file.write "  adapter: \n"
		file.write "  encoding: \n"
		file.write "  database: \n"
		file.write "  pool: \n"
		file.write "  username: \n"
		file.write "  password: \n"
		file.write "  socket: \n"
		file.close()
	end

	def write_application_file str		
		str.capitalize!
		file = File.open("application.rb", "w+")
		file.puts 'require "surfer"'+"\n\n"
		file.puts "require 'fileutils'\n"
		file.puts "Dir[File.join(File.dirname(__FILE__), '../app/models/', '*.rb')].each {|file| require file }"
		file.puts "Dir[File.join(File.dirname(__FILE__), '../app/controllers/', '*.rb')].each {|file| require file }"
		file.puts 'root_pth= `pwd`'
		file.puts 'root_pth=root_pth.gsub(/[\s|\n]/,"")'
		file.puts 'ROOT_PATH = root_pth'+"\n\n"
		file.puts "module #{str}"
		file.puts '	class Application < Surfer::Application'
		file.puts '	end'
		file.puts 'end'+"\n\n"
		file.puts 'load "#{ROOT_PATH}/config/routes.rb"'
		file.close()
	end

	def write_routes_file str
		file = File.open("routes.rb", "w+")
		file.puts "#{str}::Application.routing_config do |app|"
		file.puts "	# This is the file where you make all the routing configuratons"
		file.puts '	# You can have the root of your site routed with "root"'
		file.puts '	# by default it is public/index.html.'
		file.puts '	# app.root "computers#show"'+"\n\n"
		file.puts "	# Sample Get Request"
		file.puts '		# app.get path: "path", controller: "controller_name", action: "action_name"'
		file.puts '		# eg: app.get path: "bikers", controller: "Bikers", action: "index"'
		file.puts 'end'
		file.close()
	end

	def write_config_file str
		#puts `pwd`
		str.capitalize!
		FileUtils.chdir "../"
		# puts `pwd`
		file = File.open("config.ru", "w+")
		file.puts "require ::File.expand_path('../config/application',__FILE__)"
		file.puts "run #{str}::Application.new"
		file.close()
	end

	def write_gem_file
		file = File.open("Gemfile", "w+") 
		file.puts "source :rubygems"
		file.puts "gem 'surfer'"
		file.close()
	end

	def write_html_pages(app_name)
		FileUtils.cd "public"
		file = File.open("index.html", "w+")
		file.puts "<h1 align=\"center\">Home Page of #{app_name}</h1>"
		file.close()
		file = File.open("page_not_found.html", "w+")
		file.puts "<h1 align=\"center\"> 404 </h1>}"
		file.puts "<h3 align=\"center\">Sorry -- Page Not Found</h3>"
		file.puts "<h4 align=\"center\">Please Check routes.rb for routing mismatch</h3>"
		file.close()
	end

	def generate app_name
	
		app_name=app_name.gsub(/\s/,'')
		if app_name.nil?
  			puts " Application name is empty. "
		else
			create_folder(app_name)
			write_database_file
			write_application_file(app_name)
			write_routes_file(app_name)
			write_config_file(app_name)
			write_gem_file
			write_html_pages(app_name)
			dir = `pwd`
			cmd = "cd #{dir} && bundle install".gsub(/\n/,"") 
			exec cmd
		end
	end

end
end