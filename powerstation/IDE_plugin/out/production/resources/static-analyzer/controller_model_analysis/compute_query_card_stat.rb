$query_return_limited_recs=['any?','blank?','maximum','minumum','calculate','average','sum','pluck','lock','none','limit','uniq','readonly','new_record','new_record?','exits?','many?','first','second','first!','second!','last','count','first_or_initialize','find_by_id','count_by_sql']

#def find_instance_method_call

def compute_query_card_stat
	$node_list.each do |n|
		if n.isReadQuery?
			#check chained query
			@temp_list = Array.new
			@temp_list.push(n)
			@n1 = n
			while @n1
				@old_n1 = @n1
				@old_n1.getDataflowEdges.each do |e|
					if e.getToNode.isReadQuery? and @old_n1.getInstr.getDefv == e.getToNode.getInstr.getCaller#@old_n1.getDataflowEdges.length == 1
						@temp_list.push(e.getToNode)
						@n1 = e.getToNode
					end
				end
				if @old_n1 == @n1
					@n1 = nil
				end
			end
			@card_limited = false
			@temp_list.each do |t|
				if t.getInstr.getFuncname.include?('?') or t.getInstr.getFuncname.include?('!') or $query_return_limited_recs.include?(t.getInstr.getFuncname)
					@card_limited = true
				end
			end
			if n.getInstr.getMethodName == "before_validation" or n.getInstr.instance_of?AttrAssign_instr
				@card_limited = true
			end
			if @card_limited == false 
				if $key_words.has_key?(n.getInstr.getFuncname)
					n.getInstr.hash_fields.each do |h|
						if h == "id"
							@card_limited = true
						end
					end
				else
					if n.getInstr.getAssociationType and ["has_and_belongs_to_many","has_many"].include?n.getInstr.getAssociationType
					else
						@card_limited = true
					end
				end
			end
			if @card_limited
				n.setCardLimited
				#@query_limited_card += 1
			else
				#@query_scale_card += 1
				$temp_file.puts "CARD: query #{n.getIndex} has scale cardinality  #{n.getInstr.getAssociationType} #{n.getInstr.getFuncname}"
			end	
		end
	end
end

def print_query_card_stat
	$graph_file.puts("<queryCardStats>")
	@query_limited_card = 0
	@query_scale_card = 0
	@scale_in_loop = 0
	@limited_in_loop = 0
	$node_list.each do |n|
		if n.isReadQuery?
			if n.card_limited
				@query_limited_card += 1
				if n.getNonViewClosureStack.length > 0
					@limited_in_loop += 1
				end
			else
				@query_scale_card += 1
				if n.getNonViewClosureStack.length > 0
					@scale_in_loop += 1
				end
			end
		end
	end
	$graph_file.puts("\t<limitedCard in_loop=\"#{@limited_in_loop}\">#{@query_limited_card}<\/limitedCard>")
	$graph_file.puts("\t<scaleCard in_loop=\"#{@scale_in_loop}\">#{@query_scale_card}<\/scaleCard>")
	$graph_file.puts("<\/queryCardStats>")
end
