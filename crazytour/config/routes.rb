Crazytour::Application.routing_config do |app|
	# This is the file where you make all the routing configuratons
	# You can have the root of your site routed with "root"
	# by default it is public/index.html.
	# app.root "guides#show_guides"

	# Sample Get Request
		# app.get path: "path", controller: "controller_name", action: "action_name"
		app.get path: "places", controller: "guides", action: "index"
		app.get path: "guides", controller: "guides", action: "show_guides"
end
