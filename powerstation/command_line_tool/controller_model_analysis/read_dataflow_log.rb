def find_first_nonempty_ele(attrs)
	index = 0
	attrs.each do |attr|
		if attr.length > 0
			return index
		end
		index += 1
	end
	return -1	
end

def read_dataflow(application_dir=nil)

	if application_dir != nil
		$app_dir = application_dir
	end

	$dataflow_dir = "#{$app_dir}/dataflow/"
	
	root, files, dirs = os_walk($dataflow_dir)
	for filename in files
		if filename.to_s.end_with?(".log") and filename.to_s.include?("schema.log") == false

			class_name = dataflow_filename_match(filename.to_s)
			if $const and !$const.include?class_name
				#puts "#{class_name} is not used"
				next
			end
			puts "Dataflow file: #{filename} matches class name #{class_name}" 
			if class_name != nil
				if filename.to_s.include?("controllers")
					$class_map[class_name].class_type = "controller"
				elsif filename.to_s.include?("models")
					$class_map[class_name].class_type = "model"
				end
				handle_single_dataflow_file(filename.to_s, class_name)
				$class_map[class_name].getMethods.each do |key, meth|
					if meth.getCFG != nil
						meth.getCFG.findCalls
					end
				end
			else
				#puts "Dataflow file #{filename} cannot find a class!"
			end
		end
	end
	
	#Dir.glob($dataflow_files) do |item|
	#	next if item == '.' or item == '..'
	#	class_name = get_mvc_name2(item)
	#	handle_single_dataflow_file(item, class_name)
	#	$class_map[class_name].getMethods.each do |key, meth|
	#		if meth.getCFG != nil
	#			meth.getCFG.findCalls
	#		end
	#	end
	#end

	#$dataflow_files = "#{$app_dir}/dataflow/models/*.log"

	#Dir.glob($dataflow_files) do |item|
	#	next if item == '.' or item == '..'
	#	class_name = get_mvc_name2(item)
	#	handle_single_dataflow_file(item, class_name)
	#	$class_map[class_name].getMethods.each do |key, meth|
	#		if meth.getCFG != nil
	#			meth.getCFG.findCalls
	#		end	
	#	end
	#end
end

def find_method(dataflow_file_name, method_name)
	class_name = dataflow_filename_match_function(dataflow_file_name, method_name)
	return $class_map[class_name].getMethod(method_name)
end


def handle_single_dataflow_file(item, class_name)
		file = File.open(item, "r")
		line_number = 1
		file.each_line do |line|
			if line.include?("SET IRMethod")
				line_number += 1
				$view_start = false
				#i = line.index(" = ")
				#func_name = line[i+3...line.length-1]
				chs = line.split(" ")
				func_name = chs[4]
				
				$cur_cfg = CFG.new
				if chs[-1] == "true"
					$cur_cfg.setInstanceMethod(true)
				else
					$cur_cfg.setInstanceMethod(false)
				end
				#$cfg_map[func_name] = $cur_cfg
				m = find_method(item, func_name)
				print ''
				if $mcs and !$mcs.include?m
					next
				end
				if m == nil
					puts "METHOD NOT FOUND: #{item}, #{func_name}"
					next
				else
					m.setCFG($cur_cfg)
				end

			elsif line.include?("JRUBY")
				nil
			elsif line.include?("CLOSURE BEGIN:")
				$cur_bb_stack.push($cur_bb)
				$cur_cfg_stack.push($cur_cfg)
				temp_cfg = $cur_cfg
				$cur_cfg = Closure.new
				if $view_ruby_code or (temp_cfg.instance_of?Closure and temp_cfg.getViewCode)
					if $view_closure
					  $cur_cfg.setViewClosure
					  $view_closure = false
					end
				end
	
				#Variable def table
				#Handled separately because the def stmt are not in the same closure
				attrs = line.split(" ")
				index = 0	
				attrs.each do |single_attr|
					if index > 1 #Avoid handling 'CLOSURE' 'BEGIN:' 
						bracket_begin = single_attr.index('[')
						bracket_end = single_attr.index(']')
						dep_string = single_attr[bracket_begin+1...bracket_end-1]
						deps = dep_string.split(',')
						v_name = single_attr[0...bracket_begin]
						if deps.length > 0
							deps.each do |dep|
								if dep.length > 0
									#find instr handler here
									dep_str = dep.split('.')
									if temp_cfg.getBBByIndex(dep_str[0].to_i) == nil
									else
										dep_instr = temp_cfg.getBBByIndex(dep_str[0].to_i).getInstr[dep_str[1].to_i]
										$cur_cfg.addToVarDefTable(v_name, dep, dep_instr)
									end
								else 
								end
							end
						else #dep.length == 0, empty dep, find upper closure
							$cur_cfg.loop_vars.push(v_name)
							upper_cfg_index = -1
							while $cur_cfg_stack[upper_cfg_index] and $cur_cfg_stack[upper_cfg_index].instance_of?Closure
								$cur_cfg_stack[upper_cfg_index].getVarDefs(v_name).each do |c1|
									if c1.getVname == v_name
										$cur_cfg.addToVarDefTable(v_name, "#{c1.getBlock}.#{c1.getInstr}", c1.getInstrHandler)
									end
								end
								upper_cfg_index -= 1
							end
						end
					end
					index = index + 1
				end
			elsif line.include?("CLOSURE END")
				#$cur_cfg.getLastBB.addOutgoings($cur_cfg.getFirstBB.getIndex)
				$cur_bb = $cur_bb_stack[-1]
				$cur_bb.getLastInstr.addClosure($cur_cfg)
				if $cur_cfg.getViewClosure
				  $view_ruby_code = false
				end
				attrs = line.split(" ")
				index = 0	
				attrs.each do |single_attr|
					if index > 1 #Avoid handling 'CLOSURE' 'BEGIN:' 
						bracket_begin = single_attr.index('[')
						bracket_end = single_attr.index(']')
						dep_string = single_attr[bracket_begin+1...bracket_end-1]
						deps = dep_string.split(',')
						v_name = single_attr[0...bracket_begin]
						deps.each do |dep|
							if dep.length > 0
								#find instr handler here
								dep_str = dep.split('.')
								if $cur_cfg.getBBByIndex(dep_str[0].to_i)
									dep_instr = $cur_cfg.getBBByIndex(dep_str[0].to_i).getInstr[dep_str[1].to_i]
									#puts "READ DATAFLOW: add to var table: #{v_name} (#{dep_instr.toString})"
									if dep_instr 
										$cur_cfg.addToClosureDefTable(v_name, dep, dep_instr)
									end
								end
							end
						end
					end
					index = index + 1
				end

				$cur_cfg = $cur_cfg_stack[-1]
				$cur_bb_stack.pop
				$cur_cfg_stack.pop
			elsif line.include?("BB ")
				$cur_bb = Basic_block.new(line.split(' ')[1].to_s) 
				$cur_cfg.addBB($cur_bb)
			else
				#attrs = line.split(" ")
				if line.include?("Line Number")
					line_number = (line.split(" ")[3]).to_i
					#puts "#{line_number}"
				end
				attrs = Array.new 
				if line.include?('"') #deal with const
					ind = line.index('"')
					rind = line.rindex('"')
					part1 = line[0..ind-1].split(" ")
					part2 = line[ind..rind]
					part3 = line[rind+1..-1].split(" ")
					attrs += part1
					attrs.push(part2)
					attrs.push(part3)
				else
					attrs = line.split(" ")
				end

				i = find_first_nonempty_ele(attrs)
				if i!= -1
					attr = attrs[i]
					if attr[-1,1] == ':'
						if attr.include?("outgoing")
							index = 0
							attrs.each do |single_attr|
								if index > i
									$cur_bb.addOutgoings(single_attr.to_i)	
								end
								index += 1
							end
						elsif attr.include?("datadep")
							index = 0
							attrs.each do |single_attr|
								if index > i
									$cur_bb.addDatadeps(single_attr.to_i)	
								end
								index += 1
							end
						elsif attr.include?("instructions")
						else
							#instruction number
							index = 0
							cur_instr = Instruction.new
							const_string =  nil
							attrs.each do |single_attr|
								if index > i
									if cur_instr.instance_of?ReceiveArg_instr
										#puts "single_attr is #{single_attr} #{cur_instr.var_name}"
									end
									if single_attr.include?('"')
										const_string = single_attr[1..-2]
										if cur_instr.instance_of?Copy_instr
											cur_instr.const_string = const_string
										end
									elsif single_attr.include?("->")
										fc_array = single_attr.split("->")
										#fc_array[0]: caller
										#fc_array[1]: function_name
										if cur_instr.instance_of?AttrAssign_instr or (fc_array[0] == "%self" and fc_array[1].end_with?'=')
											cur_instr = AttrAssign_instr.new(fc_array[0], fc_array[1])
										elsif cur_instr.instance_of?GetField_instr
											cur_instr = GetField_instr.new(fc_array[0], fc_array[1])
										elsif ["update_column","write_attribute","update_attribute"].include?(fc_array[0])
											cur_instr = AttrAssign_instr.new(fc_array[0], fc_array[1])
										#elsif ["write_attribute"].include?(fc_array[0])
											if $cur_bb.getInstr[-1].instance_of?Copy_instr and $cur_bb.getInstr[-1].type == "StringLiteral"
												cur_instr = AttrAssign_instr.new(fc_array[0], $cur_bb.getInstr[-1].const_string)
											end
										else
											cur_instr = Call_instr.new(fc_array[0], fc_array[1])
										end
										if $view_start
											cur_instr.in_view = true
										end
										#TODO: previous instr may not be dataflow dependent instr...
										if $cur_bb.getInstr.length > 0 and $cur_bb.getInstr[-1].instance_of?HashField_instr and cur_instr.instance_of?Call_instr
											prev_instr = $cur_bb.getInstr[-1]
											prev_instr.hash_fields.each do |h|
												cur_instr.hash_fields.push(h)
											end
										end
										if cur_instr.getCaller.include?("self") and ["params","session","cookies"].include?cur_instr.getFuncname
												cur_instr.setFromUserInput
										end
										if cur_instr.getFuncname == "ruby_code_from_view" 
												$view_ruby_code = true
												$view_closure = true
												$view_start = true
										end
									elsif single_attr.include?("ARGS:")
										args = single_attr[5...-1].split(',')
										args.each do |a|
											cur_instr.args.push(a)
										end	
									elsif single_attr.include?("SYMBOL:")
										args = single_attr[7...-1].split(',')
										args.each do |a|
											cur_instr.addSymbol(a)
										end
										if cur_instr.is_a?Call_instr and ["update_column", "write_attribute","update_attribute"].include?(cur_instr.getFuncname) and cur_instr.symbols[0]
											cur_instr.setFuncname(cur_instr.symbols[0])	
										end
										if cur_instr.is_a?Call_instr and cur_instr.getFuncname == "can?" and $class_map["Ability"] and cur_instr.symbols[0]
											cur_instr.setFuncname("can?_#{cur_instr.symbols[0]}")
											cur_instr.setCaller("Ability")
										end	
									elsif single_attr.include?('[') and single_attr.include?(']')
										bracket_begin = single_attr.index('[')
										bracket_end = single_attr.index(']')
										#no explicit define is found, for named vairables like @message
											if $cur_cfg.instance_of?Closure
												v_name = single_attr[0...bracket_begin]
												#puts "Find use without def: #{v_name} (#{$cur_bb.getIndex}.#{$cur_bb.getInstr.length})"
												$cur_cfg.getVarDefs(v_name).each do |v|
													cur_instr.addDatadep("", v_name, v.getInstrHandler)
													#puts "\t\thandler: #{v.getInstrHandler.toString}"
												end
											end
										
										if bracket_begin == bracket_end - 1 
										else
											dep_string = single_attr[bracket_begin+1...bracket_end-1]
											deps = dep_string.split(',')
											v_name = single_attr[0...bracket_begin]
											# if v_name == "\%self"
											# 	next
											# end
											#puts "v_name #{v_name}"
											# if v_name == "\%self"
											#     cur_instr.addDatadep(deps[-1], v_name)
										   #  else
										   #      cur_instr.addDatadep(deps[0], v_name)
											# end
											deps.each do |dep|
												if dep.length > 0
													#dep_str = dep.split('.')
													#dep_instr = nil
													#if $cur_cfg.getBBByIndex(dep_str[0].to_i) != nil
													#	$cur_cfg.getBBByIndex(dep_str[0].to_i).getInstr[dep_str[1].to_i]
													#else
													#	puts "block #{dep_str[0].to_i}  doesn't exist"
													#end
													#if dep_instr != nil
													#XXX:Here is some non-beautiful trick, attrassign don't use the class instance, it only assigns. So avoid defining the use of class instance
													#if cur_instr.instance_of?AttrAssign_instr
														#if v_name.include?('%')==true	
															cur_instr.addDatadep(dep, v_name)
														#end
													#else
														#cur_instr.addDatadep(dep, v_name)
													#end
													#else
													#	puts "DEP instructions cannot be found: #{dep_str[0].to_i}.#{dep_str[1].to_i}"
													#end
												end
											end
										end
					
									elsif single_attr.index("def_") == 0 
										single_attr.gsub('def_', '')
										cur_instr.setDefv(single_attr.gsub('def_',''))
									elsif single_attr.is_a?Array and single_attr.length == 1 and single_attr[0].index("def_") == 0 
										single_attr[0].gsub('def_', '')
										cur_instr.setDefv(single_attr[0].gsub('def_',''))
									elsif single_attr.index("TYPE_") == 0 and cur_instr.instance_of?Copy_instr
										cur_instr.type = single_attr.gsub('TYPE_','')

									elsif single_attr == "RETURN"
										cur_instr = Return_instr.new

									elsif single_attr == "GLOBALVAR" and attrs[index+1] != "$!"
										cur_instr = GlobalVar_instr.new
										cur_instr.global_var_name = attrs[index+1]
									
									elsif single_attr == "BRANCH"
										cur_instr = Branch_instr.new
				
									elsif single_attr == "BUILDSTRING"
										cur_instr = BuildString_instr.new

									elsif single_attr == "RECEIVEARG"
										cur_instr = ReceiveArg_instr.new

									elsif single_attr == "RECEIVECONSTARG"
										cur_instr = ReceiveConstArg_instr.new

									elsif single_attr == "CONSTANT"
										cur_instr = Constant_instr.new
	
									elsif single_attr == "ATTRASSIGN"
										cur_instr = AttrAssign_instr.new("", "")

									elsif single_attr == "GETFIELD"
										cur_instr = GetField_instr.new("", "")								
	
									elsif single_attr == "COPY"
										cur_instr = Copy_instr.new	

									elsif single_attr.include?("HASH")
										cur_instr = HashField_instr.new
										fields = single_attr.split('-')
										for j in 1...fields.length do
											h_k = fields[j]
											if h_k.length > 0
												cur_instr.addHash(h_k)
											end
										end
	
									elsif single_attr.include?('(') and single_attr.include?(')')
										bracket_begin = single_attr.index('(')
										bracket_end = single_attr.index(')')
										if single_attr.include?("inherit ") and $cur_bb.getInstr[-1].is_a?Const_instr
												upper_name = $cur_bb.getInstr[-1].getConst
												cur_name = single_attr[bracket_begin+1...bracket_end].gsub('inherit ','')	
												cur_instr = InheritConst_instr.new("#{upper_name}::#{cur_name}") 
										else
											cur_instr = Const_instr.new(single_attr[bracket_begin+1...bracket_end])
										end
									end
								end
								index += 1
							end
							cur_instr.setIndex($cur_bb.getInstr.length)
							cur_instr.setLN(line_number+1)
							$cur_bb.addInstr(cur_instr)	
						end
					end
				end
			end
		end

		$class_map.each do |keyc, valuec|
			valuec.getMethods.each do |key, value|
				cfg = value.getCFG
				if cfg != nil
					calculate_depinstr_for_cfg(cfg)
					calculate_merge_instr_for_branches(cfg)
					set_in_while_loop(cfg)
				end
			end
		end	
		$class_map.each do |keyc, valuec|
			valuec.getMethods.each do |key, value|
				cfg = value.getCFG
				if cfg != nil
					cfg.getBB.each do |bb|	
						#puts "\tBB#{bb.getIndex}:"
						bb.getInstr.each do |instr|
							#puts "Line Number #{instr.toString3} #{instr.getLN}"
						end
					end
				end
			end
		end	
end

def calculate_depinstr_for_cfg(cfg)
	
	cfg.getBB.each do |bb|
		#puts "\tBB#{bb.getIndex}:"
		bb.getInstr.each do |instr|
			#print "\t\tinstr: #{instr.toString}"
			instr.getDeps.each do |d|
				#print "#{d.getBlock}.#{d.getInstr}, "
				dep_instr = d.getInstrHandler
				if d.getBlock == -1 and d.getInstr == -1
					#no explicit define, look for cfg var table
					#if dep_instr != nil
					#	puts "No explicit def, handler = #{dep_instr.toString}"
					#else
					#	puts "No explicit def, handler = nil"
					#end
				else
					dep_instr = cfg.getBBByIndex(d.getBlock.to_i).getInstr[d.getInstr.to_i]
				end
				if dep_instr != nil
					d.setInstrHandler(dep_instr)
				else
					puts "DEP instr nil: #{cfg.getMHandler.getCallerClass.getName}.#{cfg.getMHandler.getName}: cur BB#{bb.getIndex}.#{instr.getIndex} depend on BB#{d.getBlock.to_i}.#{d.getInstr.to_i}"
				end 
			end	
			#puts ""
			if instr.hasClosure?
				calculate_depinstr_for_cfg(instr.getClosure)
			end
		end
	end
end

def helper_get_all_outgoings(ary, bb)
	if bb == nil
		return
	end
	ary.push(bb.getIndex.to_i)
	bb.getOutgoings.each do |o|
		if ary.include?(o)
		elsif o > bb.getIndex.to_i
			helper_get_all_outgoings(ary, bb.getCFG.getBBByIndex(o))
		end
	end
end

def calculate_merge_instr_for_branches(cfg)
	cfg.getBB.each do |bb|
		#puts "\tBB#{bb.getIndex}:"
		instr = bb.getLastInstr
		if instr.instance_of?Branch_instr
			merging_bb = Hash.new
			bb.getOutgoings.each do |o|
				merging_bb[o] = Array.new
				helper_get_all_outgoings(merging_bb[o], cfg.getBBByIndex(o))
			end
			merge_list = Array.new
			merging_bb.each do |k,v|
				v.each do |o|
					if merge_list.include?o
					else
						is_merge = true
						merging_bb.each do |k1, v1|
							if v1.include?(o)
							else
								is_merge = false
							end
						end 
						if is_merge
							merge_list.push(o)
						end
					end
				end
			end
			first_merge = merge_list[0]
			merge_list.each do |m|
				if m < first_merge
					first_merge = m
				end
			end
			merge_bb = cfg.getBBByIndex(first_merge)
			if merge_bb and merge_bb.getInstr[0]
				instr.merge_instr = merge_bb.getInstr[0]
			elsif first_merge
				instr.merge_instr = cfg.getBBPrevByIndex(first_merge).getLastInstr
			else
				#merge_bb == nil, means that all the branch returns
				instr.merge_instr = cfg.getLastInstr
			end
			#puts "#{cfg.getMHandler.getCallerClass.getName}.#{cfg.getMHandler.getName} branch at #{bb.getIndex}  merge at #{first_merge} / #{instr.merge_instr.getBB.getIndex}"
		end

		bb.getInstr.each do |instr|
			if instr.hasClosure?
				calculate_merge_instr_for_branches(instr.getClosure)
			end
		end
	end
end

def set_in_while_loop(cfg)
	cfg.getBB.each do |bb|
		bb.getOutgoings.each do |o|
			if bb.getIndex > o
				loop_instr = cfg.getBBByIndex(o).getInstr[-1]
				cfg.getBB.each do |inner_bb|
					if inner_bb.getIndex > o and inner_bb.getIndex < bb.getIndex
						inner_bb.getInstr.each do |instr|
							instr.in_while_loop = loop_instr
						end
					end
				end
			end
		end
		bb.getInstr.each do |instr|
			if instr.hasClosure?
				set_in_while_loop(instr.getClosure)
			end
		end
	end
end

#read_dataflow

#$cfg_map.each do |keyc, valuec|
#	puts "SET IRMethod, name = #{keyc}"
#	valuec.getBB.each do |bb|
#		bb.self_print
#	end
#end
