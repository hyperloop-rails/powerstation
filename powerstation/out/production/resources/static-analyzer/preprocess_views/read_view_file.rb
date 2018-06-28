def read_view_files
	root, files, dirs = os_walk($view_dir)
	for filename in files
		if filename.to_s.end_with?(".haml") 	
			run_command("python3 haml2html.py #{filename}")
			filename = filename.replace('haml', 'html.erb')
		end
		if filename.to_s.end_with?("html.erb") 
			new_file_name = filename.to_s.gsub($view_folder_name, $new_view_folder_name)
			#new_file_name = new_file_name.gsub('html.erb','rb')
			#TODO: full path
			view_file = View_file.new(new_file_name)
			view_path = new_file_name.gsub(File.basename(new_file_name),'')
			puts "VIEWPATH #{view_path}"
			run_command("mkdir -p #{view_path}")
			$view_files[new_file_name] = view_file
			puts view_file.file_path
			run_command("#{$extract_ruby_script} #{filename} #{new_file_name}")
			fp = File.open(view_file.file_path, "r")
			contents = fp.read
			puts "fp: #{view_file.file_path}"
			#puts "#{contents}"
			#ast = YARD::Parser::Ruby::RubyParser.parse(contents).root
			#TODO: This is a bit messy... $cur_action and view_file should be of different types
			$cur_action = view_file
		end
	end
	for filename in files
		if filename.to_s.end_with?(".haml") 	
			filename = filename.replace('haml', 'html.erb')
		end
		if filename.to_s.end_with?("html.erb") 
			new_file_name = filename.to_s.gsub($view_folder_name, $new_view_folder_name)
			#new_file_name = new_file_name.gsub('html.erb','rb')
			#TODO: full path
			view_file = View_file.new(new_file_name)
			view_path = new_file_name.gsub(File.basename(new_file_name),'')
			puts "VIEWPATH #{view_path}"
			run_command("mkdir -p #{view_path}")
			$view_files[new_file_name] = view_file
			puts view_file.file_path
			fp = File.open(view_file.file_path, "r")
			contents = fp.read
			puts "fp: #{view_file.file_path}"
			#puts "#{contents}"
			begin
				ast = YARD::Parser::Ruby::RubyParser.parse(contents).root
				#TODO: This is a bit messy... $cur_action and view_file should be of different types
				$cur_action = view_file
				traverse_ast(ast, 0)	
			rescue
			end
		end
	end
end

def find_view_file(view_file)
	$view_files.each do |k, v|
		if same_file(k, view_file) 
			return v
		end
	end
	return nil
end
