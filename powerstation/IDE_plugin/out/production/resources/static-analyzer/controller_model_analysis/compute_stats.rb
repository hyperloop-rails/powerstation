
def compute_dataflow_stat(output_dir, start_class, start_function, build_node_list_only=false)
    
	$cs = 1
	$li = 1
	$ir = 1
	$ds = 1
	$rd = 1

	graph_fname = "#{output_dir}/stats.xml"
	$graph_file = File.open(graph_fname, "w")
 
    #puts "FINISH CREATE FILE"
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

	if $cs == 1
		common_subexpression_filename = "#{$output_dir}/common_subexpression.xml"
		common_subexpression_file = File.open(common_subexpression_filename, "w")
	   
		@query_on_variable = Hash.new
		$node_list.each do |n|
			if n.isQuery?
				traceback_data_dep(n).each do |n1|
					if n1.instance_of?Dataflow_edge
					#elsif n1.getInstr.instance_of?GetField_instr and n1.getInstr.getBB == n.getInstr.getBB
					elsif n1.getInstr.isQuery and n1.getInstr.getCaller != '\%self' and n1.getInstr.getCaller != 'self' and n1.getInstr.getBB == n.getInstr.getBB
						puts "n1 caller #{n1.getInstr.getCaller}"
						#puts "#{n.getIndex}:#{n.getInstr.toString} FROM (#{e.getFromNode.getInstr.field})"
						class_name = n1.getInstr.getBB.getCFG.getMHandler.getCallerClass.getName
						variable_name = n1.getInstr.field
						query = n.getInstr.getFuncname
						hash_key = "#{class_name}.#{variable_name}"
						puts "variable_name: #{variable_name}"
						if variable_name == '' or variable_name == nil
							next
						end
						puts "HASH_KEY #{hash_key} #{query}"
						if getInstrLN(n.getInstr)[0] == -1
							next
						end
						@query_on_variable[hash_key] = [] unless @query_on_variable.has_key?(hash_key)
						@query_on_variable[hash_key].append(n) unless @query_on_variable[hash_key].include?(n)
					end
				end	
			end
		end


		commmon_subexpressions = []
		@query_on_variable.each do |k,v|
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

	if $li == 1
		loop_invariant_filename = "#{$output_dir}/loop_invariant.xml"
		loop_invariant_file = File.open(loop_invariant_filename, "w")
		compute_loop_invariant(loop_invariant_file)
		loop_invariant_file.close
	end
	
	if $ir == 1
		inefficient_render_filename = "#{$output_dir}/inefficient_render.xml"
		inefficient_render_file = File.open(inefficient_render_filename, "w")
		compute_inefficient_partial(inefficient_render_file)
		inefficient_render_file.close
	end

	if $ds == 1
		dead_store_filename = "#{$output_dir}/dead_store.xml"
		dead_store_file = File.open(dead_store_filename, "w")
		compute_dead_store_query(dead_store_file)
		dead_store_file.close
	end

	if $rd == 1
		redundant_usage_filename = "#{$output_dir}/redundant_usage.xml"
	    redundant_usage_file = File.open(redundant_usage_filename, 'w')
	 	compute_redundant_usage(redundant_usage_file)
		redundant_usage_file.close
	end
	
end

def helper_print_stat(general, readSink, readSource, write, label, print_branch=true)
	$graph_file.puts("\t\t<queryTotal>#{general.total}<\/queryTotal>")
	$graph_file.puts("\t\t<readTotal>#{general.read}<\/readTotal>")
	$graph_file.puts("\t\t<writeTotal>#{general.write}<\/writeTotal>")
	$graph_file.puts("\t\t<queryInView>#{general.in_view}<\/queryInView>")
	$graph_file.puts("\t\t<queryInViewAssoc>#{general.in_view_assoc}<\/queryInViewAssoc>")
	$graph_file.puts("\t\t<queryIssuedByOther>#{general.issued_by_other}<\/queryIssuedByOther>")
	$graph_file.puts("\t\t<queryInClosure>#{general.in_closure}<\/queryInClosure>")
	$graph_file.puts("\t\t<queryReadInClosure>#{general.read_in_closure}<\/queryReadInClosure>")
	$graph_file.puts("\t\t<queryInClosureByDB>#{general.in_closure_by_db}<\/queryInClosureByDB>")
	$graph_file.puts("\t\t<queryInClosureByDBScale>#{general.in_closure_by_db_scale}<\/queryInClosureByDBScale>")
	$graph_file.puts("\t\t<queryInWhile>#{general.in_while}<\/queryInWhile>")
	$graph_file.puts("\t\t<queryInWhileByDB>#{general.in_while_by_db}<\/queryInWhileByDB>")
	$graph_file.puts("\t\t<queryInClosureWithCarrydep>#{general.in_loop_has_carrydep}<\/queryInClosureWithCarrydep>")


	$graph_file.puts("\t\t<queryUseSQLString>#{general.use_query_string}<\/queryUseSQLString>")

	if print_branch
		$graph_file.puts("\t\t<branchOnQuery>#{general.branch_dependon_query}<\/branchOnQuery>")
		$graph_file.puts("\t\t<branchInView>#{general.branch_in_view}<\/branchInView>")
		$graph_file.puts("\t\t<branchTotal>#{general.total_branch}<\/branchTotal>")
	end

	$graph_file.puts("\t\t<readSink>")
	$graph_file.puts("\t\t\t<total>#{readSink.total}<\/total>")
	$graph_file.puts("\t\t\t<sinkTotal>#{readSink.get_sink_total}<\/sinkTotal>")
	$graph_file.puts("\t\t\t<toReadQuery>#{readSink.get_to_read_query}<\/toReadQuery>")
	$graph_file.puts("\t\t\t<toWriteQuery>#{readSink.get_to_write_query}<\/toWriteQuery>")
	$graph_file.puts("\t\t\t<toView>#{readSink.get_to_view}<\/toView>")
	$graph_file.puts("\t\t\t<toBranch>#{readSink.get_to_branch}<\/toBranch>")
	$graph_file.puts("\t\t<\/readSink>")

	if readSource
		$graph_file.puts("\t\t<readSource>")
		$graph_file.puts("\t\t\t<total>#{readSource.total}<\/total>")
		$graph_file.puts("\t\t\t<sourceTotal>#{readSource.get_source_total}<\/sourceTotal>")
		$graph_file.puts("\t\t\t<fromUserInput>#{readSource.get_from_user_input}<\/fromUserInput>")
		$graph_file.puts("\t\t\t<fromUtil>#{readSource.get_from_util}<\/fromUtil>")
		$graph_file.puts("\t\t\t<fromQuery>#{readSource.get_from_query}<\/fromQuery>")
		$graph_file.puts("\t\t\t<fromQueryString>#{readSource.get_from_query_string}</fromQueryString>")
		$graph_file.puts("\t\t\t<selectCondition>#{readSource.get_from_select_condition}</selectCondition>")
		$graph_file.puts("\t\t\t<fromConst>#{readSource.get_from_const}<\/fromConst>")
		$graph_file.puts("\t\t\t<fromGlobal>#{readSource.get_from_global}<\/fromGlobal>")
		$graph_file.puts("\t\t<\/readSource>")
	end

	$graph_file.puts("\t\t<writeSource>")
	$graph_file.puts("\t\t\t<total>#{write.total}<\/total>")
	$graph_file.puts("\t\t\t<sourceTotal>#{write.get_source_total}<\/sourceTotal>")
	$graph_file.puts("\t\t\t<fromUserInput>#{write.get_from_user_input}<\/fromUserInput>")
	$graph_file.puts("\t\t\t<fromUtil>#{write.get_from_util}<\/fromUtil>")
	$graph_file.puts("\t\t\t<fromQuery>#{write.get_from_query}<\/fromQuery>")
	$graph_file.puts("\t\t\t<selectCondition>#{write.get_from_select_condition}<\/selectCondition>")
	$graph_file.puts("\t\t\t<fromConst>#{write.get_from_const}<\/fromConst>")
	$graph_file.puts("\t\t\t<fromGlobal>#{write.get_from_global}<\/fromGlobal>")
	$graph_file.puts("\t\t<\/writeSource>")
end
