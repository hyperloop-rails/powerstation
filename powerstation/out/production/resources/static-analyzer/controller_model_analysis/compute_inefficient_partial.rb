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
						#$inefficient_renders.push(cn)
						results.push(cn)
					end
				end
			end
		end
	end

	results.each do |re|
		r = getInstrLN(re.getInstr)
		file.puts "<inefficientRender>"
		file.puts "<statement>"
		file.puts "#{r[1]}"
		file.puts "</statement>"
		file.puts "<filename>"
		file.puts "#{r[0]}"
		file.puts "</filename>"	 
		file.puts "<expr>#{re.getInstr.getFuncname}</expr>"	
		file.puts "</inefficientRender>"
	end
	puts "FINISH"
	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end


