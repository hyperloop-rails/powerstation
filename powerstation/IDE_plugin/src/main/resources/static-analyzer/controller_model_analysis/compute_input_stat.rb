def compute_query_on_longest_path(startn)
	@cur_node = startn
	@q_list = Array.new
	while @cur_node
		if @cur_node.isQuery?
			@q_list.push(@cur_node)
		end
		@cur_node = @cur_node.longest_control_path_nextnode
	end
	return @q_list
end
def compute_query_on_shortest_path(startn)
	@cur_node = startn
	@q_list = Array.new
	while @cur_node
		if @cur_node.isQuery?
			@q_list.push(@cur_node)
		end
		@cur_node = @cur_node.shortest_control_path_nextnode
	end
	return @q_list
end

def compute_input_stat
	$graph_file.puts("<inputSensitivityStats>")
	$node_list.each do |n|
		if n.getInstr.getFromUserInput
			@reach_branch = false
			@shortest = 0
			@longest = 0
			traceforward_data_dep(n).each do |n1|
				if @reach_branch == false
					if n1.isBranch?
						@reach_branch = true
						@shortest = n1.shortest_path_length
						@longest = n1.path_length
						break
					end	
				end
			end
			$graph_file.puts("\t<inputBranchInstrDiff>#{@longest-@shortest}<\/inputBranchInstrDiff>")
		end
	end

	$node_list.each do |n|
		if n.getInstr.getFromUserInput
			@reach_branch = false
			@shortest = 0
			@longest = 0
			traceforward_data_dep(n).each do |n1|
				if @reach_branch == false
					if n1.isBranch?
						@reach_branch = true
						@shortest = compute_query_on_shortest_path(n1).length
						@longest = compute_query_on_longest_path(n1).length
						break
					end	
				end
			end
			$graph_file.puts("\t<inputBranchQueryDiff>#{@longest-@shortest}<\/inputBranchQueryDiff>")
		end
	end

	$graph_file.puts("<\/inputSensitivityStats>")
end
