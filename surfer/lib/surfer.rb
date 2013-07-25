require "surfer/version"
require "surfer/routing"
require "erubis"
module Surfer
  klass=""
  act=""
  class Application
  	def call(env)
  		if env['PATH_INFO']=='/favicon.ico'
  			return [404,{'Content-Type'=>'text/html'},[]]
  		end
      if env['PATH_INFO']=='/'
        
        return[200,{'Content-Type'=>'text/html'},[content]]
      end
  		klass, act , resource = get_controller_and_action(env)
  		controller = klass.new(env: env, controller: klass, action: act , resource: resource)
  		d = controller.send(act)
      text = controller.render
  		[200,{'Content-Type'=>'text/html'},[text]]
  	end
  end

  class Controller
  		def initialize(args)
  			@env = args[:env]
        @controller = args[:controller]
        @action = args[:action]
        @resource = args[:resource].downcase
  		end

  		def env
  			@env
  		end

      def render
        pth=ROOT_PATH+"/app/views/#{@resource}/#{@action}.html.erb"
        pth=pth.gsub(/[\s|\n]/,"")
        puts pth
        template = File.read(pth)
        #content = File.read(pth)
        eruby = Erubis::Eruby.new(template)
        eruby.result(binding())
      end
  end 
end