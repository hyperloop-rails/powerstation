require 'yard'
require 'logger'
require 'optparse'
require 'date'

#Global variables:
load 'global_variables.rb'
load 'compute_switch.rb'

#Helpers:
load 'helper.rb'
load 'check_is_query.rb'
load 'check_query_string.rb'
load 'check_validation.rb'
load 'util.rb'

#App ruby code parser:
load 'traverse_ast.rb'
load 'parse_node.rb'

#Data structure for classes/modules and functions:
load 'func_call.rb'
load 'class_method.rb'

#Data structure for dataflow and stats collection:
load 'dataflow_component.rb'
load 'graph_component.rb'
load 'stats_component.rb'
load 'type_inference.rb'

#Read files:
load 'read_app_files.rb'
load 'read_dataflow_log.rb'
load 'read_schema.rb'

#Trace a controller action and build dataflow graph:
load 'trace_flow.rb'
load 'build_dataflow_graph.rb'

#Compute stats:
load 'compute_helper.rb'
load 'compute_stats.rb'
load 'compute_functional_dependency_stat.rb'
load 'compare_consequent_actions.rb'
load 'compute_branch_stat.rb'
load 'compute_input_stat.rb'
load 'compute_view_stat.rb'
load 'compute_loop_stat.rb'
load 'compute_loop_invariant.rb'
load 'compute_query_card_stat.rb'
load 'compute_dataflow_chain_stat.rb'
load 'compute_redundant_field_access.rb'
load 'compute_redundant_table_access.rb'
load 'compute_redundant_rows.rb'
load 'compute_select_condition.rb'
load 'compute_dead_store_query.rb'
load 'compute_inefficient_partial.rb'
load 'compute_performance.rb'
#load 'dump_graph.rb'

#Static count:
load 'static_code_analysis.rb'
PATH_ORDER = [
  'lib/yard/autoload.rb',
  'lib/yard/code_objects/base.rb',
  'lib/yard/code_objects/namespace_object.rb',
  'lib/yard/handlers/base.rb',
  'lib/yard/generators/helpers/*.rb',
  'lib/yard/generators/base.rb',
  'lib/yard/generators/method_listing_generator.rb',
  'lib/yard/serializers/base.rb',
  'lib/**/*.rb'
]

#iterate over all controllers


def print_classes(class_name=nil)
	if class_name == nil
		$class_map.each do |keyc, valuec|
			valuec.print_calls
		end	
	else
		$class_map[class_name].print_calls
	end
end

def print_types(class_name=nil)
	if class_name == nil
		$class_map.each do |keyc, valuec|
			valuec.print_var_types
		end	
	else
		$class_map[class_name].print_var_types
	end
end

def print_instructions(class_name=nil)
	if class_name == nil
		$class_map.each do |keyc, valuec|
			valuec.print_instructions
		end	
	else
		$class_map[class_name].print_instructions
	end
end

def time_diff(start_time, end_time)
  seconds_diff = (start_time - end_time).to_i.abs

  hours = seconds_diff / 3600
  seconds_diff -= hours * 3600

  minutes = seconds_diff / 60
  seconds_diff -= minutes * 60

  seconds = seconds_diff

  "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
end


options = {}

pgr = Random.new((DateTime.now.strftime('%Q')).to_i)
$fast_random = Fast_random.new(pgr.rand(1...104829910))

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: ruby main.rb [OPTIONS]"

  opt.on("-p","--print [CLASS_NAME]",String,"print out variable and function call names of class specified; or type all to print out all classes","example: --print CommentsController or --print all") do |class_name|
		options[:class_name] = class_name
  end

	opt.on("-r","--trace CLASS_NAME,FUNCTION_NAME",Array,"needs two arguments, class_name function_name; will print out call graph of the function specified","example: --trace CommentsController,create") do |trace_input|
		options[:trace_input] = trace_input
  end

	opt.on("-c","--consequent CLASS_NAME,FUNCTION_NAME",Array,"calculate the overlap between two controller functions","example: --consequent CommentsController,create") do |cons_input|
		options[:consequent] = cons_input
  end


	opt.on("-d","--dir DIR",String,"the application directory, for example, -d /home/congy/lobsters/app, by default it is ./losters,","where the controllers/models/logs of lobsters application is located") do |dir|
   	options[:dir] = dir
  end

	opt.on("-a","--run-all","Run all entrance") do |run_all|
		options[:run_all] = true
	end

	#opt.on("-g","--dump-graph","only dump graph, donot collect stats") do |dump|
	#	options[:dump_graph] = true
	#end

	opt.on("-i", "--only-type-inference","Only do type inference, and search method by name upon function call.","Using this option the script may not be able to resolve every function call, but no need for dynamic type logs.") do |inference|
		options[:inference] = true
	end

	#opt.on("-v", "--print-validation",String,"Print queries in validation") do |print_validation|
	#	options[:print_validation] = true
	#end


	#opt.on("-n", "--print-instr [CLASS_NAME]",String,"Print instructions and CFG of all methods in the specified class") do |class_name|
	#	options[:printinstr] = class_name
	#end

	opt.on("-f", "--print-dataflow CLASS_NAME,FUNCTION_NAME",Array,"needs two arguments, class_name,action_name; print the dataflow and controlflow of the action") do |print_flow_input|
		options[:print_flow] = true
		if options[:trace] == nil
			options[:trace]  = print_flow_input
		end
	end

	opt.on("-t", "--trace-dataflow CLASS_NAME,FUNCTION_NAME",Array,"needs two arguments, class_name,function_name; print call graph and data flow to a file, use graphviz to visualize") do |trace_input|
		options[:trace_flow] = true
		if options[:trace] == nil
			options[:trace]  = trace_input
		end
	end

	#opt.on("-r", "--random-path","instead of calculate the complete control flow graph, select random path at each branch") do |random_path|
	#	options[:random_path] = true
	#end

	#opt.on("-g", "--query-graph CLASS_NAME,FUNCTION_NAME",Array,"print out flow graph only containing queries") do |q_input|
	#	options[:query_graph] = true
	#	if options[:trace] == nil
	#		options[:trace] = q_input
	#	end
	#end

	opt.on("-s", "--stats CLASS_NAME,FUNCTION_NAME",Array,"print some stats, including query_num, dataflow grap from user input to user output, etc. Needs two argument") do |stats|
			options[:stats] = true
			options[:trace] = stats
	end

	opt.on("-p", "--performance CLASS_NAME,FUNCTION_NAME",Array,"print some stats, including query_num, dataflow grap from user input to user output, etc. Needs two argument") do |stats|
			options[:perf] = true
			options[:trace] = stats
	end

	opt.on("-o", "--output-dir DIR",String,"Output directory for graphviz files") do |output_dir|
		options[:output] = output_dir
	end
	
	opt.on("-b", "--print-all","Print all calls, only for debug") do |print_all|
		options[:print_all] = true
	end


	opt.on("-rs", "--print-all","Print all calls, only for debug") do |print_all|
		options[:run_shell] = true
	end

  opt.on("-h","--help","help") do
		options[:help] = true
    puts opt_parser
		puts "=================="
		puts "Example: ruby main.rb -a -d ../applications/boxroom"
  end
end

opt_parser.parse!

if options[:help]
	exit
end

if options[:inference] == true
	$type_inference = true
end

tstart = Time.now
puts "Start #{tstart}"

if options[:dir] != nil and options[:run_shell]
	$app_dir = options[:dir]
	call_file = "#{$app_dir}/calls.txt"
	puts "call_file #{call_file}"
	ths = []
	File.open(call_file, "r").each do |line|
		thread = Thread.new {
		line = line.gsub("\n","")
		chs = line.split(',')
		if chs.length != 2
			next
		end
		start_function = chs[1]
		start_class = getControllerNameCap(chs[0])
		puts "ruby main.rb -d #{$app_dir} -s #{start_class},#{start_function}"
		system("ruby main.rb -d #{$app_dir} -s #{start_class},#{start_function}")
		}
		ths.push(thread)
	end
	ths.each do |t|
		t.join
	end
	exit
end	
if options[:dir] != nil
	puts "dir = #{options[:dir]}"
	if options[:template] != nil
		read_ruby_files_with_template(options[:dir], options[:template])
	else
		$app_dir = options[:dir]
		
		t1 = Time.now
		if options[:stats]
			fn = options[:trace][0]
			fs = fn.gsub("::", "/").gsub(/\w(?=[A-Z])/){|match| "#{match}_"}.gsub("Controller", "controller").downcase
			filename = $app_dir + '/dataflow/merged_controllers/'  + fs + ".log"
			cfilename = $app_dir + '/merged_controllers/'  + fs + '.rb'
			contents = open(cfilename, 'r').read
			root = YARD::Parser::Ruby::RubyParser.parse(contents).root
			root = getDefNode(root, options[:trace][1])
			$const = [fn]
			con(root)
			t1 = Time.now 
			puts "read_ruby_files: #{Time.now - t1}"
			handle_single_file(cfilename)
			class_name = dataflow_filename_match(cfilename)
			if $class_map[fn]
				puts "size: #{fn} #{$class_map[fn].filename} #{fn}"
				handle_single_dataflow_file(filename, class_name)
				m = find_method(filename, options[:trace][1])
				if m
					$mcs = m.getCalls.map{|e| e.getFuncName} 
					# $mcs.each do |m|
					# 	puts "method is : #{m}"
					# end
					$mcs.push(options[:trace][1])
					$const.delete(fn)
					puts "const length: #{$const.length} mcs: #{$mcs.length}"
					read_ruby_files
					read_dataflow(options[:dir])
				end
			else 
				exit
			end
		else
			puts "run_all"
			t1 = Time.now 
			read_ruby_files
			puts "AAA: read_ruby_files: #{Time.now - t1}"
			puts "Finish reading files"
			read_dataflow(options[:dir])
		end
		puts "read_dataflow: #{Time.now - t1}"
		t1 = Time.now
		do_type_inference
		puts "do_type_inference: #{Time.now - t1}"
		
		
	end
else
	t1 = Time.now 
	read_ruby_files
	puts "nil read_ruby_files: #{Time.now - t1}"
	t1 = Time.now
	read_dataflow
	puts "nil read_dataflow: #{Time.now - t1}"
	t1 = Time.now
	do_type_inference
	puts "nil do_type_inference: #{Time.now - t1}"
end

if options[:class_name] != nil
	if options[:class_name] == "all"
		print_classes
	else
		print_classes(options[:class_name])
	end
end

if options[:class_name_for_type] != nil
	if options[:class_name_for_type] == "all"
		print_types
	else
		print_types(options[:class_name_for_type])
	end
end

if options[:printinstr] != nil
	if options[:printinstr] == "all"
		print_instructions
	else
		print_instructions(options[:printinstr])
	end
end

if options[:trace_input] != nil
	start_class = options[:trace_input][0]
	start_function = options[:trace_input][1]
	level = 0
end


if options[:output] != nil
	$output_dir = options[:output]
end

if options[:perf]
	start_class = options[:trace][0]
	start_function = options[:trace][1]
	level = 0
	$temp_file = File.open("#{$output_dir}/trace.log","w")
	compute_performance($output_dir, start_class, start_function)
end
if options[:trace_flow] or options[:stats] or options[:query_graph]
	start_class = options[:trace][0]
	start_function = options[:trace][1]
	level = 0

	$temp_file = File.open("#{$output_dir}/trace.log","w")
	puts "COMPUTE STATS"
	puts start_function, start_class
	puts "temp file name: #{$output_dir}/trace.log"
	if options[:trace_flow] or options[:random_path]
		graph_fname = "#{$output_dir}/#{start_class}_#{start_function}_graph.log"
		$graph_file = File.open(graph_fname, "w");

		$graph_file.write("digraph #{remove_special_chars(start_class)}_#{start_function} {\n")
		if options[:random_path]
			#print_random_trace(start_class, start_function)
		else
			trace_flow(start_class, start_function, "", "", level)
		end
		$graph_file.write("}")
	end

	if options[:query_graph]
		print_query_graph($output_dir, start_class, start_function)
	end

	if options[:dump_graph]
		trace_query_flow(start_class, start_function, "", "", level)
		$dump_file = File.open("dump_graph.gml", "w") 
		dump_graphml
	end

	if options[:stats]

		# system("rm -rf #{$app_dir}/#{$results_dir}/")
		system("mkdir #{$app_dir}/#{$results_dir}/")
		puts "mkdir #{$app_dir}/#{$results_dir}/"
		$output_dir = "#{$app_dir}/#{$results_dir}/#{start_class}_#{start_function}"
		system("rm -rf #{$output_dir}")
		system("mkdir #{$output_dir}")
		loop_invariant_file = "#{$app_dir}/#{$results_dir}/loop_invariant.xml"
		$loop_invariant_file = File.open(loop_invariant_file, "w")
		$loop_invariants = []
		$loop_invariant_file.write("<loopInvariants>\n")


		dead_store_file = "#{$app_dir}/#{$results_dir}/dead_store.xml"
		$dead_store_file = File.open(dead_store_file, "w")
	    $dead_store_file.write("<dead_store_queries>\n")
	    $dead_store_queries = []

		inefficient_render_file = "#{$app_dir}/#{$results_dir}/inefficient_render.xml"
		$inefficient_render_file = File.open(inefficient_render_file, "w")
	    $inefficient_render_file.write("<inefficientRenders>\n")
	    $inefficient_renders = []

		common_subexpression_file = "#{$app_dir}/#{$results_dir}/common_subexpression.xml"
		$common_subexpression_file = File.open(common_subexpression_file, "w")
	    $common_subexpression_file.write("<commonSubexprs>\n")
	    $common_subexpressions = []

	    redundant_usage_file = "#{$app_dir}/#{$results_dir}/redundant_usage.xml"
	    $redundant_usage_file = File.open(redundant_usage_file, 'w')
	    $redundant_usage_file.write("<redundantData>\n")
	    $redundant_usages = []


		if options[:random_path]
			compute_dataflow_stat($output_dir, start_class, start_function, true)
		else
			compute_dataflow_stat($output_dir, start_class, start_function)
    end
		$loop_invariant_file.write("</loopInvariants>\n")
		$loop_invariant_file.close

		$dead_store_file.write("</dead_store_queries>\n")
		$dead_store_file.close

		$inefficient_render_file.write("</inefficientRenders>\n")
		$inefficient_render_file.close


		$common_subexpression_file.write("</commonSubexprs>\n")
		$common_subexpression_file.close

		$redundant_usage_file.write("</redundantData>\n")
		$redundant_usage_file.close

	end
end



if options[:run_all]
	system("rm -rf #{$app_dir}/#{$results_dir}/")
	system("mkdir #{$app_dir}/#{$results_dir}/")
	call_file = "#{$app_dir}/calls.txt"

	loop_invariant_file = "#{$app_dir}/#{$results_dir}/loop_invariant.xml"
	$loop_invariant_file = File.open(loop_invariant_file, "w")
	$loop_invariants = []
	$loop_invariant_file.write("<loopInvariants>\n")


	dead_store_file = "#{$app_dir}/#{$results_dir}/dead_store.xml"
	$dead_store_file = File.open(dead_store_file, "w")
    $dead_store_file.write("<dead_store_queries>\n")
    $dead_store_queries = []

	inefficient_render_file = "#{$app_dir}/#{$results_dir}/inefficient_render.xml"
	$inefficient_render_file = File.open(inefficient_render_file, "w")
    $inefficient_render_file.write("<inefficientRenders>\n")
    $inefficient_renders = []

	common_subexpression_file = "#{$app_dir}/#{$results_dir}/common_subexpression.xml"
	$common_subexpression_file = File.open(common_subexpression_file, "w")
    $common_subexpression_file.write("<commonSubexprs>\n")
    $common_subexpressions = []

    redundant_usage_file = "#{$app_dir}/#{$results_dir}/redundant_usage.xml"
    $redundant_usage_file = File.open(redundant_usage_file, 'w')
    $redundant_usage_file.write("<redundantData>\n")
    $redundant_usages = []
    threads = []
	File.open(call_file, "r").each do |line|
		line = line.gsub("\n","")
		chs = line.split(',')
		if chs.length != 2
			next
		end
		start_function = chs[1]
		start_class = getControllerNameCap(chs[0])
		puts "\n\n================================="
		puts "================================="
		puts "Handling #{start_class}, #{start_function}"
		time1 = Time.now
		level = 0
		#start print query trace
		$output_dir = "#{$app_dir}/#{$results_dir}/#{start_class}_#{start_function}"
		system("mkdir #{$output_dir}")
		graph_fname = "#{$output_dir}/#{start_class}_#{start_function}_graph.log"
		$lock_file = File.open("#{$app_dir}/dirlock.log", "w")
		$lock_file.puts("#{start_class}_#{start_function}")
		$lock_file.close
		$graph_file = File.open(graph_fname, "w")
		vis_file_name = "#{$output_dir}/qgraph_vis.gv"
		$vis_file = File.open(vis_file_name, "w")
		$temp_file = File.open("#{$output_dir}/trace.log","w")

		$cur_node = nil
		$root = nil
		$non_repeat_list = Array.new
		$call_stack_trace = Array.new
		$global_check = Hash.new
		$node_list = Array.new
		$cur_query_stack = Array.new
		$query_edges = Array.new
		od = $output_dir
		#thread = Thread.new {
			puts "compute #{$output_dir}"
			t1 = Time.now
			puts "Time1: #{t1}"
			begin
				compute_dataflow_stat(od, start_class, start_function)
			rescue
				puts "Rescue in the computation"
			end
			puts "Time2: #{Time.now}"
			puts "Duration: #{start_class}, #{start_function} #{Time.now - t1}"
			puts "-----Finsh Time------"

		#}
		#thread.join
		# threads.push(thread)
		# thread.join
		$vis_file.close
		clear_data_structure
	end
	#threads.each { |thr| thr.join }
	$loop_invariant_file.write("</loopInvariants>\n")
	$loop_invariant_file.close

	$dead_store_file.write("</dead_store_queries>\n")
	$dead_store_file.close

    $inefficient_render_file.write("</inefficientRenders>\n")
    $inefficient_render_file.close


    $common_subexpression_file.write("</commonSubexprs>\n")
    $common_subexpression_file.close

    $redundant_usage_file.write("</redundantData>\n")
    $redundant_usage_file.close

	system("rm #{$app_dir}/dirlock.log")
end
puts "ALL DURATION OF #{$app_dir} #{Time.now - tstart}"
if options[:consequent] != nil
	start_class = options[:consequent][0]
	start_function = options[:consequent][1]
	
	level = 0
	$trace_output_file = File.open("#{$output_dir}/trace.temp", "w")
	compute_dataflow_stat($output_dir, start_class, start_function, true)


	@prev_list = Array.new 
	$node_list.each do |n|
		@prev_list.push(n)
	end

	view_by_controllers_dir = "../applications/lobsters/next_calls/#{start_class}_#{start_function}.txt"
	@next_action = Array.new
	File.open(view_by_controllers_dir, "r").each do |line|
		if line.length > 1
			line = line.gsub("\n","")
			if @next_action.include?line
			else
				@next_action.push(line)
			end
		end
	end
			
#	next_file = "#{$app_dir}/next_calls/#{start_class}_#{start_function}.txt"
#	File.open(next_file, "r").each do |line|
	@next_action.each do |line|
		clear_data_structure

		line = line.gsub("\n","")
		chs = line.split(',')
		next_function = chs[1]
		chs[0] = chs[0].capitalize
		next_class = "#{chs[0]}Controller"
		compute_dataflow_stat($output_dir, next_class, next_function, true)
	
		#puts "Compare with: #{next_class}.#{next_function}"
		compare_consequent_actions("#{next_class}_#{next_function}", @prev_list, $node_list)
	end
end

if options[:print_validation] == true
	call_file = "#{$app_dir}/calls.txt"
	File.open(call_file, "r").each do |line|
		line = line.gsub("\n","")
		chs = line.split(',')
		start_function = chs[1]
		chs[0] = chs[0].capitalize
		start_class = "#{chs[0]}Controller"
		puts "\n\n================================="
		puts "================================="
		puts "Handling #{start_class}, #{start_function}"
		level = 0

		$output_dir = "#{$app_dir}/#{$results_dir}/#{start_class}_#{start_function}"
		system("mkdir #{$output_dir}")
		graph_fname = "#{$output_dir}/validation.log"
		$graph_file = File.open(graph_fname, "w");
		clear_data_structure

		$cfg = trace_query_flow(start_class, start_function, "", "", 0)
		addAllControlEdges
		compute_source_sink_for_all_nodes
		check_validations

	end
end


if options[:print_flow]
	start_class = options[:trace][0]
	start_function = options[:trace][1]
	$temp_file = File.open("#{$output_dir}/trace.log","w")
	$output_dir = "./"
	vis_file_name = "#{$output_dir}/qgraph_vis.gv"
	$vis_file = File.open(vis_file_name, "w")

	#some initialization
	$cur_node = nil
	$root = nil
	$non_repeat_list = Array.new
	$call_stack_trace = Array.new
	$global_check = Hash.new
	$node_list = Array.new
	$cur_query_stack = Array.new
	$query_edges = Array.new

	compute_dataflow_stat($output_dir, start_class, start_function)
	
	$vis_file.close
	system "dot -Tpdf #{vis_file_name} -o #{$output_dir}/qgraph.pdf"

	puts "command : dot -Tpdf #{vis_file_name} -o #{$output_dir}/qgraph.pdf"

end
