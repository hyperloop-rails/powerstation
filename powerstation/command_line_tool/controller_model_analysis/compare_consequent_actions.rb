def get_prevnodes_in_same_BB(node)
	@node_list = Array.new
	@node_list.push(node)
	@traversed = Array.new
	while @node_list.length > 0 do
		node = @node_list.pop
		node.getBackwardEdges.each do |e|
			if e.getFromNode != nil
				if e.getFromNode.isQuery?
				elsif e.getFromNode.getInstr.getBB != node.getInstr.getBB
				elsif e.getFromNode.getIndex > node.getIndex
				elsif e.getFromNode.getInstr.is_a?Call_instr
				elsif e.getFromNode != node
					@node_list.push(e.getFromNode)
					@traversed.push(e.getFromNode)
				end
			end
		end
	end
	return @traversed
end

def compare_consequent_actions_simple(cur_action_name, action_name, prev_list, next_list, freq=1)
	next_queries = 0
	same_queries = 0
	same_in_loop = 0
	next_list.each do |n|
		if n.isReadQuery?
			next_queries += 1
			prev_list.each do |pn|
				if pn.isReadQuery?
					if pn.getInstr.getCaller == n.getInstr.getCaller and pn.getInstr.getTableName == n.getInstr.getTableName and pn.getInstr.getFuncname == n.getInstr.getFuncname
						same_queries += 1
						if pn.getNonViewClosureStack.length > 0
							same_in_loop += 1
						end
					end
				end
			end
		end
	end
	$graph_file.puts("<#{action_name}>")
	$graph_file.puts("\t<nextTotal freq=\"#{freq}\">#{next_queries}<\/nextTotal>")
	$graph_file.puts("\t<nextSame freq=\"#{freq}\" in_loop=\"#{same_in_loop}\">#{same_queries}<\/nextSame>")
	$graph_file.puts("<\/#{action_name}>")
end

def compare_consequent_actions(action_name, prev_list, next_list, freq=1)
	@tables = Hash.new

	prev_list.each do |pn|
		if pn.isQuery?
			tbl_name = pn.getInstr.getTableName
			if @tables[tbl_name] == nil
				@tables[tbl_name] = Array.new
			end
			@tables[tbl_name].push(pn)
		end
	end
	
	$graph_file.puts("<#{action_name}>")
	@next_tables = Hash.new
	@next_read_total = 0
	@next_read_overlap = 0
	@next_read_subset = 0
	@next_read_superset = 0
	@next_read_same = 0
	next_list.each do |n|
		if n.isReadQuery? #and n.isChainedQuery? == false
			tbl_name = n.getInstr.getTableName
			if @tables[tbl_name] != nil
				if @next_tables[tbl_name] == nil
					@next_tables[tbl_name] = Array.new
				end
				@next_tables[tbl_name].push(n)
			end
		end
		if n.isReadQuery?
			@next_read_total += 1
		end
	end	

	@tables.each do |k, v|

		$temp_file.puts "\n * * * *"
		$temp_file.puts "cur actions query on table #{k}:"
		v.each do |v1|
			@t = get_prevnodes_in_same_BB(v1)
			@temp_hashes = Array.new
			@t.each do |pn|
					if pn.getInstr.instance_of?HashField_instr
						pn.getInstr.hash_fields.each do |h|
							@temp_hashes.push(h)
						end
					end
			end
			str = ""
			@temp_hashes.each do |h|
				str += "#{h}, "
			end
			$temp_file.puts "\t - #{v1.getIndex}: #{v1.getInstr.toString}\t -- hashes: [#{str}]"
		end

		if @next_tables[k] != nil
			@prev_fields_select = Array.new
			@next_fields_select = Array.new
			@prev_num_read = 0
			@prev_num_write = 0
			@next_num_read = 0
			v.each do |n|
				if n.isReadQuery?
					@prev_num_read += 1
				else
					@prev_num_write += 1
				end
				#n.getBackwardEdges.each do |e|
				#	if e.getFromNode != nil and e.getFromNode.getInstr.instance_of?HashField_instr
				#		e.getFromNode.getInstr.hash_fields.each do |h|
				#			if @prev_fields_select.include?(h)
				#			else
				#				@prev_fields_select.push(h)
				#			end
				#		end	
				#	end
				#end
				@t = get_prevnodes_in_same_BB(n)
				@t.each do |pn|
					if pn.getInstr.instance_of?HashField_instr
						pn.getInstr.hash_fields.each do |h|
							if @prev_fields_select.include?(h)
							else
								@prev_fields_select.push(h)
							end
						end
					end
				end
			end
			str = ""
			@prev_fields_select.each do |h|
				str	+= "#{}, "
			end
			$temp_file.puts "==== FIELDS: #{str} ===="

			@next_tables[k].each do |n|
				@next_num_read += 1
				@next_read_overlap += 1
				@others = true
				@temp_next_fields = Array.new
				n.getBackwardEdges.each do |e|
					if e.getFromNode != nil and e.getFromNode.getInstr.instance_of?HashField_instr
						e.getFromNode.getInstr.hash_fields.each do |h|
							@temp_next_fields.push(h)
							if @next_fields_select.include?(h)
							else
								@next_fields_select.push(h)
							end
						end	
					end
				end
				#test if the same query, already on the same table
				@same_q = false
				@same_Qnode = nil
				v.each do |pn|
					if pn.isReadQuery?
						if pn.getInstr.getCaller == n.getInstr.getCaller and pn.getInstr.getTableName == n.getInstr.getTableName and pn.getInstr.getFuncname == n.getInstr.getFuncname
							@same_q = true
							@same_Qnode = pn
						elsif pn.isClassField? and n.isClassField? and pn.getInstr.getTableName == n.getInstr.getTableName and pn.getInstr.getFuncname == n.getInstr.getFuncname
							@same_q = true
							@same_Qnode = pn
						elsif pn.getInstr.getTableName == n.getInstr.getTableName and pn.getInstr.getFuncname == n.getInstr.getFuncname and (["any?","blank?","all","new_record","new_record?"].include?n.getInstr.getFuncname)
							@same_q = true
							@same_Qnode = pn
						end 
					end
				end
				#sub/super set
				if @same_q
					@others = false
					@next_read_same += 1
					$temp_file.puts "SAME: @cur #{@same_Qnode.getIndex}:#{@same_Qnode.getInstr.toString}"
					$temp_file.puts "\t @next #{n.getIndex}:#{n.getInstr.toString}"	
				else
					@superset = false
					#s = "prevf: "
					#@prev_fields_select.each do |pf|
					#	s += "#{pf}, "
					#end
					#puts "#{s}"
					#s = "nextf: "
					#@temp_next_fields.each do |tf|
					#	s += "#{tf}, "
					#end
					#puts "#{s}"
					@temp_next_fields.each do |f|
						if @prev_fields_select.include?(f)
						else
							@superset  = true
							@others = false
						end
					end
					if @superset
						@next_read_superset += 1
						$temp_file.puts "\t DISTINCT #{n.getIndex}:#{n.getInstr.toString}"
					elsif @temp_next_fields.length > 0
						@others = false
						@next_read_subset += 1
						$temp_file.puts "\t -- \t SUBSET #{n.getIndex}:#{n.getInstr.toString}"
					end
				end
				if @others
					$temp_file.puts "ON same table but other: #{n.getIndex}:#{n.getInstr.toString}"
				end
			end

			$graph_file.puts("<#{k}>")
			$graph_file.puts("\t<stat>")
			$graph_file.puts("\t\t<prevRead>#{@prev_num_read}<\/prevRead>")
			$graph_file.puts("\t\t<prevWrite>#{@prev_num_write}<\/prevWrite>")
			$graph_file.puts("\t\t<nextRead>#{@next_num_read}<\/nextRead>")
			$graph_file.puts("\t<\/stat>")
			@prev_fields_select.each do |f|
				$graph_file.puts("\t<prevField>#{f}<\/prevField>")
			end
			@next_fields_select.each do |f|
				$graph_file.puts("\t<nextField>#{f}<\/nextField>")
			end
			$graph_file.puts("<\/#{k}>")
		end
	end
	$temp_file.puts "\t\tNext action different table:"
	@next_tables.each do |k, v|
		if @tables[k]
		else
			$temp_file.puts "query on table #{k}"
			v.each do |v1|
				$temp_file.puts "\t- #{v1.getIndex}:#{v1.getInstr.toString}"
			end
		end
	end	


	$graph_file.puts("\t<nextReadOverlap freq=\"#{freq}\">#{@next_read_overlap}<\/nextReadOverlap>")
	$graph_file.puts("\t<nextReadTotal freq=\"#{freq}\">#{@next_read_total}<\/nextReadTotal>")
	$graph_file.puts("\t<nextReadSame freq=\"#{freq}\">#{@next_read_same}<\/nextReadSame>")
	$graph_file.puts("\t<nextReadSuper freq=\"#{freq}\">#{@next_read_superset}<\/nextReadSuper>")
	$graph_file.puts("\t<nextReadSub freq=\"#{freq}\">#{@next_read_subset}<\/nextReadSub>")
	$graph_file.puts("<\/#{action_name}>")
	#@tables.each do |k, v|
	#	if @next_tables[k] != nil
	#		puts "Table #{k} operation overlap:"
	#		puts "\tPrevious action queries:"
	#		v.each do |n|
	#			puts "\t\t#{n.getIndex}: (#{n.getInstr.getCallHandler.complete_string.gsub("\n"," ")})"
	#		end
	#		puts "\tNext action queries:"
	#		@next_tables[k].each do |n|
	#			puts "\t\t#{n.getIndex}: (#{n.getInstr.getCallHandler.complete_string.gsub("\n"," ")})"
	#		end
	#	end
	#end
	#puts "================="
	#puts ""
end

def collect_nextaction_query_instr(freq=1)
	@temp_cnt = Array.new
	$node_list.each do |n|
		if n.isReadQuery?
			@temp_cnt.push(n.getInstr) unless @temp_cnt.include?(n.getInstr)
		end
	end
	@temp_cnt.each do |instr|
		if $nextaction_query_count[instr]
		else
			$nextaction_query_count[instr] = 0
		end
		$nextaction_query_count[instr] += freq
	end
end

def print_nextaction_query_instr(total_freq)
	$graph_file.puts("<allNextActions>")
	$graph_file.puts("\t<totalNextActions>#{total_freq}<\/totalNextActions>")
	$nextaction_query_count.each do |k, v|
		table_name = k.getTableName
		func_name = k.getFuncname
		assoc = k.getAssociationType
		func_name = "assoc" unless assoc == nil
		$graph_file.puts("\t<query name=\"#{table_name}.#{func_name}\">#{v}<\/query>")
	end
	$graph_file.puts("<\/allNextActions>")
end
