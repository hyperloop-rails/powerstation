def check_validations
	@last_v_stacktop = nil
	$node_list.each do |n|
		if n.getInValidation and n.isQuery?
			@blank = ""
			for i in 0...n.getValidationStack.length
				@blank += "  "
			end
			trigger = n.getValidationStack[-1]

			if @last_v_stacktop == nil
				@last_v_stacktop = n.getValidationStack[-1]
				$graph_file.write("#{@blank}Validation for #{trigger.getIndex}(#{trigger.getInstr.getResolvedCaller}) #{trigger.getInstr.toString2}:\n")
			elsif @last_v_stacktop != n.getValidationStack[-1]
				@last_v_stacktop = n.getValidationStack[-1]
				$graph_file.write("\n")
				$graph_file.write("#{@blank}Validation for #{trigger.getIndex}(#{trigger.getInstr.getResolvedCaller}) #{trigger.getInstr.toString2}:\n")
			else
			end

			if n.getInstr.getCallHandler != nil
				$graph_file.write("#{@blank  } #{n.getInstr.getCallHandler.complete_string}\n")
			else
				$graph_file.write("#{@blank  } #{n.getInstr.toString2}\n")
			end

		end
	end
end
