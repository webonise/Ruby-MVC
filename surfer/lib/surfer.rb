require "surfer/version"

module Surfer
  class Application
  	def call(env)
  		[200,{'Content-Type'=>'text/html'},["Ruby on surfer!"]]
  	end
  end
end
