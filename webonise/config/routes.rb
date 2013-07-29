Webonise::Application.routing_config do |app|
 app.root "computers#show"
 app.get path: "bikers", controller: "Bikers", action: "index"
 app.get path: "computers", controller: "Computers", action: "display_name" 
end
