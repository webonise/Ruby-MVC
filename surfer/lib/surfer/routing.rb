module Surfer
	class Application
		def get_controller_and_action(env)
			unwanted, cont, action, after = env["PATH_INFO"].split('/', 4)
			cont = cont.capitalize # Capitalize Controller eg : Webonise
			# Append Controller eg : WeboniseController
			[Object.const_get(cont+"Controller"), action, cont]
		end
	end
end