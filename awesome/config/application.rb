require "surfer"

require 'fileutils'
Dir[File.join(File.dirname(__FILE__), '../app/models/', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), '../app/controllers/', '*.rb')].each {|file| require file }
root_pth= `pwd`
root_pth=root_pth.gsub(/[\s|\n]/,"")
ROOT_PATH = root_pth

module Awesome
	class Application < Surfer::Application
	end
end

load "#{ROOT_PATH}/config/routes.rb"
