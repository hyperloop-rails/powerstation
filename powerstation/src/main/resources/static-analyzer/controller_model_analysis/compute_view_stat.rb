def compute_view_stat
	@view_not_in_closure = 0
	@view_in_closure_by_db_not_scale = 0
	@view_in_closure_by_db_scale = 0
	@view_in_closure_not_by_db = 0
	$node_list.each do |n|
		if n.getInstr.is_a?Call_instr and n.getInstr.getFuncname == "ruby_code_from_view"
			if n.getNonViewClosureStack.length > 0
				by_db = false
				by_db_scale = false
				n.getNonViewClosureStack.each do |cl|
					r = traceback_data_dep(cl, true)
					if r
						by_db = true
						by_db_scale = true unless r.card_limited
					end
				end
				if by_db
					if by_db_scale
						@view_in_closure_by_db_scale += 1
					else
						@view_in_closure_by_db_not_scale += 1
					end
				else
					@view_in_closure_not_by_db += 1
				end
			else
				@view_not_in_closure += 1
			end
		end
	end
	$graph_file.puts("\t<viewClosureStat>")
	$graph_file.puts("\t\t<viewNotInClosure>#{@view_not_in_closure}<\/viewNotInClosure>")
	$graph_file.puts("\t\t<viewInClosureNotByDB>#{@view_in_closure_not_by_db}<\/viewInClosureNotByDB>")
	$graph_file.puts("\t\t<viewInClosureByDBScale>#{@view_in_closure_by_db_scale}<\/viewInClosureByDBScale>")
	$graph_file.puts("\t\t<viewInClosureByDBNotScale>#{@view_in_closure_by_db_not_scale}<\/viewInClosureByDBNotScale>")
	$graph_file.puts("\t<\/viewClosureStat>")
end
