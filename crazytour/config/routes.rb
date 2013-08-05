Crazytour::Application.routing_config do |app|
	# This is the file where you make all the routing configuratons
	# You can have the root of your site routed with "root"
	# by default it is public/index.html.
	# app.root "guides#show_guides"

	# Sample Get Request
		# app.get path: "path", controller: "controller_name", action: "action_name"
		app.get path: "post_review", controller: "places", action: "post_review"
		app.get path: "create_place", controller: "places", action: "create_place"
		app.get path: "create_guide", controller: "guides", action: "create_guide"
		app.get path: "show_guides", controller:"guides",action:"show_guides"
		app.get path: "show_place", controller:"places", action: "show_place" 
		
end
