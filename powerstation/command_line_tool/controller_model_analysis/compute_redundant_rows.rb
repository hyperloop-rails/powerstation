def compute_query_only_used_for_queries
	cnt2 = 0
	@in_loop = 0
	$node_list.each do |n|
		if n.isReadQuery?
			qn_list = traceforward_data_dep(n)
			only_to_query = false
			test2 = true
			#This kind of remove the cases like C.where().group(), so C.where() will not be considered
			if n.getDataflowEdges.length == 1 and n.getDataflowEdges[0].getFromNode.getInstr.isQuery
				test2 = false
			end
			qn_list.each do |n1|
				if n1.isQuery?
					only_to_query = true
				end
				if n1.getDataflowEdges.length == 0
					if n1.isBranch? or n1.getInView or isValidationSink(n1) or isCacheSink(n1)
						only_to_query = false
					end
					if sinkIgnore(n1) == false
						test2 = false
					end
				end
			end
			if test2 and only_to_query
				if n.getNonViewClosureStack.length > 0
					@in_loop += 1
					
				end
				cnt2 += 1
			end
		end
	end
	$graph_file.puts "<queryOnlyToQuery>"
	$graph_file.puts "\t<number2 in_loop=\"#{@in_loop}\">#{cnt2}<\/number2>"
	$graph_file.puts "<\/queryOnlyToQuery>"
end
