require "surfer"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")

ROOT_PATH = `pwd`

module Webonise
	class Application < Surfer::Application
	end
end
load "/home/webonise/Projects/github/Ruby-MVC/Ruby-MVC/webonise/config/routes.rb"
