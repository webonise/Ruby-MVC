module Surfer
	class Options
		def self.all_opitons
			puts "Available Options"
			z="replace [whatever] with your requirements"
			puts "\033[34m#{z}\033[0m"
			puts "surfer new [app_name]"
			puts "surfer generate model [model_name] [fields]"
			puts "surfer generate contoller [controller_name]" 
		end
	end
	class Custom_Colors
		def black;          "\033[30m#{str}\033[0m" end
		def red;            "\033[31m#{str}\033[0m" end
		def green;          "\033[32m#{str}\033[0m" end
		def  brown;         "\033[33m#{str}\033[0m" end
		def blue;           "\033[34m#{str}\033[0m" end
		def magenta;        "\033[35m#{str}\033[0m" end
		def cyan;           "\033[36m#{str}\033[0m" end
		def gray;           "\033[37m#{str}\033[0m" end
		def bg_black;       "\033[40m#{str}\0330m"  end
		def bg_red;         "\033[41m#{str}\033[0m" end
		def bg_green;       "\033[42m#{str}\033[0m" end
		def bg_brown;       "\033[43m#{str}\033[0m" end
		def bg_blue;        "\033[44m#{str}\033[0m" end
		def bg_magenta;     "\033[45m#{str}\033[0m" end
		def bg_cyan;        "\033[46m#{str}\033[0m" end
		def bg_gray;        "\033[47m#{str}\033[0m" end
		def bold;           "\033[1m#{str}\033[22m" end
		def reverse_color;  "\033[7m#{str}\033[27m" end
	end
end