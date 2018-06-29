def isAttrAssign(node)
	if node.getInstr.instance_of?AttrAssign_instr
		if node.getInstr.getFuncname.index('!') == nil
			return true
		end
	end
	return false  
end

def isTableAttrAssign(n)
	if n.getInstr.instance_of?AttrAssign_instr
		tbl_name = type_valid(n.getInstr, n.getInstr.getCaller)
		field_name = n.getInstr.getFuncname
		if tbl_name != nil
			if testTableField(tbl_name, field_name)
				return true
			end
		end
	end
	return false
end


#Dataflow trace rules: (starting_node)
#temp_node.getBackwardEdges.each do |e|
#		if e.getFromNode != nil and @proessed.include?(e.getFromNode) == false and e.getFromNode.getIndex < starting_node.getIndex
#			@temp_node_list.push(e.getFromNode)

#temp_node.getDataflowEdges.each do |e|
#		if @processed.include?(e.getToNode) == false
#			if e.getToNode.getInstr.instance_of?Return_instr
# 			tonode = e.getToNode.getDataflowEdges[0].getToNode
#				toNode.getDataflowEdges.each do |e1|
#					if @processed.include?e1.getToNode == false and e1.getToNode.getIndex > starting_node.getIndex
#						@temp_node_list.push(e1.getToNode)
#					end
#				end
#			elsif e.getToNode.getIndex > starting_node.getIndex
#				@temp_node_list.push(e.getToNode)
#			end
#		end


def traceback_data_dep(cur_node, stop_at_query=false)
	@dep_array = Array.new
	@node_list = Array.new
	@node_list.push(cur_node)
	while @node_list.length > 0 do
		node = @node_list.pop
		node.getBackwardEdges.each do |e|
			if e.getFromNode != nil and e.getToNode != nil
				if stop_at_query and e.getFromNode.isQuery? 
					return e.getFromNode
				end
				if stop_at_query and e.getFromNode.getInstr.is_a?Call_instr and e.getFromNode.getInstr.getFuncname == "current_user"
					return e.getFromNode
				end
				if e.getFromNode.isReadQuery?
					if @dep_array.include?(e.getFromNode)
					else
						@dep_array.push(e.getFromNode)
						# add this node to the node list
						@node_list.push(e.getFromNode)
					end
				else
					#if cur_node.getCallStack.include?(e.getToNode) and e.getVname == "returnv"
					if e.getFromNode.getInstr.instance_of?Return_instr and e.getFromNode.getInstr.getClassName == cur_node.getInstr.getClassName and e.getFromNode.getInstr.getMethodName == cur_node.getInstr.getMethodName
					elsif e.getFromNode.getIndex < cur_node.getIndex
					#else
						#test is both nodes are in the same basic block, prevent from tracing too far
						#if e.getFromNode.getInstr.getBB == node.getInstr.getBB
						if @dep_array.include?(e.getFromNode)
						else
							@dep_array.push(e.getFromNode)
							@node_list.push(e.getFromNode)
						end
					end
				end
			elsif e.getFromNode == nil and e.getToNode != nil
				#TODO: this is a bit annoying... if the type in @dep_array is Edge, then it is user input, otherwise other instruction nodes
				@dep_array.push(e)
			end
		end
	end
	if stop_at_query
		return nil
	else
		return @dep_array
	end
		@total = 0
end

def increase_dist(dist, node)
	#If it is a simple copy or assign func, then don't count as dist
	if node.getInstr.instance_of?Copy_instr or node.getInstr.instance_of?Return_instr or node.getInstr.is_a?ReceiveArg_instr
		return dist
	elsif node.getInstr.instance_of?GetField_instr #???
		return dist
	elsif node.getInstr.is_a?Call_instr and ["exists", "try"].include?node.getInstr.getFuncname.gsub('?','').gsub('!','')
		return dist 
	else
		return dist+1
	end
end

def traceback_data_dep_track_dist(cur_node)
	@node_list = Array.new
	@node_list.push(cur_node)
	@dist_hash = Hash.new
	@dist_hash[cur_node] = 0
	while @node_list.length > 0 do
		node = @node_list.pop
		node.getBackwardEdges.each do |e|
			if e.getFromNode != nil and e.getToNode != nil
				if e.getFromNode.isQuery?
					@dist_hash[e.getFromNode] = increase_dist(@dist_hash[node], node)
				else
					#if cur_node.getCallStack.include?(e.getToNode) and e.getVname == "returnv"
					if e.getFromNode.getInstr.instance_of?Return_instr and e.getFromNode.getInstr.getClassName == cur_node.getInstr.getClassName and e.getFromNode.getInstr.getMethodName == cur_node.getInstr.getMethodName
					elsif e.getFromNode.getIndex < cur_node.getIndex
						if @dist_hash.has_key?(e.getFromNode)
						else
							@dist_hash[e.getFromNode] = increase_dist(@dist_hash[node], node)
							@node_list.push(e.getFromNode)
						end
					end
				end
			elsif e.getFromNode == nil and e.getToNode != nil
				@dist_hash[e] = increase_dist(@dist_hash[node], node)
			end
		end
	end
		return @dist_hash
end


def traceback_data_dep_for_funcdep(cur_node)
	@dep_array = Array.new
	@node_list = Array.new
	@node_list.push(cur_node)
	while @node_list.length > 0 do
		node = @node_list.pop
		node.getBackwardEdges.each do |e|
			if e.getFromNode != nil and e.getToNode != nil
				if e.getFromNode.isReadQuery? or e.getFromNode.instance_of?AttrAssign_instr
					if @dep_array.include?(e.getFromNode)
					else
						@dep_array.push(e.getFromNode)
					end
				else
					if e.getFromNode.getInstr.instance_of?Return_instr and e.getFromNode.getInstr.getClassName == cur_node.getInstr.getClassName and e.getFromNode.getInstr.getMethodName == cur_node.getInstr.getMethodName
					elsif e.getFromNode.getIndex < cur_node.getIndex
						if @dep_array.include?(e.getFromNode)
						else
							@dep_array.push(e.getFromNode)
							@node_list.push(e.getFromNode)
						end
					end
				end
			elsif e.getFromNode == nil and e.getToNode != nil
				#TODO: this is a bit annoying... if the type in @dep_array is Edge, then it is user input, otherwise other instruction nodes
				@dep_array.push(e)
			end
		end
	end
	return @dep_array
end

#for a query, if it is like the form v = Vote.where(...)
#Given the query instruction Vote.where
#return the assign instruction v =
#so that we can know the result of the query is put into the variable v
#Or it can be like if Vote.where(...)
#Stops at a nearest var define or branch instr
#TODO: any other possiblilities?
def find_nearest_var(cur_node)
	@node_list = Array.new
	@node_list.push(cur_node)
	@traversed = Array.new
	while @node_list.length > 0 do
		node = @node_list.pop
		@traversed.push(node)
		node.getDataflowEdges.each do |e|
			if e.getToNode.getInstr.getDefv != nil 
				if e.getToNode.getInstr.getDefv.include?('%') == false
					return e.getToNode
				#elsif e.getToNode.getInstr.getDefv.include?("self")
				#	return e.getToNode
				elsif e.getToNode.getInstr.hasClosure?
					return e.getToNode
				end
			elsif e.getToNode.getInstr.instance_of?AttrAssign_instr and e.getToNode.getInstr.getCaller.include?("self")
				return e.getToNode
			elsif e.getToNode.getInstr.hasClosure?
				return e.getToNode
			else
				if @node_list.include?(e.getToNode) or @traversed.include?(e.getToNode)
				else
					if e.getToNode.getInstr.getBB == cur_node.getInstr.getBB
						@node_list.push(e.getToNode)
					end
				end
			end
		end
	end
	return nil
end

def traceforward_data_dep(query_node)
	@traversed = Array.new
	@node_list = Array.new
	@node_list.push(query_node)
	if query_node.getInstr.getBB.getCFG.getMHandler.normal_function == false
		query_node.getDataflowEdges.each do |e|
			@node_list.push(e.getToNode)
		end
	end
	while @node_list.length > 0 do
		node = @node_list.pop
		if @traversed.include?(node)
		else
			@traversed.push(node)
		end
		if node.getInstr.instance_of?Return_instr
			toedge = node.getDataflowEdges[0]
			if toedge and toedge.getToNode
				toedge.getToNode.getDataflowEdges.each do |e1|
					if e1.getToNode.getIndex <= query_node.getIndex or @traversed.include?(e1.getToNode)
					else
						@node_list.push(e1.getToNode)
					end
				end	
			end
		else
			node.getDataflowEdges.each do |e|	
				if e.getToNode.isQuery? and e.getToNode != query_node
					if @traversed.include?(e.getToNode)
					else
						@traversed.push(e.getToNode)
						@node_list.push(e.getToNode)
					end
				elsif @node_list.include?(e.getToNode) or @traversed.include?(e.getToNode)
				else
					if e.getToNode.getInstr.instance_of?Return_instr
						toedge = e.getToNode.getDataflowEdges[0]
						if toedge and toedge.getToNode
							toedge.getToNode.getDataflowEdges.each do |e1|
								if e1.getToNode.getIndex <= query_node.getIndex or @traversed.include?(e1.getToNode)
								else
									@node_list.push(e1.getToNode)
								end
							end	
						end
					elsif e.getToNode.getIndex > query_node.getIndex
						@node_list.push(e.getToNode)
					end
				end
			end
		end
	end
	@traversed.shift
	return @traversed
end

def find_all_ancestors(nodex)
	@ancestors = Array.new
	@temp_node_list = Array.new
	@temp_node_list.push(nodex)
	while @temp_node_list.length > 0
		temp_node = @temp_node_list.shift
		@ancestors.push(temp_node)
		temp_node.getBackwardEdges.each do |e|
			if e.getFromNode != nil and @ancestors.include?(e.getFromNode) == false 
				if e.getFromNode.getInstr.instance_of?Return_instr and e.getFromNode.getInstr.getClassName == nodex.getInstr.getClassName and e.getFromNode.getInstr.getMethodName == nodex.getInstr.getMethodName
				elsif e.getFromNode.getIndex < nodex.getIndex
					@temp_node_list.push(e.getFromNode)
				end
			end
		end
	end
	return @ancestors
end

def find_all_succcessors(nodex)
	@successors = Array.new
	@temp_node_list = Array.new
	@temp_node_list.push(nodex)
	while @temp_node_list.length > 0 do
		node = @temp_node_list.pop
		if node != nodex
			@successors.push(node)
		end
		if node.getInstr.instance_of?Return_instr
			toedge = node.getDataflowEdges[0]
			if toedge and toedge.getToNode
				toedge.getToNode.getDataflowEdges.each do |e1|
					if e1.getToNode.getIndex <= nodex.getIndex or @successors.include?(e1.getToNode)
					else
						@temp_node_list.push(e1.getToNode)
					end
				end	
			end
		else
			node.getDataflowEdges.each do |e|
				if @successors.include?(e.getToNode)
				else
					@temp_node_list.push(e.getToNode)
				end
			end
		end
	end
	return @successors
end

def goto_render(node)
	node.getDataflowEdges.each do |e1|
		instr1 = e1.getToNode.getInstr
		if instr1.is_a?Call_instr and instr1.getFuncname == "render"
			return true
		end
		e1.getToNode.getDataflowEdges.each do |e2|
			instr2 = e2.getToNode.getInstr
			if instr2.is_a?Call_instr and instr2.getFuncname == "render"
				return true
			end
			e2.getToNode.getDataflowEdges.each do |e3|
				instr3 = e3.getToNode.getInstr
				if instr3.is_a?Call_instr and instr3.getFuncname == "render"
					return true
				end
				e3.getToNode.getDataflowEdges.each do |e4|
					instr4 = e4.getToNode.getInstr
					if instr4.is_a?Call_instr and instr4.getFuncname == "render"
						return true
					end
				end
			end
		end
	end
	return false
end

#node is the assignment of a local variable, v_name is the name of the variable
#when a query result is stored in a variable, like @comment, check if there is any function call by @comment
#If yes, then the complete result need to be returned, or else only boolean or certain fields needs to be returned
#TODO: not finished...
def check_necessary_materialization(v_name, node)
	#get all predecessors of node
	@successors = find_all_successors(node)
	@successors.each do |p|
		if node.getInstr.getClassName == p.getInstr.getClassName
			if p.getInstr.instance_of?Call_instr #Has to be strictly Call_instr, not using is_a
				#TODO: caller name match, complicated...
				return true
			end 
		end
	end 	
	return false		
end

def is_chained_query(qnode)
	qnode.getDataflowEdges.each do |e|
		if e.getToNode.isReadQuery? and e.getToNode.getInstr.getCaller == qnode.getInstr.getDefv#and qnode.getDataflowEdges.length == 1
			return e.getToNode
		end
	end
	return nil
end

def get_query_chain(qnode)
	@r = Array.new
	@r.push(qnode)
	@cur_node = qnode
	@temp_node = qnode
	while @temp_node
		@temp_node = nil
		@cur_node.getDataflowEdges.each do |e|
			if e.getToNode.isReadQuery? and e.getToNode.getInstr.getCaller == @cur_node.getInstr.getDefv
				@r.push(e.getToNode)
				@cur_node = e.getToNode
				@temp_node = e.getToNode
			end
		end
	end
end
class QChain
	def initialize
		@qnodes = Array.new
		@used_fields = Array.new
		@select_conditions = Array.new
		@order = Array.new
	end
	attr_accessor :qnodes, :used_fields, :select_conditions, :order
	def add_node(qnode)
		@qnodes.push(qnode)
	end
	def add_used_fields(f)
		#format: class_name.field_name
		@used_fields.push(f) unless @used_fields.include?(f)
	end
	def add_select_conditions(c)
		@select_conditions.push(c) unless @select_conditions.include?(c)
	end	
	def add_order(c)
		#format: class_name.field_name
		@order.push(c) unless @order.include?(c)
	end
end
def test_in_chained_query(qnode)
	$query_chain.each do |k,v|
		v.qnodes.each do |v1|
			if v1 == qnode
				return true
			end
		end
	end
	return false
end

def add_in_chained_query(qnode, prenode)
	in_chain = false
	added = false
	$query_chain.each do |k,v|
		v.qnodes.each do |v1|
			if v1 == prenode and added == false
				in_chain = true
				$query_chain[k].add_node(qnode)
				added = true
			end
		end
	end
	if in_chain == false
		$query_chain[qnode] = QChain.new
		$query_chain[qnode].add_node(qnode)
	end
end

def add_order_to_chained_query(qnode, class_name, field_name)
	$query_chain.each do |k,v|
		in_chain = false
		v.qnodes.each do |v1|
			if v1 == qnode
				in_chain = true
			end
		end
		if in_chain
			v.add_order("#{class_name}.#{field_name}")
		end
	end
end

def add_select_field_to_chained_query(qnode, field_name)
	$query_chain.each do |k,v|
		in_chain = false
		v.qnodes.each do |v1|
			if v1 == qnode
				in_chain = true
			end
		end
		if in_chain
			v.add_select_conditions(field_name)
		end
	end
end

def add_used_field_to_chained_query(qnode, field_name)
	$query_chain.each do |k,v|
		in_chain = false
		v.qnodes.each do |v1|
			if v1 == qnode
				in_chain = true
			end
		end
		if in_chain
			v.add_used_fields(field_name)
		end
	end
end


def compute_query_chain_for_single_node(qnode)
	cq = is_chained_query(qnode)
	if cq
		#$temp_file.puts "#{qnode.getIndex} is chained query"
		add_in_chained_query(cq, qnode)
		return
	end
	if test_in_chained_query(qnode)
		return 
	else
		add_in_chained_query(qnode, qnode)
	end
	@traversed = Array.new
	@node_list = Array.new
	@node_list.push(qnode)
	@names = Array.new
	if qnode.getInstr.getDefv
		@names.push(qnode.getInstr.getDefv)
	end
	if qnode.getInstr.getBB.getCFG.getMHandler.normal_function == false
		qnode.getDataflowEdges.each do |e|
			@node_list.push(e.getToNode)
		end
	end

	while @node_list.length > 0 do
		temp_node = @node_list.pop
		if @traversed.include?(temp_node)
		else
			@to_add = Array.new
			@traversed.push(temp_node)
			if temp_node.getInstr.instance_of?Return_instr
				@names.delete_at(@names.index("%self") || @names.length)
				if temp_node.getDataflowEdges[0]
					tonode = temp_node.getDataflowEdges[0].getToNode
					tonode.getDataflowEdges.each do |e1|
						@to_add.push(e1.getToNode)
					end
					if tonode.getInstr.getDefv
						@names.push(tonode.getInstr.getDefv)
					end
				end
			else	
				temp_node.getDataflowEdges.each do |e|
					@to_add.push(e.getToNode)
				end
			end
			@to_add.each do |n|
				if @traversed.include?(n)
				elsif n.getIndex > qnode.getIndex
					if n.getInstr.instance_of?GetField_instr
						@node_list.push(n)
					elsif n.getInstr.instance_of?AttrAssign_instr
						if isActiveRecord(n.getInstr.getCallerType)
						else
							@names.push(n.getInstr.getFuncname)
							@node_list.push(n)
						end
					elsif n.isQuery?
						add_in_chained_query(n, qnode)
						if n.isReadQuery?
							@node_list.push(n)
							if n.getInstr.getDefv
								@names.push(n.getInstr.getDefv)
							end
						end
					elsif n.getInstr.instance_of?Copy_instr and n.getInstr.getDefv
						@names.push(n.getInstr.getDefv)
						@node_list.push(n)
					elsif n.getInstr.is_a?Call_instr
						if @names.include?(n.getInstr.getCaller)
							@node_list.push(n)
							if n.getInstr.getCallCFG == nil and n.getInstr.getDefv
								@names.push(n.getInstr.getDefv)
							else
								@names.push("%self")
							end
						else
							name_in_args = false
							n.getInstr.getArgs.each do |a|
								if @names.include?a
									name_in_args = true
									n.getDataflowEdges.each do |e1|
										if e1.getToNode.getInstr.is_a?ReceiveArg_instr and e1.getVname == a
											if e1.getToNode.getInstr.getDefv
												@names.push(e1.getToNode.getInstr.getDefv)
											end
											@node_list.push(e1.getToNode)
										end
									end
								end
							end
						end
					else
						@node_list.push(n)
					end
				end
			end
		end
	end	
end
def traceback_control_node(node)	
	@dep_array = Array.new
	@node_list = Array.new
	@node_list.push(cur_node)
	while @node_list.length > 0 do
		node = @node_list.pop
		node.getBackwardEdges.each do |e|
			if e.getFromNode != nil and e.getToNode != nil
				if stop_at_query and e.getFromNode.isQuery? 
					return e.getFromNode
				end
				if stop_at_query and e.getFromNode.getInstr.is_a?Call_instr and e.getFromNode.getInstr.getFuncname == "current_user"
					return e.getFromNode
				end
				if e.getFromNode.isReadQuery?
					if @dep_array.include?(e.getFromNode)
					else
						@dep_array.push(e.getFromNode)
						# add this node to the node list
						@node_list.push(e.getFromNode)
					end
				else
					#if cur_node.getCallStack.include?(e.getToNode) and e.getVname == "returnv"
					if e.getFromNode.getInstr.instance_of?Return_instr and e.getFromNode.getInstr.getClassName == cur_node.getInstr.getClassName and e.getFromNode.getInstr.getMethodName == cur_node.getInstr.getMethodName
					elsif e.getFromNode.getIndex < cur_node.getIndex
					#else
						#test is both nodes are in the same basic block, prevent from tracing too far
						#if e.getFromNode.getInstr.getBB == node.getInstr.getBB
						if @dep_array.include?(e.getFromNode)
						else
							@dep_array.push(e.getFromNode)
							@node_list.push(e.getFromNode)
						end
					end
				end
			elsif e.getFromNode == nil and e.getToNode != nil
				#TODO: this is a bit annoying... if the type in @dep_array is Edge, then it is user input, otherwise other instruction nodes
				@dep_array.push(e)
			end
		end
	end
	if stop_at_query
		return nil
	else
		return @dep_array
	end
end

