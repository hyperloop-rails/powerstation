$query_in_view = 0
$query_in_controller = 0
$query_in_model = 0
$query_in_other = 0
def calculate_query_issue_stat(cfg, class_instance)
	if cfg 
		cfg.getBB.each do |bb|
			bb.getInstr.each do |instr|
				if instr.hasClosure?
					calculate_query_issue_stat(instr.getClosure, class_instance)
				end
				if instr.isQuery
					if class_instance.class_type == "controller"
						if instr.in_view
							puts "Query in view: #{instr.toString}"
							$query_in_view += 1
						else
							$query_in_controller += 1
						end
					elsif class_instance.class_type == "model"
						$query_in_model += 1
					else
						$query_in_other += 1
					end
				end
			end
		end
	end

end

$table_query_hash = Hash.new
def calculate_table_query_stat(cfg)
	if cfg
		cfg.getBB.each do |bb|
			bb.getInstr.each do |instr|
				if instr.hasClosure?
					calculate_table_query_stat(instr.getClosure)
				end
				if instr.isQuery
					table_name = instr.getTableName
					if table_name
						$table_query_hash[table_name] = Array.new unless $table_query_hash[table_name]	
						$table_query_hash[table_name].push(instr)
					end	
				end
			end
		end
	end
end

def print_table_query_stat
	$table_query_hash.each do |k,v|
		$table_query_file.puts "\n++++++++++++++++++++"
		$table_query_file.puts "Table #{k}:  (#{v.length})"
		v.each do |instr|
			$table_query_file.puts "\t#{instr.toString3}"
		end
	end
end
