def compute_redundant_table_access
	#TODO: OK this is not the right way to do this... Now I am counting at the table level, it may underestimate the redundant access
	@table_includes = Hash.new
	@table_field_usage = Hash.new
	$node_list.each do |n|
		if n.isReadQuery?
			assoc = n.getInstr.getAssociationType
			if assoc != nil
				#mainly solve upper class problem
				base_table = get_table_name_from_class_name(n.getInstr.getCallerType)
				assoc_table = n.getInstr.getTableName
				#puts "---- get assoc: #{n.getIndex}:#{n.getInstr.toString}  (#{base_table}.#{assoc_table})"
				@table_field_usage[base_table] = Array.new unless @table_field_usage.has_key?base_table
				@table_field_usage[base_table].push(assoc_table)
			end
			if n.getInstr.getFuncname == "includes"
				base_table = n.getInstr.getCallerType
				assoc_symbol = Array.new
				if n.getInstr.symbols.length > 0
					n.getInstr.symbols.each do |s|
						assoc_symbol.push(s)
					end
				end
				n.getBackwardEdges.each do |e|
					if e.getFromNode.getInstr.instance_of?HashField_instr
						assoc_symbol.push(e.getFromNode.getInstr.hash_fields[0])
					end
				end
				assoc_symbol.each do |s|
					#get table name from symbol
					assoc_table = searchTableName(s)
					if assoc_table == nil
						attrib_class = $class_map[n.getInstr.getCallerType].searchAssocForClass(s)
						if attrib_class
							assoc_table = attrib_class
						end
					end
					if assoc_table
						#puts "FIND ASSOC TABLE: #{n.getIndex}:#{n.getInstr.getCallerType}.#{n.getInstr.getFuncname} table = #{assoc_table}"
						base_table = get_table_name_from_class_name(base_table)
						@table_includes[base_table] = Array.new unless @table_includes.has_key?base_table
						@table_includes[base_table].push(assoc_table)
					else
						puts "CANNOT find assoc table: #{n.getIndex}:#{n.getInstr.toString} (#{base_table}, #{s})"
					end
				end
			end
		end	
	end

	$graph_file.puts "<redundantTable>"	
	@table_includes.each do |t, v|
		v.each do |inc|
			if @table_field_usage.has_key?(t) and @table_field_usage[t].include?(inc)
				$graph_file.puts "\t<used base=\"#{t}\">#{inc}<\/used>"
			else
				puts "---Non used included tables: #{t}.#{inc}"
				$graph_file.puts "\t<notused base=\"#{t}\">#{inc}<\/notused>"
			end
		end
	end	
	$graph_file.puts "<\/redundantTable>"
end
