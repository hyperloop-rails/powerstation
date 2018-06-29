
def compute_dataflow_stat(output_dir, start_class, start_function, build_node_list_only=false)
    
	$cs = 1
	$li = 1
	$ir = 1
	$ds = 1
	$rd = 1

	graph_fname = "#{output_dir}/stats.xml"
	$graph_file = File.open(graph_fname, "w")
 
    t1 = Time.now
	if $root == nil
		$cfg = trace_query_flow(start_class, start_function, "", "", 0)
		addAllControlEdges
		puts "add all edges"
		compute_source_sink_for_all_nodes
		if $cfg == nil
			puts "cfg is null"
			return
		end
		if $cfg.getBB[0] == nil or $cfg.getBB[0].getInstr[0] == nil
			exit
		end
		$root = $cfg.getBB[0].getInstr[0].getINode	
	end
	t2 = Time.now
	puts "STATSTIME-build graph: #{t2 - t1}"
	if $cs == 1
		common_subexpression_filename = "#{$output_dir}/common_subexpression.xml"
		common_subexpression_file = File.open(common_subexpression_filename, "w")
	   
		@query_on_variable = Hash.new
		$node_list.each do |n|
			if n.isQuery?
				traceback_data_dep(n).each do |n1|
					if n1.instance_of?Dataflow_edge
					elsif n1.getInstr.instance_of?GetField_instr and n1.getInstr.getBB == n.getInstr.getBB
						#puts "#{n.getIndex}:#{n.getInstr.toString} FROM (#{e.getFromNode.getInstr.field})"
						class_name = n1.getInstr.getBB.getCFG.getMHandler.getCallerClass.getName
						variable_name = n1.getInstr.field
						query = n.getInstr.getFuncname
						hash_key = "#{class_name}.#{variable_name}"
						@query_on_variable[hash_key] = [] unless @query_on_variable.has_key?(hash_key)
						@query_on_variable[hash_key].append(n) unless @query_on_variable[hash_key].include?(n)
					end
				end	
			end
		end
		# $node_list.each do |n|
		# 	if n.isQuery?
		# 		traceback_data_dep(n).each do |n1|
		# 			if n1.instance_of?Dataflow_edge
		# 			#elsif n1.getInstr.instance_of?GetField_instr and n1.getInstr.getBB == n.getInstr.getBB
		# 			elsif n1.getInstr.isQuery and n1.getInstr.getCaller != '\%self' and n1.getInstr.getCaller != 'self' and n1.getInstr.getBB == n.getInstr.getBB
		# 				puts "n1 caller #{n1.getInstr.getCaller}"
		# 				#puts "#{n.getIndex}:#{n.getInstr.toString} FROM (#{e.getFromNode.getInstr.field})"
		# 				class_name = n1.getInstr.getBB.getCFG.getMHandler.getCallerClass.getName
		# 				variable_name = n1.getInstr.field
		# 				query = n.getInstr.getFuncname
		# 				hash_key = "#{class_name}.#{variable_name}"
		# 				puts "variable_name: #{variable_name}"
		# 				if variable_name == '' or variable_name == nil
		# 					next
		# 				end
		# 				puts "HASH_KEY #{hash_key} #{query}"
		# 				if getInstrLN(n.getInstr)[0] == -1
		# 					next
		# 				end
		# 				@query_on_variable[hash_key] = [] unless @query_on_variable.has_key?(hash_key)
		# 				@query_on_variable[hash_key].append(n) unless @query_on_variable[hash_key].include?(n)
		# 			end
		# 		end	
		# 	end
		#end


		commmon_subexpressions = []
		@query_on_variable.each do |k,v|
			if $common_subexpressions.include?([k,v])
				next
			end
			$common_subexpressions.push([k,v])
			in_loop = 0
			if !commmon_subexpressions.include?k
				commmon_subexpressions.push(k)
				expr = k[k.index('.')+1..-1]
				if expr == ''
					next
				end
				if v.length < 2
					next
				end
				common_subexpression_file.puts("<subexprs>")
				# only print the expressions
				common_subexpression_file.puts("<subexpr>#{expr}</subexpr>")

				v.each do |n1|
					if n1.getNonViewClosureStack.length > 0
						in_loop += 1
					end
					re = getInstrLN(n1.getInstr)
					common_subexpression_file.puts("<node>")
					common_subexpression_file.puts("<filename>#{re[0]}</filename>")
					common_subexpression_file.puts("<loc>#{re[1]}</loc>")
					common_subexpression_file.puts("</node>")
				end
				common_subexpression_file.puts("</subexprs>")
			end
		end
	
		common_subexpression_file.close
	end

	t3 = Time.now
	puts "STATSTIME-Common_subexpression: #{t3 - t2}"

	if $li == 1
		loop_invariant_filename = "#{$output_dir}/loop_invariant.xml"
		loop_invariant_file = File.open(loop_invariant_filename, "w")
		compute_loop_invariant(loop_invariant_file)
		loop_invariant_file.close
	end
	
	t4 = Time.now
	puts "STATSTIME-Loop invariant: #{t4 - t3}"


	if $ir == 1
		inefficient_render_filename = "#{$output_dir}/inefficient_render.xml"
		inefficient_render_file = File.open(inefficient_render_filename, "w")
		compute_inefficient_partial(inefficient_render_file)
		inefficient_render_file.close
	end


	t5 = Time.now
	puts "STATSTIME-inefficient_render: #{t5 - t4}"

	if $ds == 1
		dead_store_filename = "#{$output_dir}/dead_store.xml"
		dead_store_file = File.open(dead_store_filename, "w")
		compute_dead_store_query(dead_store_file)
		dead_store_file.close
	end

	t6 = Time.now
	puts "STATSTIME-dead_store: #{t6 - t5}"

	if $rd == 1
		redundant_usage_filename = "#{$output_dir}/redundant_usage.xml"
	    redundant_usage_file = File.open(redundant_usage_filename, 'w')
	 	compute_redundant_usage(redundant_usage_file)
		redundant_usage_file.close
	end
	
	t7 = Time.now
	puts "STATSTIME-redundant_usage: #{t7 - t5}"

end

