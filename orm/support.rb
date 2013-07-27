#!/usr/bin/ruby
class Support
	### class variable
	## instance variable
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
		str = " id    INTEGER   AUTO_INCREMENT   PRIMARY KEY, "
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

	def generate_insert tab_name, argv
		
		attribute = ""
		attribute << "id,"
		i = 0
		argv.each do |k,v|
			attribute << k
			i = i.to_i + 1
			if i != argv.length
				attribute << ","
			end
		end

		val = []
		val << "NULL"
		i = 0
		begin
			val << argv[argv.keys[i]]
			i = i.to_i + 1 		
		end while i < argv.length.to_i		
		query = " INSERT INTO #{tab_name}(#{attribute}) VALUES (#{val * ","}) "
		#puts query
		return query
	end

	def generate_remove tab_name, argv
		condition = ""
		condition << "( "
		i = 0
		begin
			if  "condition" != argv.keys[i] 
				condition << argv.keys[i] 
				condition << "="
				condition << argv[argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			else
				condition << argv[argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			end	
		end while i < argv.length
		condition << ")"
		query = " DELETE FROM #{tab_name} WHERE#{condition} "
		#puts query
		return query
	end


	def generate_update tab_name, argv, cond_argv


	# Parsing updatable attribute
		attribute = ""
		i = 0
		begin
			attribute << argv.keys[i]
			attribute << " = "
			attribute << argv[argv.keys[i]]
			i = i.to_i + 1
			if i != argv.length
				attribute << ","
			end
		end while i < argv.length


	# Parsing conditional hashing argument.	
		condition = ""
		condition << "( "
		i = 0
		begin
			if  "condition" != cond_argv.keys[i] 
				condition << cond_argv.keys[i] 
				condition << "="
				condition << cond_argv[cond_argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			else
				condition << cond_argv[cond_argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			end	
		end while i < cond_argv.length
		condition << ")"

		query = " UPDATE #{tab_name} SET #{attribute} WHERE #{condition} "
		puts query
		return query
	end


	def generate_where tab_name, argv, att_argv


		# Parsing conditional hashing argument.	
		condition = ""
		condition << "( "
		i = 0
		begin
			if  "condition" != argv.keys[i] 
				condition << argv.keys[i] 
				condition << "="
				condition << argv[argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			else
				condition << argv[argv.keys[i]] 
				condition << " "
				i = i.to_i + 1
			end	
		end while i < argv.length
		condition << ")"


		if att_argv.length == 0
			query = " SELECT * FROM #{tab_name} WHERE #{condition} "
			puts query
			return query
		else
			query = " SELECT #{att_argv * ","} FROM #{tab_name} WHERE #{condition} "	
			puts query
			return query
		end
	end

	#a
	def generate_join tab_name, argv

		query = " SELECT #{tab_name}.* FROM #{tab_name} #{argv} "
		puts query
		return query

	end 

	def generate_index tab_name, argv

		query = " CREATE INDEX #{argv[argv.keys[0]]}  ON #{tab_name} (#{argv[argv.keys[1]]}) "
		puts query
		return query
	end
	

	def generate_dindex tab_name,argv
		query = " ALTER TABLE #{tab_name} DROP INDEX #{argv[argv.keys[0]]} "
		puts query
		return query

	end

end
