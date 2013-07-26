require "surfer/version"
require "surfer/routing"
require "surfer/controller"
require "erubis"

module Surfer
  
  class Application
  	def call(env)
  		if env['PATH_INFO']=='/favicon.ico'
  			return [404,{'Content-Type'=>'text/html'},[]]
  		end
      if env['PATH_INFO']=='/'
        pth=ROOT_PATH+"/public/index.html"
        pth=pth.gsub(/[\s|\n]/,"")
        content = File.read(pth)
        return[200,{'Content-Type'=>'text/html'},[content]]
      end
  		klass, act , resource = get_controller_and_action(env)
  		controller = klass.new(env: env, controller: klass, action: act , resource: resource)
  		d = controller.send(act)
      text = controller.render
  		[200,{'Content-Type'=>'text/html'},[text]]
  	end
  end
end