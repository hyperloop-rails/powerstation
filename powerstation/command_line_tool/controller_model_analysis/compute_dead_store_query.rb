def compute_dead_store_query(file)

    puts "===============Start compute dead store query==============="


	@closures = Array.new
	@query_loops = Array.new
	reload_queries = []
	$node_list.each do |n|
		if n.getInstr.instance_of?Call_instr and n.getInstr.getFuncname == 'reload'
			reload_queries << n.getInstr
		end
		#if n.getInstr
	end
	
	# build graphs to find paths 
	graph = Graph.new($node_list)
	$node_list.each do |n|
		if n.getControlflowEdges.length > 0
			n.getControlflowEdges.each do |ce|
				graph.addEdge(n, ce.getToNode)
				# puts "add edges from #{n.getInstr.toString} to #{ce.getToNode.getInstr.toString}"
			end
		end
	end
	reload_pairs = []
	dead_store_pairs = []
		for i in 0..reload_queries.length - 1
			rq1 = reload_queries[i]
			for j in (i+1)..reload_queries.length - 1
				rq2 = reload_queries[j]
				#puts "rq1: #{rq1.toString} rq2: #{rq2.toString}"
				rq2.getDeps.each do |rq2d|
					if rq2d.getInstrHandler == rq1
						reload_pairs << [rq1, rq2]
						graph.printAllPaths(rq1.getINode, rq2.getINode)
						paths = graph.result_paths
						#ingore the source and destination node
						traceback_data_dep(rq1.getINode).each do |tc|
							#puts "TC: #{tc.getInstr.toString} #{tc.getInstr.getLN}"
						end
						paths.each do |path|
							isDep = false
							for i in 1..path.length-2
								n = path[i]
								if !(n.getInstr.getDeps & rq1.getDeps).empty?
									puts n.getInstr.toString
									isDep = true
									break
								end
							end
							if !isDep
								pair = [rq1, rq2]
								if !$dead_store_queries.include?(pair)
									$dead_store_queries.push(pair) 
									dead_store_pairs.push(pair) unless dead_store_pairs.include?(pair)
								end
							end
						end
					end
				end
			end
		end
		
	dead_store_pairs.each do |dsp|
		#puts "#{dsp[0].getLN}: #{dsp[0].toString}  #{dsp[1].getLN}: #{dsp[1].toString} "
		meth0 = dsp[0].getBB.getCFG.getMHandler
		meth1 = dsp[1].getBB.getCFG.getMHandler
		r1 = getInstrLN(dsp[0])
		r2 = getInstrLN(dsp[1])
		file.puts "<dead_store_pairs>"
		file.puts "<node>"
		file.puts "<filename>"
		file.puts "#{r1[0]}"
		file.puts "</filename>"
		file.puts "<loc>#{r1[1]}</loc>"
		file.puts "</node>"
		file.puts "<node>"
		file.puts "<filename>"
		file.puts "#{r2[0]}"
		file.puts "</filename>"
		file.puts "<loc>#{r2[1]}</loc>"
		file.puts "</node>"
		file.puts "</dead_store_pairs>"

	end
	#puts "===============Finish compute dead store query==============="

end

class Graph
	def initialize(nodes)
		@nodes = nodes
		@adjList = {}
		@result_paths = Array.new
		initAdjList()
	end
	def initAdjList()
		@nodes.each do |n|
			@adjList[n] = Array.new
		end
	end
	# add the edge between u and v
	def addEdge(u, v)
		adjList[u].push(v)
	end
	def printAllPaths(s, d)
		@result_paths = Array.new
		isVisited = {}
		pathList = Array.new
		pathList.push(s)
		printAllPathsUtil(s, d, isVisited, pathList);

	end
	def printAllPathsUtil(u, d, isVisited, localPathList)
		isVisited[u] = true
		if(u == d)
			# puts "find path u.getInstr.toString"
			# localPathList.each do |l|
			# 	puts l.getInstr.toString
			# end
			@result_paths.push(localPathList.dup)
		end
		adjList[u].each do |i| 
			if !isVisited[i]
				localPathList.push(i)
				printAllPathsUtil(i, d, isVisited, localPathList)
				localPathList.delete(i);
			end
		end
		isVisited[u] = false
	end
	attr_accessor :nodes, :adjList, :result_paths
end