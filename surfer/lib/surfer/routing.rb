module Surfer
	class Application
		def get_controller_and_action(env)
			unwanted, cont, action, after = env["PATH_INFO"].split('/', 4)
			cont = cont.capitalize # Capitalize Controller eg : Webonise
			cont += "Controller" # Append Controller eg : WeboniseController
			[Object.const_get(cont), action]
		end
	end
end