def add_to_table_select_fields(qnode, class_name, field_name)
	if $table_select_fields[class_name]
	else
		$table_select_fields[class_name] = Hash.new
	end
	if $table_select_fields[class_name].has_key?(field_name)
	else
		$table_select_fields[class_name][field_name] = 0
	end
	$table_select_fields[class_name][field_name] += 1
	add_select_field_to_chained_query(qnode, field_name)	
end

def add_to_order_fields(qnode, class_name, field_name)
	#puts "FIND ORDER: #{qnode.getIndex}:#{qnode.getInstr.toString} (order = #{field_name})"
	add_order_to_chained_query(qnode, class_name, field_name)
	if $order_fields[class_name]
	else
		$order_fields[class_name] = Hash.new
	end
	if $order_fields[class_name].has_key?(field_name)
	else
		$order_fields[class_name][field_name] = 0
	end
	$order_fields[class_name][field_name] += 1
end


def trace_query_select_condition(qnode)
	#find_by
	if qnode.getInstr.getFuncname.include?("find_by")
		fname = qnode.getInstr.getFuncname.tr("find_by_","")
		if testTableField(qnode.getInstr.getTableName, fname)
			add_to_table_select_fields(qnode, qnode.getInstr.getTableName, fname)
			#puts "ADD select by find_by: #{qnode.getIndex}: #{qnode.getInstr.getTableName}.#{fname}"
		end
	end
	#select condition: hash
	qnode.getBackwardEdges.each do |e|
		if e.getFromNode.getInstr.instance_of?HashField_instr
			e.getToNode.getInstr.hash_fields.each do |h|
				if testTableField(qnode.getInstr.getTableName, h)
					add_to_table_select_fields(qnode, qnode.getInstr.getTableName, h)
					#puts "ADD select by hash: #{qnode.getIndex}: #{qnode.getInstr.getTableName}.#{h}"
					if qnode.getInstr.getFuncname == "order"
						add_to_order_fields(qnode, qnode.getInstr.getTableName, h)
					end
				end	
			end	
		end
	end	
	#select condition: symbol
	qnode.getInstr.symbols.each do |s|
		if testTableField(qnode.getInstr.getTableName, s)
			add_to_table_select_fields(qnode, qnode.getInstr.getTableName, s)
			#puts "ADD select by symbol: #{qnode.getIndex}: #{qnode.getInstr.getTableName}.#{s}"
			if qnode.getInstr.getFuncname == "order"
				add_to_order_fields(qnode, qnode.getInstr.getTableName, s)
			end
		end
	end
	#select condition: const string
	qnode.getBackwardEdges.each do |e|
		if e.getFromNode.getInstr.instance_of?Copy_instr
			str = e.getFromNode.getInstr.const_string
			if str
				chs = str.split(" ")
				chs.each do |c|
					if testTableField(qnode.getInstr.getTableName, c)
						add_to_table_select_fields(qnode, qnode.getInstr.getTableName, c)
						if qnode.getInstr.getFuncname == "order"
							add_to_order_fields(qnode, qnode.getInstr.getTableName, c)
						end
					elsif c.split(".")[1] and testTableField(qnode.getInstr.getTableName, c.split(".")[1])
						if qnode.getInstr.getFuncname == "order"
							add_to_order_fields(qnode, qnode.getInstr.getTableName, c.split(".")[1])
						end
					end
				end
			end
		end
	end
end

def compute_select_condition
	$graph_file.puts "<selectCondition>"
	$node_list.each do |n|
		if n.isReadQuery?
			trace_query_select_condition(n)
		end
	end

	$table_select_fields.each do |k,v|
		#k: class_name
		v.each do |vk, vv|
			#vk: field_name
			$graph_file.puts "\t<#{k} field=\"#{vk}\" has_index=\"#{testTableIndex(k, vk)}\">#{vv}<\/#{k}>"	
		end
	end

	$graph_file.puts "<\/selectCondition>"
end

def compute_query_chain
	$node_list.each do |n|
		if n.isReadQuery?
			compute_query_chain_for_single_node(n)
		end
	end
	$query_chain.each do |k,v|
		str = ""
		v.qnodes.each do |q|
			str += "#{q.getIndex}, "
		end
		$temp_file.puts "QUERY CHAIN: #{str}"
	end
end

def compute_field_order_stat
	puts "Compute_field_order: qchain size = #{$query_chain.length}"
	@all_fields = Hash.new
	#TODO: This is so messy....but i don't store table ref in Tabel_field class
	@field_table_search = Hash.new
	$query_chain.each do |k, v|
		puts "#{k.getIndex}:#{k.getInstr.toString}"
		v.used_fields.each do |v1|
			chs = v1.split(".")
			f = testTableField(chs[0], chs[1])
			if f
				@all_fields[f] = Array.new unless @all_fields.has_key?(f)
				@field_table_search[f] = chs[0]
				v.order.each do |o|
					@all_fields[f].append(o) unless @all_fields[f].include?(o)
				end
			end
		end
	end
	$graph_file.puts "<fieldOrder>"
	@all_fields.each do |k, v|
		sz = get_field_size(k)
		tbl = @field_table_search[k]
		ordern = v.length
		str = "Field (#{tbl}.#{k.field_name}, sz=#{sz}) has #{ordern} orders: ["
		v.each do |o|
			str += "#{o}, "
			$graph_file.puts "\t<f fieldn=\"#{tbl}.#{k.field_name}\" sz=\"#{sz}\">#{o}</f>"
		end
		str += "]"
		puts str
	end
	$graph_file.puts "<\/fieldOrder>"
end

#should be called after compute_select_condition, and compute_query_chain
def compute_order_stat 	
	$graph_file.puts "<orderCondition>"
	$order_fields.each do |k,v|
		v.each do |vk, vv|
			$graph_file.puts "\t<#{k} field=\"#{vk}\" type=\"#{}\">#{vv}<\/#{k}>"	
		end
	end
	$graph_file.puts "<\/orderCondition>"
	
	order_query = Array.new
	depend_on_ordered = Array.new
	$query_chain.each do |k,v|
		@order_q = nil
		v.qnodes.each do |q|
			if q.getInstr.getFuncname == "order"
				@order_q = q
			end
		end
		if @order_q
			if order_query.include?(@order_q)
			else
				order_query.push(@order_q)
			end
			v.qnodes.each do |q|
				if q.getIndex > @order_q.getIndex
					if depend_on_ordered.include?q
					else
						depend_on_ordered.push(q)
					end
				end
			end
		end
	end
	$graph_file.puts "<orderByStat>"
	$graph_file.puts "\t<orderQuery>#{order_query.length}<\/orderQuery>"
	$graph_file.puts "\t<queryOnOrderedResult>#{depend_on_ordered.length}<\/queryOnOrderedResult>"
	$graph_file.puts "<\/orderByStat>"
end
