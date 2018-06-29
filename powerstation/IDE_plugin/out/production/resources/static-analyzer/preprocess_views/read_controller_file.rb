require 'yard'

def read_entrance_actions
	fp = File.open("#{$path_prefix}/calls.txt", "r")
	fp.each_line do |line|
		chs = line.gsub("\n","").split(",")
		$actions.each do |k, a|
			if get_controller_downcase(a.controller.name) == chs[0] and a.name == chs[1]
				a.is_entrance = true
			end
		end
	end
end

def read_controller_files(file_dir, is_controller)
	root, files, dirs = os_walk(file_dir)
	for filename in files
		if filename.to_s.end_with?(".rb")
			fp = File.open(filename.to_s, "r")
			contents = fp.read
			ast = YARD::Parser::Ruby::RubyParser.parse(contents).root
			@class_stack = Array.new
			recursive_get_class_stack(ast, @class_stack, filename.to_s, is_controller)
		end
	end
end

def recursive_get_class_stack(astnode, class_stack, filename, is_controller)
	if astnode.is_a?YARD::Parser::Ruby::AstNode
		if astnode.type.to_s == "class" or astnode.type.to_s == "module"
			class_stack.push(astnode)
			@class_name = ""
			for i in 0...class_stack.length-1
				@class_name += "#{get_class_name_from_class_node(class_stack[i])}::"
			end
			@class_name += "#{get_class_name_from_class_node(class_stack[-1])}"
			@include_function = false
			@has_sub = false
			astnode.children.each do |child|
				@has_subclass = false
				if child.type.to_s == "list"
					child.children.each do |c|
						if c.type.to_s == "class" or c.type.to_s == "module"
							@has_subclass = true
						end
					end
				end
				if class_includes_functions(child)
					@include_function = true
				end
				if @has_subclass
					@has_sub = true
					#read_each_class(@class_name, astnode, filename)
					recursive_get_class_stack(child, class_stack, filename, is_controller)
				end
			end
			if (@has_sub and @include_function) or @has_sub == false
				read_each_class(@class_name, astnode, filename, is_controller)
			else
				#puts "#{@class_name} is not read!!! #{@has_sub} #{@include_function}"
			end
			class_stack.pop
		else
			astnode.each do |child|
				recursive_get_class_stack(child, class_stack, filename, is_controller)
			end
		end 
	end
end

def read_each_class(class_name, class_node, filename, is_controller)
	if is_controller
		cur_controller = Controller.new(filename, class_name)
		$controllers[class_name] = cur_controller
		$cur_class = cur_controller
		$cur_class.get_layout_render
	else
		cur_helper = Helper.new(filename, class_name)
		$helpers[class_name] = cur_helper
		$cur_class = cur_helper
	end
	if class_node.children[1].type.to_s == "const_path_ref" or class_node.children[1].type.to_s  == "var_ref"
		upper_class = class_node.children[1].source.to_s
		$cur_class.upper_class = upper_class
	end

	level = 0
	$cur_action = nil
	traverse_ast(class_node, level)
end

def traverse_ast(astnode, level)
	
	if astnode.class.to_s == "YARD::Parser::Ruby::MethodDefinitionNode"
		@method_name = astnode.children[0].source.to_s
		if @method_name == "self"
			@method_name = astnode.children[2].source.to_s
		end
		$cur_action = Action.new($cur_class, @method_name, astnode.children[-1])
		if $cur_class.instance_of?Controller
			$cur_action.get_default_render
		end
		$actions["#{$cur_class.name}.#{@method_name}"] = $cur_action
		astnode.children.each do |child|
			traverse_ast(child, level+1)
		end
		$cur_action = nil
	elsif astnode.class.to_s == "YARD::Parser::Ruby::MethodCallNode" and astnode.type.to_s != "command"
		if astnode.children[0].source == "render"
			#puts "In #{$cur_class.name}.#{$cur_action.name}"
			#puts "\tFind render stmt: #{astnode.source}"
			#render stmt
			puts "ASTNODE: #{astnode.source}"
			rnder = Render_stmt.new($cur_action, astnode)
		elsif ["link_to","url_for","form_for","labelled_form_for"].include?astnode.children[0].source or astnode.children[0].source.start_with?("link_to")
			#Noting that here $cur_action can only be of View_file type
			if $cur_action.instance_of?View_file
				next_action = Next_action.new($cur_action, astnode)
			end
		else
			astnode.children.each do |child|
				traverse_ast(child, level+1)
			end
		end
	elsif astnode.type.to_s == "command" and astnode.children[0] and astnode.children[0].source == "layout"
		layout_name = get_left_most_leaf(astnode.children[1]).source
		if $cur_class.instance_of?Controller
			$cur_class.find_layout(layout_name)
		end
	elsif astnode.type.to_s == "command" and astnode.children[0] and astnode.children[0].source == "render"
		rnder = Render_stmt.new($cur_action, astnode)
		puts "\tFind render stmt in command: #{astnode.source}"
		if $cur_action
			puts "\t$cur_action: #{$cur_action}"
		end
	elsif astnode.type.to_s == "command" and astnode.children[0] and (["link_to","url_for","form_for","labelled_form_for"].include?astnode.children[0].source or astnode.children[0].source.start_with?("link_to"))
		if $cur_action.instance_of?View_file
			next_action = Next_action.new($cur_action, astnode)
		end
	elsif astnode.class.to_s != "Symbol"
		astnode.children.each do |child|
			traverse_ast(child, level+1)
		end
	end
end

def resolve_upper_class
	$controllers.each do |k, v|
		if v.upper_class and $controllers[v.upper_class]
			if v.exist_layout == false
				#assume all render stmts in controller are layout renders
				#XXX: new Render_stmt or just push r??
				#XXX: if just pushing r into array, r.controller = parent instead of self...
				v.render_stmts.push($controllers[v.upper_class].get_layout)
			end
		end
	end
	$actions.each do |k, v|
		if v.controller.upper_class and $controllers[v.controller.upper_class]
			if v.exist_template == false 
				$controllers[v.controller.upper_class].actions.each do |a|
					if a.name == v.name and a.exist_template
						v.render_stmts.push(a.get_template)
					end
				end
			end
		end
	end
end
