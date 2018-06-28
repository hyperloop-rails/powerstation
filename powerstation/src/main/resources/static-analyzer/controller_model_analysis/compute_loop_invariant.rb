def compute_loop_invariant(file)

	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	puts "~~~~~~~~~~~~~Handling loop invariant~~~~~~~~~~~~~~~~~"


	@closures = Array.new
	@query_loops = Array.new
	$node_list.each do |n|
		if !n.instance_of?Dataflow_edge 
			#puts "N is: #{n.getInstr.toString}"
		end

		if n.isReadQuery?
			puts "n isReadQuery "
			puts "closure size is: #{n.getClosureStack.length}"
			if n.getInClosure
				puts "getInClosure length is : #{n.getClosureStack.length}"
				if n.getNonViewClosureStack.length > 0

						puts "getNonViewClosureStack length is : #{n.getNonViewClosureStack.length}"
						@closures |= n.getNonViewClosureStack
				end
			end
		end
		# "query loop"
		#if n.getInstr.instance_of?Copy_instr and /IN.*\(SELECT/.match(n.getInstr.const_string)
		#	@query_loops.push(n.getInstr) unless @query_loops.include?(n.getInstr)
		#end 
	end
	@results = Array.new
	@instr_rd = {}
	@closures.each do |cl|
		    puts "PARENT_INSR"
		    is_csv = false	
		    begin
			    puts cl.getInstr.getClosure.parent_instr.toString
				parent_instr = cl.getInstr.getClosure.parent_instr.getINode
				puts "PARENT_INSR #{parent_instr.getInstr.toString}"
				if !(parent_instr.getInstr.instance_of?Call_instr and parent_instr.getInstr.getFuncname == 'each')
					puts "jump out "
					next
				end
				puts "get into the parent_instr's dependency"
                puts traceback_data_dep(parent_instr).length
				traceback_data_dep(parent_instr).each do |dp|
					if dp.getInstr.toString == '(CSV)'
						puts "csv"
						is_csv = true
						next
					end
				end
            rescue
			end
			if is_csv
				next
			end
			@cl_nodes = Array.new
			if !cl.getInstr.getClosure
				next
			end
			#puts "The #{@closures.index(cl)} th CL"
			# Add realted nodes to the closure
			$node_list.each do |n| 
				if n.getInClosure and n.getNonViewClosureStack.include?cl
					@cl_nodes.push(n)
				end
			end
			# this way is not right, since we might not consider the node in the call graph of the instructions in the closure
			# cl.getInstr.getClosure.getBB.each do |bb|
			# 	bb.getInstr.each do |i|
			# 		#@cl_nodes.push(i.getINode)
			# 	end
			# end
			@loop_inv = Array.new

			
			
			write_tables = []
			@cl_nodes.each do |cl_n|
				if cl_n.isWriteQuery?
					write_table = cl_n.getInstr.getTableName
					write_tables.push(write_table) unless write_tables.include?(write_table)
				end
			end
			#puts "clnodes size is #{@cl_nodes.length}"
			while(true)
				start = @loop_inv.dup
				@cl_nodes.each do |cl_n|
					# if the variable is def self, it can be added to the loop variant
					if cl_n.getInstr.getDefv and cl_n.getInstr.getDefv.include?("self")
						@loop_inv.push(cl_n) unless @loop_inv.include?(cl_n)
						#puts "self #{cl_n.getInstr.getDefv}"
						traceforward_data_dep(cl_n).each do |dc|
							#puts "TC #{dc.getInstr.toString}"
						end
					# if the variable is not self, but its data dependency are all out of the closure
				    elsif cl_n.getInstr.getDefv and ((traceback_data_dep(cl_n) - @loop_inv) & @cl_nodes).empty? #and !traceback_data_dep(cl_n).empty?
				    	# ReceiveArg_instr is the loop condition
				    	if cl_n.getInstr.instance_of?ReceiveArg_instr
				    		next
				    	end
				    	# if a function is random then it's not loop invariant
				    	if cl_n.getInstr.instance_of?Call_instr and cl_n.getInstr.getFuncname.include?("random")
				    		next
				    	end
				    	isLambda = false
				    	 
				    	# To check whether the loop is inside a lambda loop
				    	traceback_data_dep(cl_n).each do |dc|
							#puts "tc #{dc.getInstr.toString}"

							if !dc.instance_of?Dataflow_edge and dc.getInstr.instance_of?Call_instr 
								fname = dc.getInstr.getFuncname
								if fname == 'lambda' or fname == 'cache_if'  or fname == 'cache'
									#puts "fname : #{fname}"
									isLambda = true
									break
								end
							end
						end
						if isLambda 
							next
						end
						if !(cl_n.isReadQuery? and write_tables.include?(cl_n.getInstr.getTableName))					
							@loop_inv.push(cl_n) unless @loop_inv.include?(cl_n)
							puts "no dep #{cl_n.getInstr.toString} #{cl_n.isQuery?} Handler: #{cl_n.getInstr.getCallCFG}" if cl_n.getInstr.instance_of?Call_instr
						end
				    end
				end
				if start == @loop_inv
					break
				end
			end

			#puts "After popping loop_inv size is #{@loop_inv.length}"
			@loop_inv.each do |li|
				#puts li.getInstr.toString
				if li.isReadQuery? 
					next if li.getInstr.getCaller == '%self'
					if (@results.include?([li,cl]) || @results.map { |e| e.first }.include?(li))
						next
					else
					
						if $loop_invariants.include?([li, cl]) or is_chained_query(li)
							next
						end
						$loop_invariants.push([li,cl])  
						@results.push([li,cl]) 
					end
				end
			end

	end

	puts "The number of loop in query is : #{@results.length}" if @results.length > 0
	result_group_cl = @results.group_by{|re| re[1]}
	cnt = 1
	result_group_cl.each do |cl, res|
		res.each do |re|
			puts "#{cnt} query" 
			cnt += 1
			instr = re[0].getInstr
			#puts "parent #{cl.getInstr.getClosure.parent_instr.getLN}"
			#cl.getInstr.getClosure.self_print
			#puts "#{instr.toString} #{instr.getLN} "
			instr_start = cl.getInstr.getClosure.parent_instr
			r = getInstrLN(instr)
			rs = getInstrLN(instr_start)
			if r and rs
				file.puts "<loopInvariant>"
				file.puts "<start>#{rs[1]}</start>"
				file.puts "<startFilename>#{rs[0]}</startFilename>"
				file.puts "<statement>#{r[1]}</statement>"
				file.puts "<filename>#{r[0]}</filename>"	
				file.puts "</loopInvariant>"
			end
		end
		#cl.getInstr.getClosure.self_print
	end
	@query_loops.each do |ql|
	#	puts ql.getInstr.toString
	end

	puts "~~~~~~~~~~~~~Finish handling loop invariant~~~~~~~~~~~"
	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	puts "APP #{$app_dir}"
end


