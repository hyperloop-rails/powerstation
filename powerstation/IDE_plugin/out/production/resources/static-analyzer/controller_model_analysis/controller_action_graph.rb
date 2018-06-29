$graph_file = File.open("call_cycle.log", "w")
$app_dir = "../applications/lobsters"
$call_file = "#{$app_dir}/calls.txt"
$view_by_controllers_dir = "../zewei/view_controller_analysis/links_by_controllers/lobsters/"

$graph_file.write("digraph callCycle{\n")

$edges = Array.new

File.open($call_file, "r").each do |line|
	line = line.gsub("\n","")
	chs = line.split(',')
	start_function = chs[1]
	chs[0] = chs[0].capitalize
	start_class = "#{chs[0]}Controller"
	
	view_by_controllers_file = "#{$view_by_controllers_dir}/#{start_class}_#{start_function}.txt"
		
	$graph_file.write("\t#{start_class}_#{start_function} [color=darkorange]; \n")

	if File.exist?(view_by_controllers_file)
		File.open(view_by_controllers_file, "r").each do |line1|
			if line1.length > 1
				line1 = line1.gsub("\n","")
				chs1 = line1.split(',')
				next_function = chs1[1]
				if chs1[1].include?('/')
				 	next_function = chs[1].split('/')[0]
				end
				chs1[0] = chs1[0].capitalize
				next_class = "#{chs1[0]}Controller"
				edge_name = "#{start_class}_#{start_function}-#{next_class}_#{next_function}"
				if $edges.include?edge_name
				else
					$graph_file.write("\t#{start_class}_#{start_function} -> #{next_class}_#{next_function}\n")
					$edges.push(edge_name)
				end
			end
		end
	end
end

$graph_file.write("}\n")

