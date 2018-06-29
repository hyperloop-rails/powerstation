def compute_inefficient_partial(file)

	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	puts "compute_inefficient_partial"
	
	view_helpers = ['content_tag', 'form_tag', 'link_to', 'auto_discovery_link_tag', 'javascript_include_tag', 'stylesheet_link_tag', 'image_tag', 'video_tag', 'audio_tag']

	@closures = Array.new
	@query_loops = Array.new
	$node_list.each do |n|
			if n.getInClosure
				if n.getNonViewClosureStack.length > 0
						@closures |= n.getNonViewClosureStack
				end
			end
	end
	results = []
	@closures.each do |cl|
		@cl_nodes = Array.new
		if !cl.getInstr.getClosure
			next
		end
		begin
			puts "ppppp #{cl.getInstr.toString}"	
			parent_instr = cl.getInstr#.getINode.getInstr
			puts "#{parent_instr.getCallHandler}"
			nt = false
			if (parent_instr.instance_of?Call_instr and parent_instr.getFuncname == 'each' )
				traceback_data_dep(parent_instr.getINode).each do |dp|
					if dp.isQuery?
						nt = true
						break
					end
				end
				
			end
			if !nt
				puts "jump out inefficent partial"
				next
			end
		rescue
			puts "rescue from"
		end
		#puts "The #{@closures.index(cl)} th CL"
		# Add realted nodes to the closure
		$node_list.each do |n| 
			if n.getInClosure and n.getNonViewClosureStack.include?cl
				@cl_nodes.push(n)
			end
		end
		@cl_nodes.each do |cn|
			if cn.getInstr.instance_of?Call_instr 
				funcname = cn.getInstr.getFuncname
				puts "funcname #{funcname}; caller: #{cn.getInstr.getCaller} #{cn.getInstr.toString} #{cn.cur_class}"
				if view_helpers.include?funcname
					if !results.include?cn
						if $inefficient_renders.include?([cn, cl])
							next
						end
						$inefficient_renders.push([cn, cl])
						results.push([cn, cl])
						begin
							vt = cl.getInstr.getClosure.getVarMap
							vt.each do |k, v|
								puts "CNCL VAR: #{k} #{v}"
							end
						rescue
							puts "rescue cncl"
						end
					end
				end
			end
		end
	end

	results.each do |re, cl|
		r = getInstrLN(re.getInstr)
		args = re.getInstr.getArgs.select{|e| !e.start_with?'%' and e != 'Symbol'}.join(',')
		puts "RS1"
		rs = getInstrLN(cl.getInstr.getClosure.parent_instr)
		puts "RS2"
		if r and rs and r[0] != -1 and rs[0] != -1
			file.puts "<inefficientRender>"
			file.puts "<start>#{rs[1]}</start>"
			file.puts "<startFilename>#{rs[0]}</startFilename>"
			file.puts "<statement>#{r[1]}</statement>"
			file.puts "<filename>#{r[0]}</filename>"	 
			file.puts "<expr>#{re.getInstr.getFuncname}</expr>"
			file.puts "<args>#{args}</args>"	
			file.puts "</inefficientRender>"
		end
	end
	puts "FINISH"
	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end


