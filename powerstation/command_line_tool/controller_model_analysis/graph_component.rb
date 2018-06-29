
class INode
	def initialize(instr)
		if instr != nil
			instr.setINode(self)
		end
 		@instr = instr
		@dump_helper = nil
		@children = Array.new
		@index = $ins_cnt
		@label = ""
		@in_closure = false
		@in_view = $in_view	
		@in_loop = ($in_loop.length > 0)
		@in_validation = ($in_validation.length > 0)	
		@closure_stack = Array.new
		@show_stack = Array.new
		@call_stack = Array.new
		@validation_stack = Array.new
		@dataflow_edges = Array.new
		@controlflow_edges = Array.new
		@backward_dataflow_edges = Array.new
		@backward_controlflow_edges = Array.new
		@longest_control_path_nextnode = nil
		@shortest_control_path_nextnode = nil
		@path_length = -1
		@card_limited = false
		@shortest_path_length = -1
		@Tnode = nil
		@source_list = Array.new
		@sink_list = Array.new
		r = Random.new
		@rnd = r.rand(1...1024)
		@cur_class = $cur_class #This is for dynamic typing
		if $closure_stack.length > 0
			@in_closure = true
			$closure_stack.each do |cl|
				@closure_stack.push(cl)
			end
		end
		$show_stack.each do |s|
			@show_stack.push(s)
		end
		$funccall_stack.each do |f|
			@call_stack.push(f)
		end
		$in_validation.each do |v|
			@validation_stack.push(v)
		end

		#add defSelf:
		$in_validation.each do |v|
			if instr and instr.getDefv and instr.getDefv.include?("self") and defself_not_receivearg(instr) #TODO: This is messy. The first instruction for any function or clousre is building stack and def self 
				if type_valid(instr, instr.getDefv) == v.getInstr.getCallerType	
					$def_self_nodes[v].push(self)
				end
			elsif instr and instr.instance_of?AttrAssign_instr
				if instr.getCallerType == v.getInstr.getCallerType
					$def_self_nodes[v].push(self)
				end
			end
		end
	end
	attr_accessor :index, :Tnode, :source_list, :sink_list
	attr_accessor :longest_control_path_nextnode, :shortest_control_path_nextnode, :path_length, :shortest_path_length
	attr_accessor :cur_class
	attr_accessor :card_limited
	attr_accessor :dump_helper
	def setCardLimited
		@card_limited = true
	end
	def getClosureStack
		@closure_stack
	end
	def getShowStack
		@show_stack
	end
	def getViewShowClosure
		@show_stack.each do |c|
			if c.getInstr.is_a?Call_instr
			return true unless ["ruby_code_from_view","transaction"].include?c.getInstr.getFuncname
			end
		end
		return false
	end
	def getNonViewClosureStack
		@new_stack = Array.new
		@closure_stack.each do |c|
			if isNonClosureInstr(c.getInstr)	 
			else
				@new_stack.push(c)
			end 
		end	
		return @new_stack
	end
	def getCallStack
		@call_stack
	end
	def getValidationStack
		@validation_stack
	end
	def getInView
		@in_view
	end
	def getInLoop
		@in_loop
	end
	def getInValidation
		@in_validation
	end
	def addDataflowEdge(edge)
		@dataflow_edges.each do |e|
			if e.getToNode == edge.getToNode
				return
			end
		end
		@dataflow_edges.push(edge)
		edge.getToNode.addBackwardEdge(edge)
	end
	def addBackwardEdge(edge)
		@backward_dataflow_edges.push(edge)
	end
	def getBackwardEdges
		@backward_dataflow_edges
	end
	def getDataflowEdges
		@dataflow_edges
	end
	def addBackwardControlEdge(edge)
		@backward_controlflow_edges.push(edge)
	end
	def addControlflowEdge(edge)
		@controlflow_edges.push(edge)
		edge.getToNode.addBackwardControlEdge(edge)
	end
	def getControlflowEdges
		@controlflow_edges
	end
	def getBackwardControlEdges
		@backward_controlflow_edges
	end
	def getInClosure
		@in_closure
	end
	def isQuery?
		#if @instr and @instr.is_a?Call_instr
		return @instr.isQuery
		#end
		#return false
	end
	def isChainedQuery?
		if @instr.isQuery
			self.getDataflowEdges.each do |e|
				if e.getToNode.isReadQuery? and self.getDataflowEdges.length == 1 and e.getToNode.getInstr.getTableName == @instr.getTableName
					return true
				end
			end
		end
		return false
	end
	def instr_is_readQuery
		if @instr != nil and @instr.instance_of?Call_instr
			return @instr.isReadQuery
		end
		return false
	end
	def isReadQuery?
		#self.getDataflowEdges.each do |e|
		#	if e.getToNode.instr_is_readQuery and self.getDataflowEdges.length == 1
		#		return false
		#	end
		#end
		if @instr != nil and @instr.is_a?Call_instr
			return @instr.isReadQuery
		end
		return false
	end
	def isWriteQuery?
		return (isQuery? and (!isReadQuery?))
	end
	def isTableField?
		if @instr != nil and (@instr.is_a?Call_instr)
			return @instr.isTableField
		end
		return false
	end
	def isClassField?
		if @instr != nil and (@instr.is_a?Call_instr)
			return @instr.isClassField
		end
		return false
	end

	def isBranch?
		if @instr != nil and @instr.instance_of?Branch_instr
			return true
		end
		return false
	end
	def setLabel
		#if isQuery?
			#if @instr.getResolvedCaller.length > 0
			#	@label = "#{@instr.getResolvedCaller}.#{@instr.getFuncname}"
			#else
			#	@label = "#{@instr.getCaller}.#{@instr.getFuncname}"
			#end
		#elsif @instr.instance_of?Call_instr
		#	@label = "#{@instr.getCaller}.#{@instr.getFuncname}"
		#end

		if @instr.is_a?Call_instr 
			t = type_valid(@instr, @instr.getCaller)
			if t != nil
				@label = "#{t}.#{@instr.getFuncname}"
			else
				@label = "Unknown.#{@instr.getFuncname}"
			end
		end
	end
	def getLabel
		@label
	end
	def getSimplifiedLabel
		if isQuery?
			if @instr.getResolvedCaller.length > 0
				return "#{@instr.getResolvedCaller}.#{@instr.getFuncname.delete('!').delete('?')}"
			else
				return "#{@rnd}.#{@instr.getFuncname.delete('!').delete('?')}"
			end
		else
			return ""
		end
	end
	def getInstr
		@instr
	end
	def getIndex
		@index
	end
						#puts "Add return instr: #{callerv_name}.#{call.getFuncName} #{rt.getIndex} -> #{temp_node.getIndex}"
	def addChild(c)
		@children.push(c)
	end
	def getChildren
		@children
	end
end


$dataflow_source = INode.new(nil)

#format: from_inode_index*to_inode_index
class Dataflow_edge
	def initialize(fromn, ton, vname, isBranching=false)
		@from_node = fromn
		@to_node = ton
		@vname = vname
		@is_branching = isBranching
	end
	def getIsBranching
		@is_branching
	end
	def getFromNode
		@from_node
	end
	def getToNode
		@to_node
	end
	def getVname
		@vname
	end
end

class Controlflow_edge
	def initialize(fromn, ton)
		@from_node = fromn
		@to_node = ton
	end
	def getFromNode
		@from_node
	end
	def getToNode
		@to_node
	end
end

def handle_get_field_instr(node)
	to_ins = node.getInstr
	dep_on_attr_assign = false
	attr_assign_instr = nil
	to_ins.getDeps.each do |dep|
		if dep.getInstrHandler and dep.getInstrHandler.instance_of?AttrAssign_instr and dep.getInstrHandler.getFuncname == to_ins.getFuncname
			dep_on_attr_assign = true
			attr_assign_instr = dep.getInstrHandler
		end
	end
	
	#puts "GET FIELD instr #{node.getIndex}, dep_on_attr_assign = #{dep_on_attr_assign} #{to_ins.getClassName} #{to_ins.getCallerType}"
	#if dep_on_attr_assign == false
		instr = to_ins
		if instr.getClassName == instr.getCallerType and $class_map[instr.getClassName] and $class_map[instr.getClassName].member_defs[instr.getFuncname]
			$class_map[instr.getClassName].member_defs[instr.getFuncname].each do |p|
				edge_name = "#{p.getIndex}*#{node.getIndex}"
				#puts "ADD EDGE between #{p.getIndex} and #{node.getIndex} on #{instr.getFuncname}"
				edge = Dataflow_edge.new(p, node, instr.getFuncname)
				p.addDataflowEdge(edge)
			end
		end
	#else
		#puts "\tattr assign: #{attr_assign_instr.getINode.getIndex}"
	#end
end

def add_dataflow_edge(node)
	to_ins = node.getInstr
	if to_ins.getFromUserInput
		edge_name = "user_input*#{node.getIndex}"
		edge = Dataflow_edge.new(nil, node, "param")
		$dataflow_source.addDataflowEdge(edge)	
		if $dataflow_edges[edge_name] == nil
			$dataflow_edges[edge_name] = Array.new
		end
		$dataflow_edges[edge_name].push(edge)
		return
	end
	
	to_ins.getDeps.each do |dep|
		if dep.getInstrHandler == nil
			puts "Handler nil: BB#{dep.getBlock}.#{dep.getInstr}"
		end
		#TODO: getINode == nil, if this instr hasn't been handled yet...
		if dep.getInstrHandler.getINode != nil
			#XXX: If it is a field instr, then we know it is not a blackbox func call, if it is not attrassign, then it is a read only instr
			from_node = dep.getInstrHandler.getINode
			if from_node.getInstr.hasClosure?
				from_node.getInstr.getClosure.getClosureDefs(dep.getVname).each do |t|
					actual_from_ins = t.getInstrHandler
					if actual_from_ins != node.getInstr	
						edge_name = "#{actual_from_ins.getINode.getIndex}*#{node.getIndex}"
						edge = Dataflow_edge.new(actual_from_ins.getINode, node, dep.getVname)
						actual_from_ins.getINode.addDataflowEdge(edge)
					end
				end
			end
			#if (from_node.isClassField?) and (dep.getVname == "%self")
			#puts "FROMTO****:\n\tFrom: #{from_node.getInstr.toString}\n\tTo: #{to_ins.toString}\n"

			if (dep.getVname == "%self") and (dep.getBlock == 2) and (dep.getInstr == 0) and from_node.getInstr.getClassName.include?'Controller'
				#puts 1
			elsif to_ins.is_a?Call_instr and from_node.getInstr.is_a?Call_instr and (!from_node.isQuery?) and to_ins.getCaller == from_node.getInstr.getCaller and to_ins.getCaller != "%self"
				#puts 2
				#puts "\t#{from_node.getInstr.isQuery}"
			elsif to_ins.is_a?Call_instr and from_node.getInstr.instance_of?AttrAssign_instr and to_ins.getCallerType == from_node.getInstr.getCallerType and to_ins.getFuncname != from_node.getInstr.getFuncname #and to_ins.isClassField
				#puts 3
			elsif to_ins.is_a?GetField_instr and from_node.getInstr.hasClosure?
				#puts 4
			elsif to_ins.instance_of?Return_instr and dep.getVname == "%self"
			#elsif to_ins.instance_of?GetField_instr and to_ins.getClassName.include?("Controller") and dep.getVname == "%self"

			#TODO: OK Here it is messy. Assume the functions in view does not define "self"
			#elsif from_node.getInstr.getClassName.include?"Controller" and from_node.getInstr.instance_of?Call_instr and  from_node.getInView and dep.getVname == "%self"
			#TODO: Here we assume all non-defined functions in view are read only...
				#puts 5
			elsif from_node.getInstr.instance_of?Call_instr and from_node.getInstr.in_view and from_node.isQuery? == false and from_node.getInstr.getFromUserInput==false and (from_node.getInstr.getCallCFG==nil or function_defself(from_node.getInstr.getCallCFG.getMHandler)==false)
				#puts 6
			elsif from_node.getInstr.instance_of?Call_instr and (from_node.getInstr.getCallerType == nil or from_node.getInstr.getCallerType.include?("Controller")) and to_ins.instance_of?GetField_instr and from_node.getInstr.getCallCFG==nil and dep.getVname == "%self" 
				#puts 7
			elsif dep.getInstrHandler != node.getInstr
				edge_name = "#{dep.getInstrHandler.getINode.getIndex}*#{node.getIndex}"
				edge = Dataflow_edge.new(dep.getInstrHandler.getINode, node, dep.getVname)
				dep.getInstrHandler.getINode.addDataflowEdge(edge)
				if $dataflow_edges[edge_name]
				else
					$dataflow_edges[edge_name] = Array.new
				end
				$dataflow_edges[edge_name].push(edge)
			end
		end
	end
end

def addAllControlEdges
	for i in 1...$node_list.length
		pren = $node_list[i-1]
		curn = $node_list[i]
		if pren.getInstr and curn.getInstr
			if pren.getInstr.getBB == curn.getInstr.getBB
				edge = Controlflow_edge.new(pren, curn)
				pren.addControlflowEdge(edge)
			#last instr in BB
			elsif pren.getInstr != nil and pren.getInstr == pren.getInstr.getBB.getInstr[-1]
				#Since for each CFG, there is always a control flow edge from the first BB to last BB, 
				#I want to remove this edge.
				tmp_cnt = 0
				#If there is only one BB, then it is not from the dataflow log
				cond = (pren.getInstr.getBB.getCFG.getBB.length > 1 and pren.getInstr.getBB.getIndex == 1)
				pren.getInstr.getBB.getOutgoings.each do |o|
					if cond and tmp_cnt == 0
					else
						o_bb = pren.getInstr.getBB.getCFG.getBBByIndex(o)
						next_nodes = o_bb.getInstr[0].getINodes
						next_node = o_bb.getInstr[0].getINode
						if next_nodes.length > 1
							next_nodes.each do |nn|
								if nn.getIndex > pren.getIndex
									next_node = nn
									break
								end
							end
						end
						edge = Controlflow_edge.new(pren, next_node)
						pren.addControlflowEdge(edge)
					end
					tmp_cnt += 1
				end
				if pren.getControlflowEdges.length == 0
					edge = Controlflow_edge.new(pren, curn)
					pren.addControlflowEdge(edge)
				end
			#elsif pren.getInstr.instance_of?Call_instr
			else
				edge = Controlflow_edge.new(pren, curn)
				pren.addControlflowEdge(edge)
			end
		end
	end

	$node_list.reverse.each do |n|
		if n.getControlflowEdges.length == 0
			n.path_length = 0	
		else
			@longest_length = -1
			n_node = nil
			n.getControlflowEdges.each do |e|
				if @longest_length < e.getToNode.path_length
					@longest_length = e.getToNode.path_length
					n_node = e.getToNode
				end
			end
			if @longest_length > -1
				n.longest_control_path_nextnode = n_node
				n.path_length = @longest_length + 1
			end
		end
	end

	$node_list.reverse.each do |n|
		if n.getControlflowEdges.length == 0
			n.shortest_path_length = 0	
		else
			@shortest_length = $node_list.length
			n_node = nil
			n.getControlflowEdges.each do |e|
				if @shortest_length > e.getToNode.shortest_path_length and e.getToNode.shortest_path_length != -1
					@shortest_length = e.getToNode.shortest_path_length
					n_node = e.getToNode
				end
			end
			if @shortest_length < $node_list.length and n_node != nil
				n.shortest_control_path_nextnode = n_node
				n.shortest_path_length = @shortest_length + 1
			end
		end
	end

end

#prenode should be a branch!
def is_in_controlflow_range(after_node, pre_node)
	if pre_node.getInstr.instance_of?Branch_instr
		if pre_node.getInstr.merge_instr
			if after_node.getIndex <= pre_node.getInstr.merge_instr.getINode.getIndex
				return true
			end
		end
	end
	return false
end

def is_controlflow_reachable(after_node, pre_node)
	@visited_list = Array.new
	@visited_list.push(pre_node)
	@queue = Array.new
	@queue.push(pre_node)
	while @queue.length > 0
		temp_node = @queue.pop
		if temp_node.getIndex <= after_node.getIndex
			temp_node.getControlflowEdges.each do |e|
				if e.getFromNode.getIndex == after_node.getIndex
					return true
				end
				if @visited_list.include?e.getToNode
				else
					@visited_list.push(e.getToNode)
					@queue.push(e.getToNode)
				end
			end
		end
	end
	return false
end

def compute_longest_single_path
	temp_node = $node_list[0]
	p_length = 0
	query_num = 0
	read_query = 0
	#$node_list.each do |n|
	#	puts "#{n.getIndex}: #{n.getInstr.toString}"
	#	n.getControlflowEdges.each do |e|
	#		puts "\t -> #{e.getToNode.getIndex}"
	#		if e.getToNode == n.shortest_control_path_nextnode
	#			puts "\t\t(shortest path: #{n.shortest_path_length})"
	#		end
	#		if e.getToNode == n.longest_control_path_nextnode
	#			puts "\t\t(longest path: #{n.path_length})"
	#		end
	#	end
	#end
	while temp_node and temp_node.getControlflowEdges.length > 0
		p_length += 1
		if temp_node.isQuery?
			query_num += 1
			if temp_node.isReadQuery?
				read_query += 1
			end
		end
		#puts "Longest path #{p_length}: #{temp_node.getIndex}: #{temp_node.getInstr.toString}"
		temp_node = temp_node.longest_control_path_nextnode
	end

	min_query_num = 0
	min_read_query = 0
	min_p_length = 0
	temp_node = $node_list[0]
	while temp_node and temp_node.getControlflowEdges.length > 0
		min_p_length += 1
		if temp_node.isQuery?
			min_query_num += 1
			if temp_node.isReadQuery?
				min_read_query += 1
			end
		end
		#puts "Longest path #{p_length}: #{temp_node.getIndex}: #{temp_node.getInstr.toString}"
		temp_node = temp_node.shortest_control_path_nextnode
	end

	$graph_file.puts("\t<total>")
	$graph_file.puts("\t\t<max>#{query_num}<\/max>")
	$graph_file.puts("\t\t<min>#{min_query_num}<\/min>")
	$graph_file.puts("\t<\/total>")
	$graph_file.puts("\t<read>")
	$graph_file.puts("\t\t<max>#{read_query}<\/max>")
	$graph_file.puts("\t\t<min>#{min_read_query}<\/min>")
	$graph_file.puts("\t<\/read>")
	$graph_file.puts("\t<write>")
	$graph_file.puts("\t\t<max>#{query_num-read_query}<\/max>")
	$graph_file.puts("\t\t<min>#{min_query_num-min_read_query}<\/min>")
	$graph_file.puts("\t<\/write>")
  $graph_file.puts("\t<shortestPath>#{min_p_length}<\/shortestPath>")
	$graph_file.puts("\t<longestPath>#{p_length}<\/longestPath>")
	$graph_file.puts("\t<instrTotal>#{$node_list.length}<\/instrTotal>")
	#puts "PATH length: ##{p_length} (qnum: #{query_num}) Vs #{$node_list.length}"

end
