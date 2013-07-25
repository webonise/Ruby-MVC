require "surfer"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")

require "bikers_controller"

ROOT_PATH = `pwd`

module Webonise
	class Application < Surfer::Application
	end
end