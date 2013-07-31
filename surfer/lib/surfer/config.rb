module Surfer
	class Config
		def self.root_path
			current_path=`pwd`
			current_path=current_path.gsub(/[\s|\n]/,"")
		end
	end
end