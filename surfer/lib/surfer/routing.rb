module Surfer

	class Application
		@@routes_controller=[]
		def get_controller_and_action(env)
			unwanted, cont, action, after = env["PATH_INFO"].split('/', 4)
			puts "Inside"
			puts cont
			route =  @@routes_controller.select{|f| f[:path] == "#{cont}"}
			puts route.empty?
			if(route.empty?)
				return ["0","0","0"]
			else
				cn = route[0]
				puts cn[:path]
				puts cn[:controller]
				puts cn[:action]
				cont = cont.capitalize # Capitalize Controller eg : Webonise
				if(action.nil?)
					action=cn[:action]
				end
				if(action!=cn[:action])
					return ["0","0","0"]
				end
				# Append Controller eg : WeboniseController
				[Object.const_get(cont+"Controller"), action, cont]
			end
		end

		def self.get args
			@@routes_controller<<args
		end

		def self.check_route (cont)
			puts "Inside"
			route =  @@routes_controller.select{|f| f[:controller] == "#{cont}"}
			puts route
			cn = route[0]
			puts cn[:path]
			puts cn[:controller]
			puts cn[:action]
		end
	end
end