require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/string'

class Variable
	def initialize(v_name, type)
		@name = v_name
		@type = type
	end
	attr_accessor :name, :type
end

class Temp_variable < Variable
	def initialize(v_name, type)
		super(v_name, type)
	end
end

class Field_variable < Variable
	def initialize(v_name, type)
		super(v_name, type)
	end
end

class Local_variable < Variable
	def initialize(v_name, type)
		super(v_name, type)
	end
end


def add_to_var_table(f_name, c_name, v_name, type)
	if $class_map[c_name].getMethod(f_name).getVars[v_name]
		_type_name = $class_map[c_name].getMethod(f_name).getVars[v_name]
		if _type_name == type
		else
			#puts "TYPE doesn't match! #{v_name}: [#{_type_name}] [#{type}]"
		end
	else
		$class_map[c_name].getMethod(f_name).getVars[v_name] = type
	end
end

def add_to_cfg_varmap(cfg, c_name, v_name, type)
	if type == "StringLiteral"
		type = "string"
	elsif type == "Boolean"
		type = "boolean"
	elsif type == "Fixnum"
		type = "integer"
	end
	var = nil
	if v_name.include?("self")
		var = Local_variable.new(v_name, c_name)
	elsif v_name.include?("%")
		var = Temp_variable.new(v_name, type)
	else
		var = Local_variable.new(v_name, type)
	end
	if var != nil
		cfg.addToVarMap(v_name, var)
	end
end

$unknown_types = Hash.new

#takes two params: node, and var_name
def type_valid(instr, v_name)
	c_name = instr.getBB.getCFG.getMHandler.getCallerClass.getName
	if v_name.include?("self")
		return c_name
	end
	t = known_type(v_name, instr.getBB.getCFG, c_name)
	if t and t.type == "self_model_name"
		#use dynamic typing
		if instr.getINode
			model_name = instr.getINode.cur_class.gsub("Controller","").downcase.singularize.capitalize
			puts "Model name = #{model_name}"
			return model_name
		end
	end
	if type_not_found(t)
		return nil
	else
		return t.type
	end 
end

def known_type(v_name, cfg, c_name)
	#first look for the cfg var_map
	var = cfg.getVarMap[v_name]
	if var == nil
		#then look for class field
		if $class_map[c_name] != nil
			var = $class_map[c_name].getVarMap[v_name]
		end
	end
	if var == nil and cfg.instance_of?Closure
		#Find upper level
		#TODO: should find recursively
		var = known_type(v_name, cfg.parent_instr.getBB.getCFG, c_name)
	end
	if var == nil or type_not_found(var) 
		vt = transform_var_name(v_name) 
		if vt != nil
			var = Local_variable.new(v_name, vt)
			cfg.getVarMap[v_name] = var
		end
	end
	return var
end

def find_var_type(v_name, f_name, c_name)
	if $class_map[c_name].getMethod(f_name) != nil
		meth = $class_map[c_name].getMethod(f_name)
		if meth.getCFG != nil
			var = known_type(v_name, meth.getCFG, c_name)
			if type_not_found(var)==false
				return var
			else
				meth.getCFG.getBB.each do |bb|
					bb.getInstr.each do |instr|
						if instr.hasClosure?
							var = known_type(v_name, instr.getClosure, c_name)
							if type_not_found(var)==false
								return var
							end
						end
					end
				end
			end
		end
	end
	return nil
end

def type_not_found(var)
	if var == nil
		return true
	elsif var.type == nil
		return true
	elsif var.type == "unknown" or var.type == "Nil"
		return true
	end
	return false
end

#key:function name
#value:return value type
def read_util_function
	f_name = "./util_func_list.txt"
	File.open(f_name, "r").each do |line|
		line = line.gsub("\n","")
		chs = line.split(' ')
		$util_function_list[chs[0]] = chs[1]
	end
	f_name = "#{$app_dir}/util_func_list.txt"
	if File.exist?(f_name)
		File.open(f_name, "r").each do |line|
			line = line.gsub("\n","")
			chs = line.split(' ')
			if chs[1]
				$util_function_list[chs[0]] = chs[1]
			else
				$util_function_list[chs[0]] = nil
			end
		end
	end
end
def read_repeatable_function
	f_name = "#{$app_dir}/non_repeatable_func_list.txt"
	if File.exist?(f_name)
		File.open(f_name, "r").each do |line|
			line = line.gsub("\n","")
			$non_repeatable_list.push(line)
		end
	end
end
def util_function(fname, instr, cfg, c_name)
	t = $util_function_list[fname]
  if t == nil
		return nil
	end
	if t == "PASS"
		type = nil
		if instr.is_a?Call_instr
			#return caller type
			if type_not_found(known_type(instr.getCaller, cfg, c_name))
			else
				type = known_type(instr.getCaller, cfg, c_name)
				if type_not_found(type)
				else
					return type.type
				end
			end
		end
		instr.getDeps.each do |d|
			if type_not_found(known_type(d.getVname, cfg, c_name))
			else
				type = known_type(d.getVname, cfg, c_name)
			end
		end
		if type != nil
			return type.type
		else
			return nil
		end
	elsif t == "SELF"
		return c_name
	elsif t == "SELF_MODEL_CLASS"
		return "self_model_name"
	else
		return t
	end
end

def solve_can_problem(cfg)
	cfg.getBB.each do |bb|
		bb.getInstr.each do |instr|
			if instr.instance_of?Call_instr and instr.getFuncname.start_with?("can?_")
				tp = type_valid(instr, instr.args[1])
				if tp
					instr.setFuncname("#{instr.getFuncname.gsub('?','')}_#{tp}")
					puts "Set #{instr.getClassName}.#{instr.getMethodName} funcname to be #{instr.getFuncname}"
				end 
			end
		end
	end
end

def do_type_inference
	read_util_function
	read_repeatable_function

	#Fill in the empty CFG
	#Do it here so that we can still look at the type inference
	$class_map.each do |keyc, valuec|
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			#Before filter should not be included here, since some has "on" property, so not all the functions defined in before filter will be executed all the time
			if cfg == nil and key != "before_filter"
				#puts "No CFG found! #{keyc}.#{key}"
				cfg = CFG.new
				value.setCFG(cfg)
				value.normal_function = false #for those func that manually added CFG: like scope, do_validation_block
				bb = Basic_block.new(1)
				def_self = Instruction.new
				def_self.setDefv("%self")
				bb.addInstr(def_self)
				value.getCalls.each do |c|
					call_instr = Call_instr.new(c.getObjName, c.getFuncName)
					call_instr.setCallHandler(c)
					call_instr.addDatadep("1.0", "%self", def_self)
					bb.addInstr(call_instr)
				end
				cfg.addBB(bb)
			end
		end
	end
	
	$class_map.each do |keyc, valuec|
		@class_var_list = Hash.new
		valuec.getTableFields.each do |f|
			@class_var_list[f.field_name] = f.type	
		end
		#puts "Class: #{keyc}"
		valuec.getAssocs.each do |_name, ary|
			ary.each do |a|
				if a.attribs["class_name"] != nil
					@class_var_list[a.name] = a.attribs["class_name"]
				elsif $class_map[a.name.singularize.capitalize] != nil
					@class_var_list[a.name] = a.name.singularize.capitalize
				end
				#puts "ADD assocs: #{a.name}, #{@class_var_list[a.name]}"
			end
		end
		@class_var_list.each do |k, v|
			var = Field_variable.new(k, v)
			valuec.addToVarMap(k, var)
		end	
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg != nil
				set_initial_type(cfg, key, keyc)
				#puts "First type info: #{keyc} . #{key}"
				do_type_inference_cfg(cfg, key, keyc)
			end
		end
	end
=begin
	$class_map.each do |keyc, valuec|
		puts ""
		puts "==="
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg != nil 
				puts "FUNCION: #{keyc} . #{key}"
				if type_not_found(cfg.return_type) == false
					puts "\t * return: #{cfg.return_type.type}"
				end
				if cfg.arg_types.length > 0
					s = ""
					cfg.arg_types.each do |a|
						if a == nil
							s = s + "unknown_type "
						else
							s = s + "#{a.type} "
						end
					end
					puts "\t * args: #{s}"
				end
			end
		end
	end
=end
	$class_map.each do |keyc, valuec|
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg != nil
			#if cfg != nil and keyc=="UsersController"
			#	puts "Function: #{key}"
			#	do_type_inference_cfg(cfg, key, keyc, true)
			#elsif cfg!= nil
				#puts "\tSecond type info: #{keyc} . #{key}"
				do_type_inference_cfg(cfg, key, keyc)
			end
		end
	end

	#TODO: Here are some filter code handling specific rails functions
	$class_map.each do |keyc, valuec|
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg != nil
				solve_can_problem(cfg)
				cfg.getBB.each do |bb|
					bb.getInstr.each do |instr|
						if instr.hasClosure?
							solve_can_problem(instr.getClosure)
						end
					end
				end
			end
		end
	end


=begin
	$class_map.each do |keyc, valuec|
		valuec.getMethods.each do |key, value|
			if value.getCFG != nil
			#if keyc.include?("Controller")==false and value.getCFG != nil
				puts "Class #{keyc} Function #{key}:"
				print_unknown_types(value.getCFG, "", keyc)
			end
		end
	end
	controller_not_found = 0
	controller_found = 0
	model_not_found = 0
	model_found = 0
	$class_map.each do |keyc, valuec|
		valuec.getMethods.each do |key, value|
			cfg = value.getCFG
			if cfg!= nil
				cfg.getVarMap.each do |k, v|
					if type_not_found(v) and k != "%v_0" and k != "%current_module" and k != "%current_scope"
						if keyc.include?("Controller")
							controller_not_found += 1
						else
							model_not_found += 1
						end
					else
						if keyc.include?("Controller")
							controller_found += 1
						else
							model_found += 1
						end
					end
				end	
			end
		end
	end
	puts "\n***************\n"

	puts "Controller:"
	puts "\tTYPE FOUND: #{controller_found}"
	puts "\tTYPE NOT FOUND: #{controller_not_found}"
	puts "Others:"
	puts "\tTYPE FOUND: #{model_found}"
	puts "\tTYPE NOT FOUND: #{model_not_found}"
	puts "\n***************\n"
=end
end

def set_initial_type(cfg, f_name, c_name)
	add_to_cfg_varmap(cfg, c_name, "%self", nil)
	add_to_cfg_varmap(cfg, c_name, "self", nil)
	if c_name.include?"Controller"
		add_to_cfg_varmap(cfg, c_name, "self_model_class", nil)
	end
	cfg.getBB.each do |bb|
		#puts "\tBB#{bb.getIndex}:"
		bb.getInstr.each do |instr|
			if instr.getDefv != nil
				if cfg.getVarMap[instr.getDefv] == nil
					tname = searchTableName(instr.getDefv)
					var = nil
					if tname
						var = Variable.new(instr.getDefv, tname)
					else
						var = Variable.new(instr.getDefv, "unknown")
					end	
					cfg.getVarMap[instr.getDefv] = var
				end
				if instr.hasClosure?
					set_initial_type(instr.getClosure, f_name, c_name)
				end
			end
		end
	end
end

def print_unknown_types(cfg, blank, c_name)
		cfg.getBB.each do |bb|
			#puts "\tBB#{bb.getIndex}:"
			bb.getInstr.each do |instr|
				if instr.getDefv != nil
					tp = known_type(instr.getDefv, cfg, c_name);
					k = instr.getDefv
					if type_not_found(tp) 
						if k != "%v_0" and k != "%current_module" and k != "%current_scope"
							puts "#{blank}\t* #{instr.getDefv} : #{instr.toString2}"
						end
					else
						puts "#{blank}\t#{instr.getDefv} -> #{tp.type}"
					end
				end 
				if instr.hasClosure?
					puts "CLOSURE BEGIN"
					temp_blank = "\t#{blank}"
					print_unknown_types(instr.getClosure, temp_blank, c_name)
					puts "CLOSURE END"
				end
			end
		end
end


#f_name: function_name
#c_name: class_name
$last_closure_arg = nil
def do_type_inference_cfg(cfg, f_name, c_name, print=false)
	cfg.getBB.each do |bb|
		if print
			puts "\tBB#{bb.getIndex}:"
		end
		bb.getInstr.each do |instr|
			if print
				puts "\t\tInstr: #{instr.getIndex}: #{instr.toString}"
			end
			if instr.hasClosure?
				if print
					puts "CLOSURE BEGIN:"
				end
				$last_closure_arg = known_type(instr.getDeps[0].getVname, cfg, c_name)
				do_type_inference_cfg(instr.getClosure, f_name, c_name, print)
				#if type_not_found(instr.getClosure.return_type)==false and type_not_found(cfg.return_type)
				#	cfg.return_type = instr.getClosure.return_type
				#end
				$last_closure_arg = nil
				if print
					puts "CLOSURE END"
				end
			end
			if instr.getDefv != nil and type_not_found(known_type(instr.getDefv, cfg, c_name))
				#if instr.getResolvedCaller != ""
				#	add_to_cfg_varmap(cfg, c_name, instr.getCaller, instr.getResolvedCaller)
				#end
				if instr.is_a?Const_instr
					add_to_cfg_varmap(cfg, c_name, instr.getDefv, instr.getConst)
				elsif instr.instance_of?BuildString_instr
					add_to_cfg_varmap(cfg, c_name, instr.getDefv, "string")
				elsif instr.instance_of?Copy_instr #or instr.instance_of?HashField_instr
					if instr.getDeps.length > 0 and instr.type == "PASS"
						var = known_type(instr.getDeps[0].getVname, cfg, c_name)
						#COPY des source
						#type of source known
						if type_not_found(var)==false
							add_to_cfg_varmap(cfg, c_name, instr.getDefv, var.type)
						end
					elsif instr.type != nil
						add_to_cfg_varmap(cfg, c_name, instr.getDefv, instr.type)
					end
				elsif instr.instance_of?ReceiveArg_instr
					if $last_closure_arg == nil
						#function receive_arg
						if cfg.arg_types.length > 0
							arg_index = 0
							instr.getBB.getInstr.each do |inner_i|
								if inner_i == instr
									break
								elsif inner_i.instance_of?ReceiveArg_instr
									arg_index += 1
								end
							end
							arg_type = cfg.arg_types[arg_index]
							if type_not_found(arg_type) == false
								add_to_cfg_varmap(cfg, c_name, instr.getDefv, arg_type.type)
							end
						end	
					else
						if type_not_found($last_closure_arg)==false
							add_to_cfg_varmap(cfg, c_name, instr.getDefv, $last_closure_arg.type)
						end
					end
				#elsif instr.instance_of?GetField_instr
				#	#GETFIELD def_v field_name
				#	#If field type is known, pass the type to v
				#	if cfg.getVarMap[instr.getFuncname] != nil
				#		add_to_cfg_varmap(cfg, c_name, instr.getDefv, cfg.getVarMap[instr.getFuncname])
				#	else
				#		#puts "Field not found: #{instr.getFuncname}"
				#	end
				elsif instr.is_a?Call_instr
					caller_type = known_type(instr.getCaller, cfg, c_name)
					if type_not_found(caller_type)
						caller_type = Local_variable.new(instr.getCaller, searchModelName(instr.getCaller))
						if type_not_found(caller_type)
						else
							puts "Find caller_type = #{instr.getCaller}, #{caller_type.type}, in func #{c_name}.#{f_name}"
							add_to_cfg_varmap(cfg, c_name, instr.getCaller, caller_type.type)
						end
					end	
					if type=util_function(instr.getFuncname, instr, cfg, c_name)
						add_to_cfg_varmap(cfg, c_name, instr.getDefv, type)
					elsif type_not_found(caller_type)
						#TODO: heuristic... 
						if tname = searchModelName(instr.getFuncname)
							if instr.getDefv
								add_to_cfg_varmap(cfg, c_name, instr.getDefv, tname)
							end 
						end
					else
						if instr.getResolvedCaller.length == 0
							instr.setResolvedCaller(caller_type.type)
						end
						#is field?
						is_field = known_type(instr.getFuncname.gsub('!','').gsub('?',''), cfg, caller_type.type)
						@solved = false
						if type_not_found(is_field) == false
							#TODO: Don't know if it is true...sometimes use boolean just as selection
							if is_field.type == "boolean"
								add_to_cfg_varmap(cfg, c_name, instr.getDefv, c_name)
							else
								add_to_cfg_varmap(cfg, c_name, instr.getDefv, is_field.type)
							end
							@solved = true
						else
							#TODO: This may be a bad heuristic: if field matches a table name...
							#In community engine, tag.taggings, but taggings is not defined as a field in Tag model??!!
							tname = searchTableName(instr.getFuncname)
							if tname != nil and (isActiveRecord(c_name) or c_name.include?("Controller"))
								add_to_cfg_varmap(cfg, c_name, instr.getDefv, tname)
								@solved = true
							elsif $class_map[caller_type.type]
								attrib_class = $class_map[caller_type.type].searchAssocForClass(instr.getFuncname)
								if attrib_class
									add_to_cfg_varmap(cfg, c_name, instr.getDefv, attrib_class)
									@solved = true
								end
							end
						end
						#puts "Caller type found: #{caller_type.type}"
						if @solved == false and instr.isReadQuery or ["new"].include?instr.getFuncname
							add_to_cfg_varmap(cfg, c_name, instr.getDefv, caller_type.type)	
						elsif @solved == false and instr.isQuery #for write query, return boolean
							add_to_cfg_varmap(cfg, c_name, instr.getDefv, "boolean") 
						elsif @solved == false
							#normal call instr
							#caller?
							if ($class_map[caller_type.type]!= nil)# instr.getCallHandler != nil and (instr.getCallHandler.caller != nil)
								meth = $class_map[caller_type.type].findMethodRecursive(instr.getFuncname)
								#meth = instr.getCallHandler.caller.getMethod(instr.getFuncname)
								if meth != nil and meth.getCFG != nil
									#Fill in arg types
									if meth.getCFG.arg_types.length == 0
										instr.getArgs.each do |a|
											var = Variable.new(instr.getDefv, "unknown")	
											meth.getCFG.arg_types.push(var)
										end
									end
									temp_index = 0
									instr.getArgs.each do |a|
										if type_not_found(meth.getCFG.arg_types[temp_index])
											#Guess arg type by checking the type of the variable passed to that func call
											if type_not_found(known_type(a, cfg, c_name)) and !(a.include?('%'))
												var = Variable.new("const", a.downcase)
												meth.getCFG.arg_types[temp_index] = var
											else
												meth.getCFG.arg_types[temp_index] = known_type(a, cfg, c_name)
											end
										end
										temp_index += 1
									end
								end
								if meth != nil and meth.getCFG != nil and meth.getCFG.return_type != nil
									add_to_cfg_varmap(cfg, c_name, instr.getDefv, meth.getCFG.return_type.type)
								end
							end
						end
					end
					if instr.getFuncname.include?('?')
						add_to_cfg_varmap(cfg, c_name, instr.getDefv, "boolean")
					end
				#This might not be correct: one arg one def, assume to be the same type
				elsif instr.getDeps.length == 1
					p_type = known_type(instr.getDeps[0].getVname, cfg, c_name)
					if type_not_found(p_type) == false
						add_to_cfg_varmap(cfg, c_name, instr.getDefv, p_type.type)
					end
				end
			elsif instr.instance_of?Return_instr
	
				if instr.getDeps.length > 1 and type_not_found(cfg.return_type)
					r_type = nil
					instr.getDeps.each do |d|
						if d.getVname.include?("self")
						else
							r_type = known_type(d.getVname, cfg, c_name)
						end 
					end
					if type_not_found(r_type)==false
						cfg.setReturnType(r_type)
					end
				else
					#var = Variable.new("returnv", "NIL")	
					#cfg.return_type = var
				end
			elsif instr.instance_of?AttrAssign_instr
				caller_type = known_type(instr.getCaller, cfg, c_name)
				if type_not_found(caller_type)
				elsif instr.getDeps.length > 0
					var_type = known_type(instr.getDeps[0].getVname, cfg, c_name)
					if type_not_found(var_type)==false
						#This should be added to the field of the corresponding table...
						if $class_map[caller_type.type] != nil
							#Field_variable.new(field_name, field_type)
							var = Field_variable.new(instr.getFuncname, var_type.type)
							$class_map[caller_type.type].addToVarMap(instr.getFuncname, var)
						end
					end	
				end
			end
			if print
				if type_not_found(known_type(instr.getDefv, cfg, c_name))==false
					puts "\t\t\t # # type: #{instr.getDefv} = #{known_type(instr.getDefv, cfg, c_name).type}"
				elsif instr.getDefv != nil
					puts "\t\t >.< def #{instr.getDefv} not nil"
				end
			end
		end
	end
end
