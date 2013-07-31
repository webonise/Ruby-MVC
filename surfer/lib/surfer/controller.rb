module Surfer
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
      puts pth
      content = File.read(pth)
      eruby = Erubis::Eruby.new(content)
      eruby.result(binding())
    end
  end
end
