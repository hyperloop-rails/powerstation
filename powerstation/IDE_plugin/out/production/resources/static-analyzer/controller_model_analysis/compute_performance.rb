def compute_performance(output_dir, start_class, start_function, build_node_list_only=false)
	log_filename = "#{$app_dir}/#{start_class}_#{start_function}.log"
	log_file = open(log_filename)
	queries = []
	for l in log_file
		l = l.strip
		#froms,time, table, type, used 
		if l.start_with?('Query Trace')
			fn = l[/app.*rb/].gsub('app/', '')
			loc = l[/:.*:/].gsub(":", '').to_i
			froms = []
			query = []
			# froms << [fn, loc] unless fn.include?("models/")
			if !fn.include?("models/") and froms.length == 0
				froms << [fn, loc]
			end
			query << froms
			next
		end
		if l.start_with?('from')
			fn = l[/app.*rb/].gsub('app/', '') 
			loc = l[/:.*:/].gsub(":", '').to_i
			# froms << [fn, loc] unless fn.include?("models/")
			if !fn.include?("models/") and froms.length == 0
				froms << [fn, loc]
			end
			next
		end
		if l['Load'] or l['COMMIT'] or l['UPDATE'] or l['BEGIN'] or l['SELECT']
			time = l[/\(.*ms\)/]
			tts = l.split(time)[0]
			if tts.strip.split(' ').length == 2
				table = tts.strip.split(' ')[0]
				type = tts.strip.split(' ')[1]
			end
			if l['COMMIT']
				table = ''
				type = 'COMMIT'
			end
			if l['UPDATE']
				table = ''
				type = 'UPDATE'
			end
			if l['BEGIN']
				table = ''
				type = 'BEGIN'
			end
			time = time.gsub('(','').gsub(')','').gsub('ms', '').to_f
			query << time
			query << table
			query << type
			query << 0
			queries << query
			puts "QUERY #{query}"
		end
	end
	if $root == nil
		$cfg = trace_query_flow(start_class, start_function, "", "", 0)
		addAllControlEdges
		compute_source_sink_for_all_nodes
		if $cfg == nil
			return
		end
		if $cfg.getBB[0] == nil or $cfg.getBB[0].getInstr[0] == nil
			exit
		end
		$root = $cfg.getBB[0].getInstr[0].getINode	
	end
	
	
	$node_list.each do |n|
		n.setLabel
		$temp_file.puts "#{n.getIndex}:#{n.getInstr.toString}"
		if n.getValidationStack.length > 0
			str = ""
			n.getValidationStack.each do |v|
				str += "#{v.getIndex}, "
			end
			#$temp_file.puts "\t * \t transaction #{str}"
		end

		if n.getInstr.is_a?Call_instr
			caller_type = type_valid(n.getInstr, n.getInstr.getCaller)
			returnv = ""
			if n.getInstr.getDefv
				returnv = type_valid(n.getInstr, n.getInstr.getDefv)
			end
		end
	end
	cost = {}
	final_cost = {}
	final_dep = {}

	$node_list.each do |n|
		if n.getInstr
	    	re = getInstrLN(n.getInstr)
	    	if re #and re[2] == 1
	    		#puts "Rendered #{re}"
    			if cost[n]
					if final_cost[n]
						final_cost[n] += cost[n]
					else
						final_cost[n] = cost[n]
					end
    			end
	    		tdds = traceback_data_dep(n)
	    		puts "n is #{n.getInstr.toString}"
				n.getInstr.getDeps.each do |dep|
					puts "#{dep.getBlock} #{dep.getInstr}"
				end
	    		tdds.each do |tdd|
	    			if tdd.instance_of?Dataflow_edge
	    				next
	    			end
	    			ln = getInstrLN(tdd.getInstr)[0..1]
	    			puts "TDD: #{tdd.getInstr. toString}"
					for query in queries
						if !final_dep[n]
							final_dep[n] = []
						end
						if ! final_dep[n].include?query and query[0][0] == ln
							if final_cost[n]
								final_cost[n] += query[1]
							else
								final_cost[n] = query[1]
							end
							# puts "final_cost is : #{tdd.getInstr.toString} #{ln} #{final_cost[n]} tdd_cost: #{cost[tdd]}"
							final_dep[n] << query
						end
						
					end
					# puts "final_dep #{final_dep[n]}"
				
	    		end
	    		
	    	end
    	end
	end
	cost.each do |key, value|
		puts "#{key.getInstr.toString}"
		puts "#{getInstrLN(key.getInstr)}"
		puts value
	end
	
	puts "-------------------"

	final_cost.each do |key, value|
		puts "#{key.getInstr.toString}"
		puts "#{getInstrLN(key.getInstr)}"
		puts value
	end

	$node_list.each do |n|
		if n.instance_of?Dataflow_edge
			next
		end
		if not n.getInstr.instance_of?Call_instr
			next
		end
		sliced = slicing([n])
		sliced = sliced.select {|obj| not obj.instance_of?Dataflow_edge}

		puts '******************************'
		puts "Instr is: #{n.getInstr.toString}"
		sliced.each do |s|
			if not s.instance_of?Dataflow_edge and s.getInstr
				puts s.getInstr.toString
			end
		end
		puts "====================="
		sliced = sliced.sort_by {|obj| obj.getIndex}
		construct(sliced)
	end

	unused_nodes = whole_unused
	construct(unused_nodes)
end
def extractClosuresParentNode
	closures = []
	$node_list.each do |n|
		if n.getInClosure
			if n.getClosureStack.length > 0
					closures |= n.getClosureStack
			end
		end
	end	
	return closures
end
def construct(sliced)
	codes = []
	closures = []
	branches = []
	cur_closure = nil
	cur_branch = nil
	outgoings = []
	cur_instructions = []
	cur_cfg = nil
	set_else = true
	set_end = true
	all_closures = extractClosuresParentNode
	pushed = false
	sliced.each do |s|
		if not s.instance_of?Dataflow_edge and s.getInstr
			instr = s.getInstr
			code = instr.toCode
			pushed = false
			if instr.getClosure and instr.getClosure.parent_instr == instr
				closures.push(s)
				cur_closure = s
				cur_instructions = instr.getClosure.getAllInstrs
				codes.push(code)
				pushed = true
				#next
			end
			if instr.instance_of?Branch_instr
				branches.push(instr)
				cur_branch = instr
				cur_cfg = instr.getBB.getCFG
				outgoings = instr.getBB.getOutgoings
				set_else = true
				puts "outgoings #{outgoings}"
			end
			if cur_branch and instr.getBB == cur_cfg.getBBByIndex(outgoings[1]) and set_else
				codes.push("else")
				puts "instr is : #{instr.toString}"
				set_else = false
			end
			if cur_branch and instr.getBB == cur_branch.merge_instr.getBB and set_end
				codes.push("end")
				puts 'branch put end'
				branches.pop
				if branches.length > 0
					cur_branch = branches[-1]
					cur_cfg = cur_branch.getBB.getCFG
					outgoings = cur_branch.getBB.getOutgoings
					set_else = true
					set_end = true
				else
					cur_branch = nil
					cur_cfg = nil
					outgoings = []
					set_else = true
					set_end = false
				end
			end
			if cur_instructions.length > 0 
			 	if cur_instructions.include?instr 
			 	elsif instr == cur_closure.getInstr
				else
					codes.push("end")
					closures.pop
					if closures.length > 0
						cur_closure = closures[-1] 
						cur_instructions = cur_closure.getInstr.getClosure.getAllInstrs
					else
						cur_closure = nil
						cur_instructions = []
					end
					puts 'put to the end'
					cur_instructions = []
				end
			end
			if pushed == false
				codes.push(code) 
				puts code
			end
		end
	end
	while(closures.length > 0)
		codes.push("end")
		closures.pop
	end
	while(branches.length > 0)
		codes.push("end")
		branches.pop
	end
	puts "----------------------"
	vars = Array.new
	values = Array.new
	codes.each do |code|
		if code
			vv = code.split(" = ")
			if vv.length == 2
				vars.push(vv[0])
				values.push(vv[1])
			else
				vars.push("")
				values.push(code)
			end
		end
	end
	used = Array.new(values.length) { |i|  i = 0}
	for i in 0..vars.length-1
		var_i = vars[i]
		value_i = values[i]
		for j in (i+1)..vars.length-1
			var_j = vars[j]
			value_j = values[j]
			if var_i.start_with?('%') and value_j.include?var_i
				a = value_j.gsub(var_i.strip, value_i.strip)
				values[j] = a
				used[i] = 1
			end
		end
	end
	output = ""
	for i in 0..vars.length-1
		if used[i] == 0
			if vars[i].start_with?('%')
				output = output +  values[i] + "\n"
			elsif vars[i] == "" 
				output = output + values[i] + "\n" unless values[i] == ""
			else
				output = output + "#{vars[i]} = #{values[i]}" + "\n"
			end
		end
	end	
	output = output.gsub("\%self.", "")
	puts output
	puts "--------Finished--------"
end
def slicing(ns)
	nodes = Array.new
	used_nodes = Array.new
	ns.each do |n|
		used_nodes.push(n)
		nodes.push(n)
	end
	while(nodes.length > 0)
		node = nodes.pop
		if node.instance_of?Dataflow_edge
			next
		end
		puts node.getInstr.toString
		deps = traceback_data_dep(node)
		deps.each do |dep|
			if !nodes.include?dep
				nodes.push(dep)
			end
			if !used_nodes.include?dep
				used_nodes.push(dep)
			end
		end
		if node.getInClosure
			node.getNonViewClosureStack.each do |cl|
				parent_node = cl
				if !nodes.include?parent_node
					nodes.push(parent_node)
				end
				if !used_nodes.include?parent_node
					used_nodes.push(parent_node)
				end
			end
		end
		node.getInstr.getBB.getInstr[0].getINode.getBackwardControlEdges.each do |e|
			fromn = e.getFromNode
			if fromn.getInstr and fromn.getInstr.instance_of?Branch_instr
				if !nodes.include?fromn
					nodes.push(fromn)
				end
				if !used_nodes.include?fromn
					used_nodes.push(fromn)
				end				
			end
		end

	end
	return used_nodes

end

def whole_unused
	nodes = Array.new
	$node_list.each do |n|
		if n.instance_of?Dataflow_edge
			next
		end
		ln = getInstrLN(n.getInstr)
		if ln.length == 3 and ln[2] == 1
			nodes.push(n)
		elsif n.getInstr.instance_of?Call_instr 
			if n.getInstr.getFuncname == 'render'
				nodes.push(n)	unless nodes.include?n
			elsif $view_helpers.include?n.getInstr.getFuncname
				nodes.push(n)	unless nodes.include?n
			end
		end
	end
	used_nodes = slicing(nodes)
	puts used_nodes.length 
	puts $node_list.length
	puts "+++++++++++++++++++++++++++"
	unused_nodes = $node_list - used_nodes
	puts unused_nodes.length
	final_nodes = unused_nodes.select{|n| n.getInstr.getDeps.length != 0}
	puts final_nodes.length
	unused_nodes.each do |n|
		if n.instance_of?Dataflow_edge
			next
		end
		ln = getInstrLN(n.getInstr)
		if n.getInstr.getDeps.length != 0
			puts "#{n.getInstr.toString} #{n.getInstr.class} #{n.getInstr.getDefv} #{ln[0]} #{ln[1]}"
		end
	end
	return unused_nodes
end
