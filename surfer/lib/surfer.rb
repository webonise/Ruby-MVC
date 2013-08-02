require "surfer/version"
require "surfer/routing"
require "surfer/controller"
require "erubis"
require "dbi"
require "mysql"
require "surfer/operation"
require "surfer/create"
require "surfer/options"
require "surfer/generator"

module Surfer
  
  class Application
    @@default_path="default_home_page"
  	def call(env)
      if env['REQUEST_METHOD']=="GET"
    		if env['PATH_INFO']=='/favicon.ico'
          page_not_found
    		end
        if env['PATH_INFO']=='/'
          if(@@default_path=="default_home_page")  # If no routes are mentioned in the routes.rb file
            default_home_page
          else
            klass, act , resource=custom_home_page
            controller = klass.new(env: env, controller: klass, action: act , resource: resource)
            d = controller.send(act)
            text = controller.render
            [200,{'Content-Type'=>'text/html'},[text]]
          end
        else
    		  klass, act , resource = get_controller_and_action(env)
          if(klass=="no_such_path"|| act == "no_such_action")
             page_not_found
          else
    		    controller = klass.new(env: env, controller: klass, action: act , resource: resource)
    		    d = controller.send(act)
            text = controller.render
    		    [200,{'Content-Type'=>'text/html'},[text]]
          end
        end
      else
        return[200,{'Content-Type'=>'text/html'},["POST not Yet Supported"]]
      end

  	end # end of call


    def self.routing_config
      puts "Inside routing_config"
      yield(self)
    end

    def self.root(pth)
      @@default_path=""
      @@default_path=pth.split('#')
      puts @@default_path
    end

    def custom_home_page 
      cont=@@default_path[0]
      action =@@default_path[1]
      autoload="#{cont}_controller"
      puts autoload
      # require "#{autoload}"
      cont = cont.capitalize
      [Object.const_get(cont+"Controller"), action, cont]
    end

    def page_not_found
      pth=ROOT_PATH+"/public/page_not_found.html"
      content = File.read(pth)
      return [404,{'Content-Type'=>'text/html'},[content]]
    end

    def default_home_page
      pth=ROOT_PATH+"/public/index.html"
      content = File.read(pth)
      return[200,{'Content-Type'=>'text/html'},[content]]
    end

    def self.display arg
      "Hello #{arg}"
    end



  end #end of Class
end # end of Module