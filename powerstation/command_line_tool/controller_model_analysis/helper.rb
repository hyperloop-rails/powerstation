require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/string'

def transform_controller_name(name)
	i = name.index("Controller")
	new_name = "#{(name[0...i-1]).downcase}_controller"
	return new_name
end

def is_ast_node(node)
	if node != nil and node.class.to_s == "YARD::Parser::Ruby::AstNode"
		return true
	elsif node != nil
		return node.class.ancestors.include?YARD::Parser::Ruby::AstNode
	else
		return false
	end
end

def is_transaction_function(fname)
	if fname and (fname.include?(".transaction_begin") or fname.include?(".transaction_end"))
		return true
	else
		return false
	end
end

def is_repeatable_function(fname)
	#if is_transaction_function(fname)
	#	return true
	#elsif $repeatable_list.include?(fname)
	#	return true
	#else
	#	return false
	#end
end

def in_key_words(w)
	if ["before_filter", "before_save", "before_validation",
			"before_create",
			"after_save", "after_validation", "after_create",
			"destroy_all", "delete_all"].include?(w)
		return true
	else
		return false
	end
end

def searchTableName(name)
	_name = name
	if name.index('.') != nil
		_name = name[0..(name.index('.')-1)]
	end
	$table_names.each do |t|
		if t.downcase.singularize == _name.delete('@').delete('_').downcase.singularize
			return t
		end
	end
	return nil
end

def searchModelName(name)
	$class_map.each do |k,v|
		if isActiveRecord(k)
			if k.downcase == name.delete('@').delete('_').downcase
				return k
			end
		end
	end
	return nil
end

def searchIncludeTableName(name)
	$table_names.each do |t|
		if name.downcase.include?(t.downcase)
			return t
		end
	end
end

def searchSelf(name, class_name)
	if name.index('.') != nil and name[0..(name.index('.')-1)] == "self"
		return class_name
	end
	if name == "self"
		return class_name
	end
	return nil
end

def searchVarRef(node)
	if is_ast_node(node)==false
		return nil
	end
	if node.type.to_s == "var_ref"
		return node
	end
	if node.children[0] != nil
		node.children.each do |child| 
			v = searchVarRef(child)
			if v != nil
				return v
			end
		end
	else
		return nil
	end
	return nil
end

def searchARef(node)
	if is_ast_node(node)==false
		reutnr nil
	end
	if node.type.to_s == "aref"
		return node
	end
	if node.children[0] != nil
		node.children.each do |child| 
			v = searchARef(child)
			if v != nil
				return v
			end
		end
	else
		return nil
	end
	return nil
end

def instr_trigger_save?(instr)
	if ["INSERT", "UPDATE"].include?instr.getQueryType and instr.getFuncname != "update_column"
		return true
	end
	return false
end
def instr_trigger_create?(instr)
	if ["INSERT"].include?instr.getQueryType and instr.getFuncname != "update_column"
		return true
	else
		return false
	end
end

def trigger_save?(call)
	if ["INSERT", "UPDATE"].include?call.getQueryType	
		return true
	end
	if ["save", "save!"].include?call.getFuncName
		return true
	end
	return false
end

def trigger_create?(call)
	if ["INSERT"].include?call.getQueryType	
		return true
	end
end

def isNonClosureInstr(instr)
	if instr.is_a?Call_instr and ["ruby_code_from_view","transaction","form_for","form_tag","content_for","content_tag","respond_to","xml","input","html","field_set_tag","json","lock","reject","cache","cache_if","lambda", "unscoped", "source_view"].include?instr.getFuncname	
		return true
	else
		return false
	end	
end

#read variable class list
def check_class_match(name)
	if $class_map.has_key?(name)
		return true
	end
	return false
end

def classname_partial_match(name)
	$class_map.each do |keyc, arrayc|
		if keyc.include?(name)
			return arrayc
		end
	end
	return nil
end

def transform_var_name(name)
	if name == nil
		return nil
	end
	$class_map.each do |keyc, arrayc|
		cname = name
		if name[0] == '@'
			cname = name[1..name.length-1]
		end
		if keyc.downcase == cname.downcase.singularize
			return keyc
		end
	end
	#$class_map.each do |keyc, arrayc|
	#	if keyc.include?("Controller")==false and keyc.downcase.include?(cname.downcase)
	#		return keyc
	#	end
	#end	
	return nil
end

#parse specific node
def get_left_most_leaf(node)
	rv = node	
	while is_ast_node(rv) do
		if rv.children.length > 0
			rv = rv.children[0]
		else
			break
		end
	end
	return rv
end

def get_mvc_name(filename)
	i = filename.rindex('/')
	j = filename.rindex('.')
	n = filename[i+1..j-1]
	return n
end

def get_mvc_name2(filename)
	i = filename.rindex('/')
	j = filename.rindex('.')
	n = filename[i+1..j-1]
	n[0] = n[0].upcase
	if n.include?('_')
		k = n.index('_')
		n[k+1] = n[k+1].upcase
		k = n.rindex('_')
		n[k+1] = n[k+1].upcase
		n = n.delete('_')
	end
	return n
end

def search_query_string(astnode)
	if astnode.type.to_s == "string_content"
		return astnode.source
	else
		str = nil
		astnode.children.each do |c|
			s = search_query_string(c)
			if s
				if str
					str += " ; #{s}"
				else
					str = s
				end
			end
		end
		return str
	end
end

def check_nonrepeat(class_name, func_name)
	$non_repeat_list.each do |n|
		chs = n.split('.')
		if chs[0].include?"ApplicationController" and class_name == chs[0] and func_name == chs[1] 
			return false
		end
		if $class_map[class_name] and $class_map[class_name].hasUpperClass?("ApplicationController") and func_name == chs[1]
			return false
		end
		if $non_repeat_list.include?"#{class_name}.#{func_name}"
			if func_name == "before_filter"
				return false
			end
			if class_name.include?"Controller" and ["show","create","index","new"].include?func_name
				return false
			end
		end
	end
	if $non_repeat_list.include?"#{class_name}.#{func_name}" and $non_repeatable_list.include?"#{class_name}.#{func_name}"
		return false
	end	
	return true
end

def dataflow_filename_match(dataflow_file_name)
	$class_map.each do |k, v|
		if v.filename != nil and v.filename.tr('/','').gsub('.rb','') == dataflow_file_name.tr('/','').gsub('dataflow','').gsub('.log','')
			return k
		end
	end
	return nil
end

def dataflow_filename_match_function(dataflow_file_name, funcname)
	match_list = Array.new
	$class_map.each do |k, v|
		if v.filename != nil and v.filename.tr('/','').gsub('.rb','') == dataflow_file_name.tr('/','').gsub('dataflow','').gsub('.log','')
			match_list.push(k)
		end
	end
	if match_list.length == 1
		return match_list[0]
	elsif match_list.length > 1
		match_list.each do |m|
			if $class_map[m].getMethod(funcname)
				return m
			end
		end
	end
	return match_list[0]
end

def is_sub_or_upper_class(base, upper)
	if base==upper
		return true
	end
	temp_class_name = base
	while $class_map[temp_class_name] != nil
		if $class_map[temp_class_name].getUpperClass == upper
			return true
		end
		temp_class_name = $class_map[temp_class_name].getUpperClass
	end
	$class_map[base].include_module.each do |inc|
		if inc == upper
			return true
		end
	end	
	return false
end

def remove_module_info(name)
	i = name.rindex(':')
	n = name[i+1..name.length-1]
	return n
end

def get_module_node(astnode)
	if astnode.type.to_s == "module"
		return astnode
	end
	astnode.children.each do |child|
		n = get_module_node(child)
		if n != nil
			return n
		end
	end
	return nil
end

def get_class_node(astnode)
	if astnode.type.to_s == "class"
		return astnode
	else
		astnode.children.each do |child|
			n = get_class_node(child)
			if n != nil
				return n
			end
		end
		return nil
	end
end

def get_class_name_from_class_node(node)
	if node.children[0].type.to_s == "const_path_ref" or node.children[0].type.to_s == "const_ref"
		return node.children[0].source.to_s
	else
		return get_left_most_leaf(node).source.to_s
	end
end

def class_includes_functions(astnode)
	if astnode.class.to_s == "YARD::Parser::Ruby::MethodDefinitionNode"
		return true
	elsif astnode.type.to_s == "class" or astnode.type.to_s == "module"
	else
		r = false
		astnode.children.each do |child|
			if class_includes_functions(child)
				r = true
			end
		end
		return r
	end 
end

def recursive_get_class_stack(astnode, class_stack, filename)
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
					recursive_get_class_stack(child, class_stack, filename)
				end
			end
			if (@has_sub and @include_function) or @has_sub == false
				read_each_class(@class_name, astnode, filename)
			else
				#puts "#{@class_name} is not read!!! #{@has_sub} #{@include_function}"
			end
			class_stack.pop
		else
			astnode.each do |child|
				recursive_get_class_stack(child, class_stack, filename)
			end
		end 
	end
end


def search_distinct_func_name(func_name)
	if $ignore_method_list.include?(func_name)
		return nil
	end
	count = 0
	class_name = ""
	$class_map.each do |keyc, valuec|
		if valuec.getMethod(func_name) != nil
			class_name = keyc
			count += 1
		end
	end
	if count == 1
		return class_name
	else
		return nil
	end
end

def call_match_name(caller_name, funcname, f_handler)
  name_cnt = 0
	only_call = nil
	f_handler.getCalls.each do |call|
		if (call.getObjName.include?(caller_name) or caller_name.include?(call.getObjName)) and funcname == call.getFuncName
				return call ;lk
				
		end
		if funcname == call.getFuncName and (call.caller != nil and call.caller.getName == caller_name)
			return call
		end
		if funcname == "super" and call.isSuperFunc
				return call
		end
		if call.getFuncName == funcname
			name_cnt += 1
			only_call = call
		end
	end
	if name_cnt == 1
		return only_call
	end
	#f_handler.getCalls.each do |call|
	#	puts "\t - #{call.getObjName} . #{call.getFuncName} . #{call.caller == nil}"
	#end
	return nil
end

#TODO: Duplicate logic with getControllerNameCap and getHelperNameCap
def getModelNameCap(name)
	model_name = ""
	@t = name.split("_")
	if @t.length > 1
		model_name = ""
		@t.each do |c1|
			c1[0] = c1[0].upcase
			model_name += c1
		end
	else
		name = name.capitalize
	end
	return name
end

def getControllerNameCap(name)
	c = name.split("::")
	controller_name = ""
	if c.length == 2
		controller_name="#{c[0].capitalize}::#{c[1].capitalize}"
	else
		c1 = name.split('/')
		if c1.length > 1
			controller_name="#{c1[0].capitalize}::#{c1[1].capitalize}"
		else
			controller_name = name
			controller_name[0] = controller_name[0].upcase
		end
	end
	@t = controller_name.split("_")
	if @t.length > 1
		controller_name = ""
		@t.each do |c1|
			c1[0] = c1[0].upcase
			controller_name += c1
		end
	end
	controller_name += "Controller"
	return controller_name
end

def getHelperNameCap(name)
	helper_name = ""
	@t = helper_name.split("_")
	if @t.length > 1
		helper_name = ""
		@t.each do |c1|
			c1[0] = c1[0].upcase
			helper_name += c1
		end
	end
	helper_name += "Helper"
	return helper_name
end



def sourceIgnore(n1)
	instr = n1.getInstr
	if instr.instance_of?HashField_instr or instr.instance_of?Return_instr
		return true
	end
	func_ignore_list = ["before_filter","before_save","before_create","ruby_code_from_view", "transaction", "before_filter_do_block","before_validation_do_block"]
	if instr.instance_of?Call_instr and func_ignore_list.include?instr.getFuncname
		return true
	end
	if func_ignore_list.include?instr.getMethodName
		return true
	end
	if instr.getIndex == 0 and instr.getBB.getIndex == 2
		return true
	end
	return false
end

def sinkIgnore(n1)
	instr = n1.getInstr
	if instr.instance_of?AttrAssign_instr #TODO: Some of the attrassign_instr is not handled, attr_assign instr in validation should go to save
		return true
	end
	if isUtilSink(n1)
		return true
	end
	if instr.getBB.getIndex == 2 and instr.getIndex == 0 #This is mostly passed as "self" to the first instr in funccall
		return true
	end
	if instr.is_a?Call_instr and [">>","<<"].include?instr.getFuncname #TODO: I think this should be a bug a jruby? << and >> are actually array shift and saved into the original array...
		return true
	end
	return false
end

def isValidationSink(n1)
	if isValidationFunc(n1.getInstr.getMethodName)
		return true
	end 
	return false
end

def isCacheSink(n1)
	if n1.getInstr.instance_of?AttrAssign_instr and n1.getInstr.getFuncname == "[]" and n1.getInstr.getCallerType == "CACHE"
		return true
	end
	return false
end

def isUtilSink(n1)
	#Like Rails.logger
	if n1.getInstr.instance_of?Copy_instr
		return true
	elsif n1.getInstr.is_a?Call_instr and ["info","raise","super"].include?n1.getInstr.getFuncname
		return true
	end
	return false
end

def isSelectCondition(n1)
	if n1.getDataflowEdges.length == 1
		if n1.getDataflowEdges[0].getToNode.getInstr.instance_of?HashField_instr
			return true
		end
	end
	return false
end

def isConstSource(n1)
	if n1.getInstr.instance_of?ReceiveConstArg_instr or n1.getInstr.instance_of?Constant_instr
		return true
	elsif n1.getInstr.instance_of?AttrAssign_instr
		if isActiveRecord(n1.getInstr.getCallerType)
			return true
		else
			return false
		end
	elsif n1.getInstr.instance_of?Copy_instr and n1.getInstr.isFromConst
		return true
	else
		return false
	end
end

def analyzeConstSource(n1, const_stat)
	if n1.getInstr.instance_of?ReceiveConstArg_instr
		const_stat.add_receive_arg
	elsif n1.getInstr.instance_of?Copy_instr and n1.getInstr.isFromConst
		const_stat.add_copy_const(n1.getInstr.type)
	elsif n1.getInstr.instance_of?AttrAssign_instr
		const_stat.add_attr_assign
	end
end

def isUtilSource(n1)
	if n1.getInstr.is_a?Const_instr and $class_map[n1.getInstr.getConst] == nil
		return true
	else
		return false
	end
end

def isValidationFunc(name)
	return ["before_validation","before_filter","before_save","before_create","before_action","before_validation_do_block","before_filter_do_block","before_create_do_block","before_action_do_block","before_save_do_block"].include?name
end

#Graphviz doesn't recognize special characters
def simplify(name)
	n = name.delete('!').delete('?')
	return n
end

def simplify1(name)
	return name.tr(".","_")
end

def remove_special_chars(n)
	return n.delete("\n").delete('<').tr('>','I').delete('&').delete(':').tr('.','_').delete(' ')
end

def graph_write(file, word)
	file.write(word.gsub("::","").tr(':',' ').tr('.',' ').tr('%','_'))
end

def OUTPUT_Direct(w)
	#puts w
	$trace_output_file.write("#{w}\n")
end

def defself_not_receivearg(instr)
	if instr.getIndex == 0 and (instr.getBB.getIndex == 2 or instr.getBB.getIndex == 1)
		return false
	end
	return true
end
def function_defself(m_handler)
	if m_handler.getCFG
		m_handler.getCFG.getBB.each do |bb|
			bb.getInstr.each do |instr|
				if instr.getDefv and instr.getDefv.include?("self") and defself_not_receivearg(instr)
					return true
				end
				if instr.instance_of?AttrAssign_instr #and instr.getCallerType == m_handler.getCallerClass.getName
					return true
				end 
			end
		end
	end
	return false
end

def clear_cfg(cfg)
 	cfg.clear
	cfg.getBB.each do |bb|
		bb.getInstr.each do |instr|
			if instr.hasClosure?
				instr.getClosure.clear
			end
		end
	end
end

def clear_data_structure
	$node_list.each do |n|
		if n.getInstr!= nil and n.getInstr.getBB.getExplicitReturn.length > 0
			n.getInstr.getBB.explicit_return = Array.new
			n.getInstr.getBB.return_list = Array.new
			n.getInstr.getBB.getCFG.explicit_return = Array.new
			n.getInstr.getBB.getCFG.return_list = Array.new
		end
		if n.getInstr != nil
			n.getInstr.inode = nil
			n.getInstr.inodes = Array.new
		end
	end
	$class_map.each do |keyc, valuec|
		valuec.member_defs = Hash.new
		valuec.member_gets = Hash.new
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg != nil
				clear_cfg(cfg)
			end
		end
	end

	$node_list = Array.new
	$root = nil
	$view_ruby_code = false
	$view_closure = false

	$cur_bb_stack = Array.new
	$cur_cfg_stack = Array.new

	$non_repeat_list = Array.new
	$cur_cfg = nil
	$cfg_map = Hash.new
	$cur_bb = nil
	$l_index = 0
	$blank = ""
	$in_view = false
	
	$closure_stack = Array.new
	$show_stack = Array.new
	$in_loop = Array.new
	$in_validation = Array.new
	$general_call_stack = Array.new
	$funccall_stack = Array.new
	$call_stack_trace = Array.new
	$root = nil
	$cfg = nil
	$ins_cnt = 0
	#store all instruction node
	$node_list = Array.new
	$sketch_node_list = Array.new
	$query_word_count = Hash.new
	$query_func_count = Hash.new
	#the very source of dataflow, all nodes using user input connect to this node
	$dataflow_source = INode.new(nil)

	$table_select_fields = Hash.new
	$order_fields = Hash.new
	$query_chain = Hash.new
	
	#format: from_inode_index*to_inode_index
	$dataflow_edges = Hash.new
	$cur_funccall = nil
	$cur_position = ""
	$path_tracker = Array.new
	$processed_node_stack = Array.new

	$cur_node = nil
	$root = nil
	$global_check = Hash.new
	$node_list = Array.new
	$cur_query_stack = Array.new
	$query_edges = Array.new

end

def getRealLine(filename, l)
	line_file = filename + ".line"
	result = [filename, l, 0]
	if(File.exist?line_file)
		f = open(line_file, 'r')
		c = f.read
		#puts "#{c}"
		c = eval(c)
		result = c[l]
		f.close
	end
	puts "results: #{result}"
	if result and result[0].include?"/ruby_views/"
		viewf = result[0].gsub("/ruby_views/", "/views/")
		viewl = result[0] + ".line"
		if(File.exist?viewl)
			f = open(viewl, 'r')
			cs = f.readlines()
			c = cs[result[1] - 1]
			if c
				s = c.split(' ')
				result[1] = s[0].to_i
				result[2] = s[1].to_i
			end
		end
		result[0] = viewf
	end

	if result
		# get the app name
		app = $app_dir.split("/")[-1]
		# split the path to by app
		result[0] = result[0].split(app)[1]
		if result[0]
			puts  result[0]
			if result[0][0..1] == "//"
				result[0] = result[0][2..-1]
			end
			if result[0][0] == "/"
				result[0] = result[0][1..-1]
			end
		end
	end

	return result
	
end

def getInstrLN(instr)
	class_name = instr.getBB.getCFG.getMHandler.getCallerClass.getName
	filename = $class_map[class_name].filename
	ln = instr.getLN
	if filename && ln
		#puts "F: #{filename} LOC: #{ln}"
		return getRealLine(filename, ln) 
	end
	return [-1,-1,-1]
end
