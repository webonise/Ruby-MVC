require "surfer"

$LOAD_PATH << File.join(File.dirname(__FILE__),
"..", "app",
"controllers")
require "customers_controller"

module Webonise
	class Application < Surfer::Application
	end
end