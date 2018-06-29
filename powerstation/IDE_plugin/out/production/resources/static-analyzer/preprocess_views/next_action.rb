load 'helper.rb'
class Next_action
	def initialize(view_file, astnode)
		@astnode = astnode
		@controller = ""
		@action = ""
		@path_function = ""
		@view = view_file
		view_file.next_actions.push(self)
	end
	attr_accessor :controller, :action, :path_function, :astnode
	def valid_action
		return (@controller.length > 0 and @action.length > 0)
	end
	def parse_next_action
		na_stack = Array.new
		traverse_ast_and_get_path(na_stack, @astnode)
		hash_result = Hash.new
		recursive_parse_hash(@astnode, hash_result)
		if hash_result.length > 0
			if hash_result.has_key?"action" and hash_result.has_key?"controller"
				@controller = hash_result["controller"]
				@action = hash_result["action"]
			elsif hash_result.has_key?"action"
				@controller = @view.controller
				@action = hash_result["action"]
			end
		end
		if self.valid_action == false
			fname = get_left_most_leaf(@astnode).source
			if fname.start_with?("link_to_")
				c = has_controller(fname.gsub("link_to_",""))
				if c != nil
					@controller = c
					@action = "index"
				end
			end
		end
		if $only_generate_nextcall_pathfunc
			if na_stack.length > 0
				@path_function = na_stack[0]
			end
		else
			if na_stack.length > 0 and $path_funcs.has_key?(na_stack[0])
				r = $path_funcs[na_stack[0]]
				@controller = r[0]
				@action = r[1]
			end
		end
		if self.valid_action == false and @astnode.source.include?"form_for"
			v = get_first_localvar(@astnode)
			if v != nil
				c = has_controller(v)
				if c != nil 
					@controller = c
					@action = "new"
				end
			end
		end
		#debug
		if self.valid_action == false
			puts "URL PATH CANNOT FOUND: #{@astnode.source}"
		end
	end
end

def generate_path_func_script
	@path_funcs = Array.new
	#first collect all path funcs
	cnt = 0
	$view_files.each do |k, v|
		v.next_actions.each do |na|
			if na.path_function.length > 0
				@path_funcs.push(na.path_function) unless @path_funcs.include?(na.path_function)
			elsif na.valid_action == false
				#debug
				puts "#{cnt}: #{na.astnode.source} cannot find path function"
				cnt += 1
			end
		end
	end
	#Then generate a script to get controller_action for each path function
	fp = File.open("path_funcs.sh", "w")
	fp.puts "#!/bin/bash"
	#You should copy this file to the application directory and run the script, and copy the result back here
	fp.puts "rm path_funcs.txt"
	fp.puts "touch path_funcs.txt"
	@path_funcs.each do |pf|
		cmd = "Rails.application.routes.recognize_path(app.#{pf})"
		cmd1 = "echo \"PATHFUNC: #{pf}\" >> path_funcs.txt"
		cmd2 = "echo \"#{cmd}\" | bundle exec rails c >> path_funcs.txt"
		fp.puts cmd1
		fp.puts cmd2
	end
end

def read_path_funcs
	fp = File.open("./path_funcs.txt", "r")
	state = 0
	cur_path_func = ""
	fp.each_line do |line|
		if line.include?"PATHFUNC: "
			state = 1
			cur_path_func = line.gsub("\n","").gsub("PATHFUNC: ","")
		elsif line.include?"controller=>" and line.include?"action=>" and state == 1
			str_pos1 = line.index('{')
			str_pos2 = line.index('}')
			substr = line[str_pos1+1..str_pos2-1]
			r = Array.new
			controller = ""
			action = ""
			#:controller=>"account", :action=>"lost_password"
			#This is a crappy parser...
			chs = substr.split(", ")
			chs.each do |c|
				if c.include?("controller")
					controller = c.gsub(":controller=>","").gsub("\"","")
				elsif c.include?("action")
					action = c.gsub(":action=>","").gsub("\"","")
				end
			end
			if controller.length > 0 and action.length > 0
				r.push(controller)
				r.push(action)
				$path_funcs[cur_path_func]=r
				#puts "PATHFUNC: #{cur_path_func} controller = #{controller}, action = #{action}"
			end
			state = 0
		end
	end
end

def traverse_ast_and_get_path(na_stack, astnode)
	if astnode.children.length == 0 and (astnode.source.to_s.end_with?("_path") or astnode.source.to_s.end_with?("_url"))
		na_stack.push(astnode.source)
	else
		astnode.children.each do |child|
			traverse_ast_and_get_path(na_stack, child)
		end
	end
end

def get_first_localvar(astnode)
	if astnode.type.to_s == "ivar"
		return astnode.source.gsub("@","")
	end
	astnode.children.each do |c|
		v = get_first_localvar(c)
		if v != nil
			return v
		end
	end
	return nil
end

def find_view_file_by_path(render_file)
	$view_files.each do |k, v|
		if same_file(k, render_file) 
			return v
		end
	end
	return nil
end

def solve_next_actions
	$view_files.each do |k, v|
		v.next_actions.each do |a|
			a.parse_next_action
		end
	end
end

def generate_nextaction_files
	$actions.each do |k, a|
		if a.is_entrance
			fpname = "#{$next_action_dir}/#{a.controller.name}_#{a.name}.txt"
			fp = File.open(fpname, "w")
			@na_stack = Array.new
			a.render_stack.each do |r|
				vfile = find_view_file_by_path(r.render_file)	
				if vfile != nil
					vfile.next_actions.each do |na|
						if na.valid_action
							na_string = "#{na.controller},#{na.action}"
							#TODO: Now we don't deal with duplicate actions...
							@na_stack.push(na_string) #unless @na_stack.include?(na_string)
						end
					end
				end	
			end	
			@na_stack.each do |na|
				fp.puts na
			end
		end
	end
end
