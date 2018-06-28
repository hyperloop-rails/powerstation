require 'pathname'
def os_walk(dir)
  root = Pathname(dir)
  files, dirs = [], []
  Pathname(root).find do |path|
    unless path == root
      dirs << path if path.directory?
      files << path if path.file?
    end
  end
  [root, files, dirs]
end

def read_dynamic_typing_info
	Dir.glob($log_files) do |item|
		next if item == '.' or item == '..'
		class_name = get_mvc_name(item)
		class_handler = nil
		if $class_map.has_key?(class_name) == false
			$class_map.each do |keyc, valuec|
				if keyc.include?("::") and remove_module_info(keyc) == class_name
					class_handler = valuec
				end
			end
		else
			class_handler = $class_map[class_name]
		end
		if class_handler == nil
			$class_map.each do |kc, vc|
				#puts "#{kc}"
				n_split = kc.split("::")
				n_split.each do |nn|
					if class_name == nn
						class_handler = vc
					end
				end
		end
		end
		if class_handler == nil
			abort("Class #{class_name} (#{item}) cannot be found!")
		end
		file = File.open(item, "r")
		file.each_line do |line|
			c_array = line.split(": ")
			func_name = c_array[0].chomp
			if c_array.length > 1
				var_name = c_array[1].split(" -> ")[0].chomp
				class_name = c_array[1].split(" -> ")[1].chomp
				class_handler.addMethodVar(func_name, var_name, class_name)	
			#elsif
			#	puts "FUNCTION #{func_name} DOESN'T HAVE VARS"
			end
		end	
	end
end

def read_each_class(class_name, class_node, filename)
		$cur_class = Class_class.new(class_name)
		
		if class_node.children[1].type.to_s == "const_path_ref" or class_node.children[1].type.to_s  == "var_ref"
			#upper_class = class_node.children[1].source.to_s
			$cur_class.setUpperClass(class_node.children[1].source.to_s)
		end
		
		#puts "class #{class_name} < #{$cur_class.getUpperClass}"	
		$class_map[class_name] = $cur_class
		$cur_class.filename = filename
		level = 0
		traverse_ast(class_node, level)
end

#read table name list 
def read_table_names(filepath)
	file_table = File.open(filepath)
	file_table.each do |line|
		$table_names = $table_names.push(line.chomp)
	end
	def check_table_name(varname)
		if $table_names.include?(varname) then
			return true
		else
			return false
		end
	end
	#puts "Tables = #{$table_names}"
end

#read keywords list
def read_key_words
	File.open("keywords.txt").each do |line|
		line_array = line.chomp.split(' ')
		$key_words[line_array[0]] = line_array[1]
	end
	File.open("ignore_method_list.txt").each do |line|
		line = line.gsub("\n","")
		$ignore_method_list.push(line)
	end
end

def handle_single_file(item)
	file = File.open(item, "r")
	contents = file.read
	#puts "HANDLE file: #{item}"
	ast = YARD::Parser::Ruby::RubyParser.parse(contents).root
	@class_stack = Array.new
	recursive_get_class_stack(ast, @class_stack, item)
end


def read_ruby_files(application_dir=nil)
	
	if application_dir != nil
		$app_dir = application_dir
	end
	$log_files = "#{$app_dir}/logs/*.log"
	$table_file = "#{$app_dir}/table_name.txt"
	
	#read_table_names($table_file)
	read_key_words

	root, files, dirs = os_walk($app_dir)
	for filename in files
		if filename.to_s.end_with?(".rb") and filename.to_s.end_with?("schema.rb") == false
			#puts "Filename = #{filename.to_s}"
			handle_single_file(filename.to_s)
		end
	end
	
	
	#TODO: It should recursively resolve upper class, here I just hope the inherit length is less than 2...
	resolve_upper_class
	resolve_upper_class
	read_schema($app_dir)
	retrieve_func_calls

end


def read_ruby_files_with_template(application_dir, template_name)
end
