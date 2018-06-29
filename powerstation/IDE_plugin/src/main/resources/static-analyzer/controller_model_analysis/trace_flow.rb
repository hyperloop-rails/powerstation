$QUERY_COLOR = "orange"
$FLOWEDGE_COLOR = "blue"

def get_closure_tag
	r = ""
	i = 0
	if $closure_stack.length > 0
		r += "#{$closure_stack[-1].getRand}"
	end
	r += "_"
	$closure_stack.each do |c|
		r += "closure#{i}_"
		i += 1
	end
	return r
end
#TODO: a lot of duplicated code

def handle_single_call_node(start_class, start_function, class_handler, call, level, bb_index, simplified_caller=nil)
		#callerv_name = call.findCaller(start_class, start_function)
		#callerv = $class_map[callerv_name]
		#pre-computed after reading all files, in #read_file.rb
		callerv = call.caller
		pass_params = ""     
		pass_returnv = ""    
		call.getParams.each do |param|
			if param.getVar.length > 0
					pass_params += "#{param.getVar}, "
			end
		end
		pass_returnv = call.getReturnValue
		if call.isQuery
			caller_class = ""
			if callerv != nil
				caller_class = callerv.getName
			end
			if trigger_save?(call) or trigger_create?(call)
				OUTPUT_Direct "=====transaction begin====="
			end

			$blank = ""
			for i in (0...level)
				$blank = $blank + "\t"
			end

			OUTPUT_Direct "#{$blank}\tlevel #{(level+1)}:  [QUERY] #{call.getObjName} . #{call.getFuncName}	{params: #{pass_params}} # {returnv: #{pass_returnv}} # {op: #{caller_class}.#{call.getQueryType}}"
			$l_index += 1

			if trigger_save?(call) or trigger_create?(call)
				if callerv != nil and trigger_save?(call)
						#TODO: here we assume validation associate with 
						temp_name = "#{callerv.getName}.before_save"
						if $non_repeat_list.include?(temp_name) == false
							$non_repeat_list.push(temp_name)

							if $class_map[callerv.getUpperClass] != nil	
								trace_flow(callerv.getUpperClass, "before_save", "", "", level+2)
							end
							trace_flow(callerv.getName, "before_save", "", "", level+2)
						end

						temp_name = "#{callerv.getName}.before_validation"
						if $non_repeat_list.include?(temp_name) == false
							$non_repeat_list.push(temp_name)

							if $class_map[callerv.getUpperClass] != nil	
								trace_flow(callerv.getUpperClass, "before_validation", "", "", level+2)
							end
							trace_flow(callerv.getName, "before_validation", "", "", level+2)
						end

				end
				
				if callerv != nil and trigger_create?(call)
						temp_name = "#{callerv.getName}.before_create"
						if $non_repeat_list.include?(temp_name) == false
							$non_repeat_list.push(temp_name)
							if $class_map[callerv.getUpperClass] != nil	
								trace_flow(callerv.getUpperClass, "before_create", "", "", level+2)
							end

							trace_flow(callerv.getName, "before_create", "", "", level+2)
						end
				end
				OUTPUT_Direct "=====transaction end====="
			end


		elsif callerv != nil
			temp_name = "#{callerv.getName}.#{call.getFuncName}"

			$l_index += 1

			if $non_repeat_list.include?(temp_name) == false
				if is_repeatable_function(call.getFuncName)==false
					$non_repeat_list.push(temp_name)
				end

				trace_flow(callerv.getName, call.getFuncName, pass_params, pass_returnv, level+1)
			else
				#OUTPUT_Direct "HAS been executed: #{temp_name} (#{call.getObjName}, #{call.getFuncName})"
			end
		else
			#OUTPUT_Direct "CANNOT find caller #{call.getObjName}.#{call.getFuncName} --"
		end
end


def handle_single_bb(start_class, start_function, class_handler, bb, label_list, function_handler, level)
	$l_index = 0
	bb.getInstr.each do |instr|
		handle_single_instr(start_class, start_function, class_handler, bb, instr, label_list, function_handler, level)
	end

	bb.setLabelN($l_index)			
end

def handle_single_instr(start_class, start_function, class_handler, bb, instr, label_list, function_handler, level)

	instr.setFTag($l_index)
	if instr.is_a?Call_instr
		#match instr's call to funccall in Method_class
		call = call_match_name(instr.getResolvedCaller, instr.getFuncname, function_handler)
		#if call == nil
		#	OUTPUT_Direct "Name doesn't match: #{instr.toString} [#{instr.getResolvedCaller}]" 
		#else
		#	OUTPUT_Direct "match call: #{instr.toString} [#{instr.getResolvedCaller}]-> #{call.getObjName}.#{call.getFuncName}"
		#end
		if call != nil

			#OUTPUT_Direct "Map to #{call.getObjName}.#{call.getFuncName}"
			#print "\t -- "
			#call.print
		
			if instr.getResolvedCaller.length > 0
				handle_single_call_node(start_class, start_function, class_handler, call, level, bb.getIndex, instr.getResolvedCaller)
			else
				handle_single_call_node(start_class, start_function, class_handler, call, level, bb.getIndex)				
			end
	
		end
	end
		
	if instr.hasClosure?
		cl = instr.getClosure
		$closure_stack.push(cl)
		cl.getBB.each do |inner_bb|
			handle_single_bb(start_class, start_function, class_handler, inner_bb, label_list, function_handler, level)
		end
		$closure_stack.pop
	end

end

def write_single_bb(start_class, start_function, bb)
	from_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB#{bb.getIndex}"
	
	bb.getOutgoings.each do |to_bb|
		to_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB#{to_bb}"
		$graph_file.write("\t#{from_bb_name} -> #{to_bb_name} [ color=#{$FLOWEDGE_COLOR} ];\n")
	end

	index = 0
	bb.getInstr.each do |instr|
		if instr.hasClosure?
			cl = instr.getClosure
			$closure_stack.push(cl)
			to_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB1"
			to_end_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB#{cl.getLastBB.getIndex}"
			$graph_file.write("\t#{from_bb_name}:f#{instr.getFTag} -> #{to_bb_name} [color=#{$FLOWEDGE_COLOR} ];\n")
			$graph_file.write("\t#{to_end_bb_name}:f0 -> #{from_bb_name} [color=#{$FLOWEDGE_COLOR} ];\n")

			cl.getBB.each do |inner_bb|
				write_single_bb(start_class, start_function, inner_bb)
			end
			cl_last_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB#{cl.getBB[-1].getIndex}"
			cl_first_bb_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB#{cl.getBB[0].getIndex}"
			$graph_file.write("\t#{cl_last_bb_name} -> #{cl_first_bb_name} [color=#{$FLOWEDGE_COLOR} ];\n")

			$closure_stack.pop
		end
		index = index + 1
	end
end


def trace_flow(start_class, start_function, params, returnv, level)
	class_handler = $class_map[start_class]
	if class_handler == nil
		OUTPUT_Direct "Class handler not found: #{start_class}"
	end
	if class_handler != nil
		function_handler = class_handler.getMethod(start_function)
	else
		function_handler = nil
	end

	$blank = ""
	for i in (0...level)
		$blank = $blank + "\t"
	end

	if function_handler == nil
		if is_transaction_function(start_function)
			if start_function.include?("begin")
				OUTPUT_Direct "#{$blank}======transaction begin====="
			else
				OUTPUT_Direct "#{$blank}======transaction end====="
			end
			return 
		else
			#OUTPUT_Direct "function #{start_class}.#{start_function} cannot be found"
			return 
		end
	end	

	#$graph_file.write("subgraph cluster_#{start_class}_#{start_function}")

	#handles before_filter
	before_filter_name = "#{start_class}.before_filter"
	if $non_repeat_list.include?(before_filter_name) == false
		$non_repeat_list.push(before_filter_name)

		trace_flow(start_class, "before_filter", "", "", level)
	end

	OUTPUT_Direct "#{$blank}level #{level}: #{start_class} . #{start_function} (params: #{params}) # (returnv: #{returnv})"

	if $last_caller_string.length > 0	
		_to_name = "#{start_class}_#{simplify(start_function)}_#{get_closure_tag}BB1" 
		$graph_file.write("#{$last_caller_string} -> #{_to_name} [label = \"#{params}\"]; \n")
		if returnv.length > 0
			$graph_file.write("#{_to_name} -> #{$last_caller_string} [label = \"r: (#{returnv})\"]; \n")
		end
	end
	
	label_list = Array.new

	if function_handler.getCFG != nil
		function_handler.getCFG.getBB.each do |bb|
			handle_single_bb(start_class, start_function, class_handler, bb, label_list, function_handler, level)
			
		end

	#Function is not specifically defined, like .new .valid?, etc
	else

		#OUTPUT_Direct "#{start_class}.#{start_function} is not matched"
		$label = ""
		$l_index = 0

		function_handler.getCalls.each do |call|
			handle_single_call_node(start_class, start_function, class_handler, call, level, 1)

		end
	end

	#OUTPUT_Direct "#{$blank}level #{level}: #{start_class} . #{start_function} (params: #{params}) # (returnv: #{returnv})"
	#OUTPUT_Direct "#{$blank}(write subgraph #{start_class}_#{start_function})"


	if function_handler.getCFG != nil	
		function_handler.getCFG.getBB.each do |bb|
			write_single_bb(start_class, start_function, bb)
		end
	end	

end
