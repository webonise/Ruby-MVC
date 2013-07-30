require "surfer/version"
require "surfer/routing"
require "surfer/controller"
require "erubis"

module Surfer
  
  class Application
    @@default_path="normal"
  	def call(env)
      if env['REQUEST_METHOD']=="GET"
    		if env['PATH_INFO']=='/favicon.ico'
          pth=ROOT_PATH+"/public/page_not_found.html"
          pth=pth.gsub(/[\s|\n]/,"")
          content = File.read(pth)
    			return [404,{'Content-Type'=>'text/html'},[content]]
    		end
        if env['PATH_INFO']=='/'
          if(@@default_path=="normal")  # If no routes are mentioned in the routes.rb file
            pth=ROOT_PATH+"/public/index.html"
            pth=pth.gsub(/[\s|\n]/,"")
            content = File.read(pth)
            return[200,{'Content-Type'=>'text/html'},[content]]
          else
            klass, act , resource=home_page
            controller = klass.new(env: env, controller: klass, action: act , resource: resource)
            d = controller.send(act)
            text = controller.render
            [200,{'Content-Type'=>'text/html'},[text]]
          end
        else
    		  klass, act , resource = get_controller_and_action(env)
          if(klass=="0")
             pth=ROOT_PATH+"/public/page_not_found.html"
             pth=pth.gsub(/[\s|\n]/,"")
             content = File.read(pth)
             return [404,{'Content-Type'=>'text/html'},[content]]
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
      puts "Inside routing_congig"
      yield(self)
    end

    def self.root(pth)
      @@default_path=""
      @@default_path=pth.split('#')
      puts @@default_path
    end

    def home_page 
      cont=@@default_path[0]
      action =@@default_path[1]
      autoload="#{cont}_controller"
      puts autoload
      require "#{autoload}"
      cont = cont.capitalize
      [Object.const_get(cont+"Controller"), action, cont]
    end


  end #end of Class
end # end of Module