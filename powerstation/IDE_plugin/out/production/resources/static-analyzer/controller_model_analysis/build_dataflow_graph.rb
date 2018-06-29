def print_call_stack
	str = ""
	$call_stack_trace.each do |c|
		str += "#{c} || "
	end
	return str
end

def handle_single_call_node2(start_class, start_function, instr, level)
		if instr.isClassField or instr.isTableField or instr.instance_of?AttrAssign_instr or instr.instance_of?GetField_instr 
			return 
		end
	
		#puts "stack #{$call_stack_trace.length}: #{print_call_stack}  "
		#puts "\tprocessing #{$ins_cnt}: #{instr.toString}"

		caller_class = instr.getCallerType
		if instr.isQuery
			$cur_node.setLabel
		
			if instr_trigger_save?(instr) or instr_trigger_create?(instr)
				$node_list.pop
				$ins_cnt -= 1

				temp_actions = Array.new
				if caller_class and instr_trigger_save?(instr)
						temp_actions.push("before_save")
						temp_actions.push("before_validation")
				end
				if caller_class and instr_trigger_create?(instr)
							temp_actions.push("before_create")
				end

				last_cfg = nil
				temp_node = $cur_node
				$def_self_nodes[temp_node] = Array.new
				prev_defself = Array.new
				temp_node.getInstr.getDeps.each do |dep|
					if dep.getInstrHandler.getINode != nil
						#puts "SAVE: : #{temp_node.getInstr.toString} add predef #{dep.getInstrHandler.getINode.getIndex}"
						prev_defself.push(dep.getInstrHandler.getINode)
					end
				end

				$in_validation.push(temp_node)
				temp_actions.each do |action|
						temp_name = "#{caller_class}.#{action}"
						#if $non_repeat_list.include?(temp_name) == false
						if $call_stack_trace.include?(temp_name) or check_nonrepeat(caller_class, action)==false
						else	
							$non_repeat_list.push(temp_name)
							$call_stack_trace.push(temp_name)
							#if $class_map[caller_class] != nil and $class_map[$class_map[caller_class].getUpperClass] != nil
								#cur_cfg = trace_query_flow($class_map[caller_class].getUpperClass, action, "", "", level+2)
								#TODO: add control flow edges...
							#end
							cur_cfg = trace_query_flow(caller_class, action, "", "", level+2)
							if cur_cfg != nil
								#XXX: If it is validation function before an insert/update query, then the all the outlet of the validation function goes to that query
								#validation funcs may update fields in the class, and the insert/update query will have data dependency on those functions
								#TODO: before_validation can also affect normal functions...
								#cur_cfg.getDefSelf.each do |rt|
								#	@outnodes.push(rt)
								#end
								prev_defself.each do |p|
									receive_node = cur_cfg.getBB[0].getInstr[0].getINode
									edge_name = "#{p.getIndex}*#{receive_node.getIndex}"
									edge = Dataflow_edge.new(p, receive_node, "%self")
									p.addDataflowEdge(edge)
									if $dataflow_edges[edge_name] == nil
										$dataflow_edges[edge_name] = Array.new
									end
									$dataflow_edges[edge_name].push(edge)
								end

								if last_cfg == nil
									temp_node.addChild(cur_cfg.getBB[0].getInstr[0].getINode)
								else
									last_cfg.getReturns.each do |r|
										r.addChild(cur_cfg.getBB[0].getInstr[0].getINode)
									end
								end
								last_cfg = cur_cfg
							end
							$call_stack_trace.pop
						end
				end
				$in_validation.pop
				temp_node.index = $ins_cnt
				$node_list.push(temp_node)
				#str = ""
				#$def_self_nodes[temp_node].each do |rt|
				#	str += "\t==#{rt.getIndex}\t==\n"
				#end
				#puts "VALIDATION: #{temp_node.getIndex} DEFSELF: #{str}"
				$def_self_nodes[temp_node].each do |rt|
					dataflow_edge_name = "#{rt.getIndex}*#{temp_node.getIndex}"
					edge = Dataflow_edge.new(rt, temp_node, "%self")
					rt.getInstr.getINode.addDataflowEdge(edge)
					$dataflow_edges[dataflow_edge_name] = edge
				end
				$ins_cnt += 1
			end
				
		elsif caller_class != nil	
			temp_name = "#{caller_class}.#{instr.getFuncname}"

			#if $non_repeat_list.include?(temp_name) and is_repeatable_function(temp_name)==false
				#puts "executed before: #{instr.getCaller}, #{instr.getFuncname}"
			if $call_stack_trace.include?(temp_name) or check_nonrepeat(caller_class, instr.getFuncname)==false
				#puts "\t\t... #{temp_name} already in stack , called"
			else
				$call_stack_trace.push(temp_name)
				$non_repeat_list.push(temp_name)
				temp_node = $cur_node
				if instr.getFuncname == "super" and $class_map[caller_class].getUpperClass
					cur_cfg = trace_query_flow($class_map[caller_class].getUpperClass, start_function, "", "", level+1)
					#puts "Handle super call: #{start_class}: upper = #{$class_map[caller_class].getUpperClass} funcname = #{instr.getFuncname}, actual func name = #{start_function}"
				else	
					cur_cfg = trace_query_flow(caller_class, instr.getFuncname, "", "", level+1)
				end
				$call_stack_trace.pop
				if cur_cfg != nil and cur_cfg.getBB[0]
					temp_node.addChild(cur_cfg.getBB[0].getInstr[0].getINode)
				end
				if cur_cfg != nil
					cur_cfg.getExplicitReturn.each do |rt|
						dataflow_edge_name = "#{rt.getIndex}*#{temp_node.getIndex}*returnv"
						edge = Dataflow_edge.new(rt, temp_node, "returnv")
						
						rt.getInstr.getINode.addDataflowEdge(edge)
						$dataflow_edges[dataflow_edge_name] = edge
					end
					cur_cfg.explicit_return = Array.new
					cur_cfg.getBB.each do |b|
						b.explicit_return = Array.new
					end
					temp_node.getInstr.setCallCFG(cur_cfg)
				end
			end
		else
		#	puts "Callerv = nil: #{instr.getCaller} . #{instr.getFuncname}"
		end
end

def handle_single_instr2(start_class, start_function, class_handler, function_handler, instr, level, return_list)
	node = INode.new(instr)
	blank = ""
	for i in (0...level)
		blank = blank + "\t"
	end
#	puts "\tInstr: ##{node.getIndex} #{node.getInstr.toString} "
	return_list.each do |r|
		r.addChild(node)
	end
	$cur_node = node
	$node_list.push($cur_node)
	$ins_cnt += 1

	#class member defined in one function may be used in another function
	#add to class member def list
	#For example, before_action can set some values used by other functions
	if instr.instance_of?GetField_instr and instr.getCallerType == class_handler.getName
		class_handler.member_gets[instr.getFuncname] = Array.new unless class_handler.member_gets.has_key?(instr.getFuncname)
		class_handler.member_gets[instr.getFuncname].push(instr.getDefv)
	end
	if instr.instance_of?AttrAssign_instr and instr.getCallerType == class_handler.getName
		if class_handler.member_defs[instr.getFuncname]
		else
			class_handler.member_defs[instr.getFuncname] = Array.new
		end
		class_handler.member_defs[instr.getFuncname].push(node)
	elsif instr.instance_of?AttrAssign_instr
		
		#puts "FIND A GETFIELD: #{$ins_cnt} #{instr.toString} #{instr.getCaller}"
		field_name = nil
		class_handler.member_gets.each do |k, v|
			v.each do |temp_var_name|
				if temp_var_name == instr.getCaller
					field_name = k 
				end
			end
		end
		if field_name
			class_handler.member_defs[field_name] = Array.new unless class_handler.member_defs.has_key?(field_name)
			class_handler.member_defs[field_name].push(node)
		end
	end

	if instr.is_a?Call_instr
		$funccall_stack.push($cur_node)
		$general_call_stack.push($cur_node)
		handle_single_call_node2(start_class, start_function, instr, level)
		$funccall_stack.pop
		$general_call_stack.pop
	end

	if instr.is_a?ReceiveArg_instr
		if $general_call_stack.length > 0
			dep = $general_call_stack[-1]
			dep_inode = nil
			arg_index = 0
			instr.getBB.getCFG.getBB.each do |b|
				if b == instr.getBB
					break
				end
				b.getInstr.each do |ins|
					if instr.is_a?ReceiveArg_instr
						arg_index += 1
					end
				end
			end
			instr.getBB.getInstr.each do |inner_i|
				if inner_i == instr
					break
				elsif inner_i.is_a?ReceiveArg_instr
					arg_index += 1
				end
			end
			arg_name = dep.getInstr.args[arg_index]
			dep.getInstr.getDeps.each do |d|
				if d.getVname == arg_name
					dep_inode = d.getInstrHandler.getINode
				end
			end
			if dep.getInstr.hasClosure?
				dep_inode = dep
			end
			if dep_inode != nil
				edge_name = "#{dep_inode.getIndex}*#{node.getIndex}"
				edge = Dataflow_edge.new(dep_inode, node, arg_name)
				dep_inode.addDataflowEdge(edge)
				if $dataflow_edges[edge_name] == nil
					$dataflow_edges[edge_name] = Array.new
				end
				$dataflow_edges[edge_name].push(edge)
			end
		end
	end

	#if instr.instance_of?Return_instr
	#	instr.getDeps.each do |dep|
	#		if dep.getInstrHandler.getINode != nil
	#			from_node = dep.getInstrHandler.getINode
	#			if dep.getVname == "%self"
	#				if instr.getBB.getCFG.getDefSelf.include?(from_node)==false
	#					instr.getBB.getCFG.addDefSelf(from_node)
	#				end
	#			end
	#		end
	#	end
	#end

	add_dataflow_edge(node)
	if instr.instance_of?GetField_instr
		handle_get_field_instr(node)
	end

	new_return_l = Array.new	
	if instr.hasClosure?
		@cl = instr.getClosure
		temp_node = $cur_node
		if @cl.getViewClosure
			$in_view = true
		else
			$in_loop.push(true)
		end
		if instr.instance_of?Call_instr and (isNonClosureInstr(instr) or instr.getCaller == "format")
			$show_stack.push($cur_node)
			handle_single_cfg2(start_class, start_function, class_handler, function_handler, @cl, level) 
			$show_stack.pop
		else
			$closure_stack.push($cur_node)
			$general_call_stack.push($cur_node)
			handle_single_cfg2(start_class, start_function, class_handler, function_handler, @cl, level) 
			$closure_stack.pop
			$general_call_stack.pop
		end
		@cl.getReturns.each do |r|
			new_return_l.push(r)
		end
		if @cl.getViewClosure
			$in_view = false
		else
			$in_loop.pop
		end
		temp_node.addChild(@cl.getFirstInstr.getINode)
	elsif
		new_return_l.push($cur_node)
	end
	return new_return_l
end

def handle_single_bb2(start_class, start_function, class_handler, function_handler, bb, level)
#	print "\tBB: #{bb.getIndex}, outgoings:"
#	bb.getOutgoings.each do |o|
#		print "#{o}, "
#	end
#	puts ""

	r_list = Array.new	
	if bb.getInstr.length == 0
		empty_instr = Instruction.new
		bb.addInstr(empty_instr)	
	end
	bb.getInstr.each do |instr|
		r_list = handle_single_instr2(start_class, start_function, class_handler, function_handler, instr, level, r_list)
	end
	bb.getInstr.each do |instr|
		if instr.instance_of?Return_instr
			r_list.push(instr.getINode)
			bb.addExplicitReturn(instr.getINode)
		elsif bb.getCFG.getMHandler.normal_function == false
			r_list.push(instr.getINode)
			bb.addExplicitReturn(instr.getINode)
		end
	end

	#puts "instr #{$cur_node.getIndex}.return length = #{r_list.length}"	
	#The last instr's return list plus all return instrs.
	r_list.each do |r|
		bb.addReturn(r)
	end
end

def handle_single_cfg2(start_class, start_function, class_handler, function_handler, cfg, level)
	#puts "CFG: #{class_handler.getName}.#{function_handler.getName}"
	
	cfg.getBB.each do |bb|
		handle_single_bb2(start_class, start_function, class_handler, function_handler, bb, level)
	end	

	#add data dependency between "self" and funccall instr
	#Can either be bb1.instr0
	#or bb2.instr0
	fromIns = nil
	if cfg.getBB.length == 1 and cfg.getBB[0].getInstr.length > 0
		fromIns = cfg.getBB[0].getInstr[0]
	elsif cfg.getBB[1]
		fromIns = cfg.getBB[1].getInstr[0]
	end	
	if fromIns and fromIns.getDefv != nil and fromIns.getDefv == "%self"
	else
		fromIns = nil
	end

	if $funccall_stack.length > 0 and fromIns != nil
		if isValidationFunc(function_handler.getName)
		elsif is_sub_or_upper_class($funccall_stack[-1].getInstr.getCallerType, cfg.getMHandler.getCallerClass.getName) #and function_defself($funccall_stack[-1].getInstr.getBB.getCFG.getMHandler) #TODO: Messy too... only pass "self" when the upper class actually defines "self" 
			dep = $funccall_stack[-1]
			edge_name = "#{dep.getIndex}*#{fromIns.getINode.getIndex}"
			edge = Dataflow_edge.new(dep, fromIns.getINode, "%self")
			dep.addDataflowEdge(edge)
			if $dataflow_edges[edge_name] == nil
				$dataflow_edges[edge_name] = Array.new
			end
			$dataflow_edges[edge_name].push(edge)
		end
	end


	cfg.getBB.each do |bb|
		#TODO: THIS IS SO MESSY...
		if ["before_save", "before_create"].include?function_handler.getName
			bb.getInstr.each do |i|
				if i.instance_of?Call_instr and i.getCallCFG != nil
					i.getCallCFG.getDefSelf.each do |d|
						cfg.addDefSelf(d)
					end
				end
			end
		end

		#puts "BB's return length = #{bb.getReturns.length}"
		bb.getOutgoings.each do |o|
			o_bb = cfg.getBBByIndex(o)
	
			#Add edge to instruction node
			bb.getReturns.each do |r|
				r.addChild(o_bb.getInstr[0].getINode)
				#puts "ADD BLOCK CONNECT: #{r.getIndex} -> #{o_bb.getInstr[0].getINode.getIndex}"	
			end
		end
		bb.getExplicitReturn.each do |r|
			cfg.addExplicitReturn(r)
		end
		
		#control flow outage point
		#TODO: return instr is not handled, sometimes the outage point may be return instrs
		#if bb.getOutgoings.length == 0
		#	cfg.addReturn(r)
		#end
	end

end

def trace_query_flow(start_class, start_function, params, returnv, level)

	if start_class == "StatusMessage"
		puts "Call status message: #{start_function}"
	end
	$cur_class = start_class
	class_handler = $class_map[start_class]
	if class_handler != nil
		function_handler = class_handler.findMethodRecursive(start_function)
	else
		function_handler = nil
	end

	if function_handler == nil
		if is_transaction_function(start_function)
			#if start_function.include?("begin")
			#	puts "#{$blank}======transaction begin====="
			#else
			#	puts "#{$blank}======transaction end====="
			#end
		end
		#puts "function #{start_class}.#{start_function} cannot be found"
		return nil 
	end

	
	#TODO: Before filter is not handled here, since most of them just do validation and are not involved in dataflow	
	before_filter_name = "#{start_class}.before_filter"
	filter_handler = $class_map[start_class].getMethods["before_filter"]

  if $call_stack_trace.include?(before_filter_name)==false and check_nonrepeat(start_class, "before_filter")
		$call_stack_trace.push(before_filter_name)
	#if $non_repeat_list.include?(before_filter_name) == false
		$non_repeat_list.push(before_filter_name)
		
		cfg = CFG.new
		filter_handler.setCFG(cfg)
		filter_handler.normal_function = false
		bb = Basic_block.new(1)
		def_self = Instruction.new
		def_self.setDefv("%self")
		bb.addInstr(def_self)
		if filter_handler != nil	
			filter_handler.getCalls.each do |c|
				if c.getOn.length == 0 or c.getOn.include?(start_function)
					call_instr = Call_instr.new(c.getObjName, c.getFuncName)
					call_instr.addDatadep("1.0", "%self", def_self)
					bb.addInstr(call_instr)
				end
			end
			cfg.addBB(bb)
			handle_single_cfg2(start_class, "before_filter", class_handler, filter_handler, cfg, level)
		end
		$call_stack_trace.pop
	end

	if function_handler.getCFG != nil
		handle_single_cfg2(start_class, start_function, class_handler, function_handler, function_handler.getCFG, level)
		return function_handler.getCFG
	else
		#cfg = CFG.new
		#function_handler.setCFG(cfg)
		#bb = Basic_block.new(1)
		#def_self = Instruction.new
		#def_self.setDefv("%self")
		#bb.addInstr(def_self)
		#function_handler.getCalls.each do |c|
		#	call_instr = Call_instr.new(c.getObjName, c.getFuncName)
		#	call_instr.setCallHandler(c)
		#	call_instr.addDatadep("1.0", "%self", def_self)
		#	bb.addInstr(call_instr)
		#end
		#cfg.addBB(bb)
		#handle_single_cfg2(start_class, start_function, class_handler, function_handler, cfg, level)
		#return cfg
	end
	return nil
end


def traverse_instr_tree(node, level)
	if $global_check.has_key?(node.getIndex)
		return
	end
	$global_check[node.getIndex] = node
	node.getChildren.each do |c|
		#if c.isQuery?
		#	puts "QUERY: #{c.getInstr.getCaller}.#{c.getInstr.getFuncname}"
		#end
		blank = ""
		
		for i in (0...level)
			blank = blank + " "
		end
		#puts "#{blank}#{c.getInstr.toString}"
		traverse_instr_tree(c, level + 1)
	end
end


def is_directly_connected(node1, node2)
	if $global_check.has_key?(node1.getIndex)
		return false
	end
	$global_check[node1.getIndex] = node1
	node1.getChildren.each do |c|
		if c == node2
			return true
		elsif c.isQuery? == false and is_directly_connected(c, node2)
			return true
		end
		#if is_directly_connected(c, node2)
		#	if c.isQuery? == true
		#		puts "n#{c.getIndex} -> n#{node2.getIndex}"
		#	else
		#		return true
		#	end
		#end
	end
	return false
end

