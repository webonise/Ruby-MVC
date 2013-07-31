require "surfer"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")

root_pth= `pwd`
root_pth=root_pth.gsub(/[\s|\n]/,"")
ROOT_PATH = root_pth

module Abc
	class Application < Surfer::Application
	end
end

load "#{ROOT_PATH}/config/routes.rb"
