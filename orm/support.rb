#!/usr/bin/ruby
class Support
	# class variable
	# instance variable
	# and global variable declaretion space. 
	def get_pluralize name
		until name.empty? 
			str = name.downcase.concat('s')
			return str
		end
	end

	def get_data_type key
		data_type = Hash.new 
		data_type["int"] = "INTEGER"
		data_type["string"] = "VARCHAR(50)"
		data_type["float"] = "INTEGER(20,5)" 
		data_type["integer"] = "INTEGER" 
		data_type["text"] = "TEXT" 
		data_type["date"] = "DATE" 
		#data_type[""] = 
		 
		tdata = data_type[key]
	end

	def create_field argv
		i = 1
		str = ""
		begin
			att = argv[i]	
			str << att
			str << "   "
			i = i.to_i + 2
			att1 = get_data_type(argv[i])
			str << att1
			if i.to_i != argv.length.to_i-1
				str << ","
				str << "\n"
				i = i.to_i + 2
			else 
				return str
			end
		end while i < argv.length.to_i
	end

	def create_table argv 
		query = "CREATE TABLE #{get_pluralize(argv[0])}( #{create_field(argv)} )"
		return query
	end


	def show

		#puts "Enter a key."
		#str = gets.chomp
		#puts "value is: #{get_data_type(str)}"

	end

end

#Support.new.create_table