class BaseStructure
	def initialize
		@render_stmts = Array.new
		@use_layout = true
		@next_actions = Array.new
	end
	attr_accessor :render_stmts, :use_layout, :next_actions
end

class Helper < BaseStructure
	def initialize(fname, cname)
		super()	
		@file_name = fname
		@name = cname
		@upper_class = nil
		@actions = Array.new
	end
	attr_accessor :name, :upper_class, :actions, :file_name
	def exist_layout
		return false
	end
end

class Controller < BaseStructure
	def initialize(fname, cname)
		super()
		@file_name = fname
		@name = cname
		#Here they are default renders
		##puts "Find new class #{cname}"
		@upper_class = nil
		@actions = Array.new
	end
	attr_accessor :name, :upper_class, :actions, :file_name
	def get_layout_render
		controller_path = get_controller_downcase(@name).split("::")
		controller_path = controller_path.join("/")
		file_path = "#{$path_prefix}/#{$new_view_folder_name}/layouts/#{controller_path}.html.erb"
		exist = File.exist?(file_path)
		if exist
			##puts "#{@name}: Default layout path = #{file_path}"
			rnder = Render_stmt.new(self, nil, file_path)
			rnder.is_layout = true
		end
	end
	def find_layout(layout_name)
		file_path = "#{$path_prefix}/#{$new_view_folder_name}/layouts/#{layout_name}.html.erb"
		exist = File.exist?(file_path)
		if exist
			##puts "#{@name}: Defined layout path = #{file_path}"
			rnder = Render_stmt.new(self, nil, file_path)
			rnder.is_layout = true
		end
	end
	def exist_layout
		@render_stmts.each do |r|
			if r and r.is_layout
				return true
			end
		end
		return false
	end
	def get_layout
		@render_stmts.each do |r|
			if r and r.is_layout
				return r
			end
		end
		return nil
	end
end

class Action < BaseStructure
	def initialize(controller, aname, ast)
		super()
		@controller = controller
		controller.actions.push(self)
		@name = aname
		#This array collects all the renders solved recursively
		#Final merge_controller append all renders to the end of the action
		@render_stack = Array.new
		@is_entrance = false
		@astnode = ast
		@replaced_code = ""
		##puts "Find new action #{controller.name}.#{aname}"
	end
	attr_accessor :name, :controller, :render_stack, :is_entrance, :astnode, :replaced_code
	def get_default_render
		controller_path = get_controller_downcase(@controller.name).split("::")
		controller_path = controller_path.join("/")
		file_path = "#{$path_prefix}/#{$new_view_folder_name}/#{controller_path}/#{@name}.html.erb"
		exist = File.exist?(file_path)
		#puts "start #{self}"
		if exist
			##puts "default render path = #{file_path}, exist = #{exist}"
			rnder = Render_stmt.new(self, nil, file_path)
			rnder.is_default = true
			#puts "rnder #{self.name} #{self.render_stmts.length} #{self}"
			return rnder
		end
	end
	def exist_template
		@render_stmts.each do |r|
			if r.is_default
				return true
			end	
		end
		return false
	end
	def get_template
		@render_stmts.each do |r|
			if r.is_default
				return r
			end
		end
		return nil
	end
	def push_to_render_stack(r)
		@render_stack.each do |rnd|
			if rnd.valid_file_path and r.valid_file_path and same_file(rnd.render_file, r.render_file)
				return false
			end
		end
		@render_stack.push(r)
		return true
	end
	def has_non_default_or_layout_render
		@render_stmts.each do |r|
			if r.is_default == false and r.is_layout == false
				return true
			end
		end
		return false
	end
end

class View_file < BaseStructure
	def initialize(file_path)
		super()
		@file_path = file_path
		state = 0
		@controller = ""
		@action = ""
		@render_stack = Array.new
		words = file_path.split("/")
		words.each do |p|
			if p == $new_view_folder_name
				state = 1
			elsif state == 1
				@controller = p
				break	
			end
		end
		state = 0
		file_path.split("/").reverse.each do |p|
			if state == 0
				@action = p.gsub(".html.erb","")
				state = 1
			elsif state == 1
				if p != @controller
					@controller += "::#{p}"
					if File.directory?(words[0...-2].join('/'))
					else
						run_command("mkdir #{words[0...-2].join('/')}")
					end
				end
				break
			end
			$controller_names_downcase.push(@controller) unless $controller_names_downcase.include?(@controller)
		end
		if File.directory?(words[0...-1].join('/'))
		else
			run_command("mkdir #{words[0...-1].join('/')}")
		end
		##puts "\tcontroller = #{@controller}, action = #{@action}"
	end
	attr_accessor :file_path, :controller, :action, :render_stack
	def get_content	
		content = File.open(@file_path, "r").read
		return content
	end
	def push_to_render_stack(r)
		@render_stack.each do |rnd|
			if rnd.valid_file_path and r.valid_file_path and same_file(rnd.render_file, r.render_file)
				return false
			end
		end
		@render_stack.push(r)
		return true
	end
	def has_non_default_or_layout_render
		@render_stmts.each do |r|
			if r.is_default == false and r.is_layout == false
				return true
			end
		end
		return false
	end
end

$render_key_words=["ident","tstring_content","kw", "int"]
class Render_stmt
	def initialize(action, astnode, file_path="")
		#type of action can be: Controller, Action, View_file
		@action = action
		action.render_stmts.push(self) if action
		@render_file = file_path
		@is_default = false
		@is_layout = false
		@astnode = astnode
		@properties = Hash.new
		@locals = nil
		@collection = nil
		@as = nil
		self.parse_render
	end
	attr_accessor :is_default, :is_layout, :astnode, :action, :render_file, :locals, :collection, :as, :properties
	def get_content
		if File.exist?(@render_file)
			content = File.open(@render_file, "r").read
			return content
		else
			return ""
		end
	end
	def valid_file_path
		return @render_file.length > 0
	end
	def parse_render
		if @astnode == nil
			return
		end
		set_layout = false
		$node_stack = Array.new
		recursive_parse_render(@astnode, $render_key_words)
		#if @action.instance_of?Action
		#	print "#{@action.controller.name}.#{@action.name}:"
		#end
		##puts "parse render: #{@astnode.source} (#{$node_stack.length})"
		state = 0
		str = "\t"
		hash_key = ""
		$node_stack.each do |n|
			if state == 0 and n.type.to_s == "ident"
				str += "), (#{n.source} =>"
				hash_key = n.source
				state = 1
			elsif state == 1 or hash_key == ''
				str += " #{n.source} "
				@properties[hash_key] = n.source
				state = 0
			end
		end
		# extract locals
		l = parse_render_variables(@astnode, 'locals')
		$hash_table = {}
		parse_locals_hash(l)
		if $hash_table.length > 0
			@locals = $hash_table
		end

		# extract collection

		@collection = parse_render_variables(@astnode, 'collection')

		if @collection and @collection[1]
			var_col = @collection[1][0].source
			as = parse_render_variables(@astnode, 'as')
			if as
				@as = as[1][0][0][0]
			end
		end
		@collection = var_col
		##puts str	
		@properties.each do |k,v|
			#puts "@@@@@@@ k #{k} @@@@@@@ v #{v}" 
			if k == "partial" or k == "template" or k == "action" or k == ""
				name = ""
				if @action.instance_of?Action
					#TODO: for helpers, if a helper is included in a function, it should search for the name of that function, instead of helper class name...
					name = get_controller_downcase(@action.controller.name).gsub("::","/")
				elsif @action.instance_of?View_file
					name = @action.controller.gsub("::","/")
				end
				file_path = ""
				if v.include?'/'
					chs = v.split('/')
					fp1 ="#{$path_prefix}/#{$new_view_folder_name}/#{chs[0...-1].join("/")}/_#{chs[-1]}.html.erb"
					fp2 ="#{$path_prefix}/#{$new_view_folder_name}/#{chs[0...-1].join("/")}/#{chs[-1]}.html.erb"
					if k == "partial"
						file_path ="#{$path_prefix}/#{$new_view_folder_name}/#{chs[0...-1].join("/")}/_#{chs[-1]}.html.erb"
					else
						file_path ="#{$path_prefix}/#{$new_view_folder_name}/#{chs[0...-1].join("/")}/#{chs[-1]}.html.erb"
					end
					if @collection and not @as
						@as = chs[-1]
					end
				else
					fp1 = "#{$path_prefix}/#{$new_view_folder_name}/#{name}/_#{v}.html.erb" 
					fp2 = "#{$path_prefix}/#{$new_view_folder_name}/#{name}/#{v}.html.erb" 
					if k == "partial"
						file_path = "#{$path_prefix}/#{$new_view_folder_name}/#{name}/_#{v}.html.erb" 
					else
						file_path = "#{$path_prefix}/#{$new_view_folder_name}/#{name}/#{v}.html.erb" 
					end

					if @collection and not @as
						@as = v
					end
				end
				puts "-------file_path #{fp1} #{fp2}"
				[fp1, fp2].each do |file_path|
					ex = File.exist?(file_path) 
					if ex
						@render_file = file_path	
					end
				end
			elsif k == "layout"
				if v == "false"
					@action.use_layout = false
					set_layout = true
				else
					file_path = "#{$path_prefix}/#{$new_view_folder_name}/layouts/#{v}.html.erb"
					if File.exist?(file_path)
						@render_file = file_path
						@is_layout = true
						f = open(file_path)
					end
				end
			end
		end
		# debug
		
		#puts "Source #{@astnode.source} Locals: #{locals} Collection #{@collection} As: #{@as}"
		#puts "File: #{@render_file}"
		if @render_file.length == 0 and @astnode and set_layout == false
			str = "Empty render -> "
			if @action.instance_of?Action
				str += "#{@action.controller.name}.#{@action.name}: "
			elsif @action.instance_of?View_file
				str += "#{@action.file_path}: "
			end
			str += "#{@astnode.source.to_s}"
			#puts str
		end
	end
end

