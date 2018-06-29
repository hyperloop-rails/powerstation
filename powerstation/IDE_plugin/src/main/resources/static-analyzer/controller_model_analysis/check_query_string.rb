$query_words_exact_match = ["DESC","ASC","JOIN","ON","AND","OR","NOT","IN","NULL","EXIST","UPDATE","INSERT","SELECT","LIMIT","GROUP","ORDER","LIKE"]
$query_words_include = ["SUM","MIN","MAX","COUNT"]

#distinct: Specifies whether the records should be unique or not. Under a certain condition, return multiple records or single record
#new_record return true/false
$query_return_record = ["find","all","take","from","distinct","from","having","joins","limit","order","where","first","last","preload", "reload", "includes","references","reorder","reverse_order","first_or_initialize","find_each","find_in_batches","uniq","association","find_by"]

def addQueryFuncHash(_key)
	key = _key.gsub('?','').gsub('!','')
	if _key.include?("find_by") or _key.include?("find_or_create_by")
		key = "find_by"
	elsif $key_words[_key]
		key = _key.gsub('?','').gsub('!','')
	else
		key = "association"
	end
	if $query_func_count.include?(key)
	else
		$query_func_count[key] = 0
	end
	$query_func_count[key] += 1
end

def check_scope_query_string(query_node)
	contain_query_string = false
	if query_node.getInstr.getCallHandler
		func_str = query_node.getInstr.getCallHandler.getFuncName
		addQueryFuncHash(func_str)
		str = query_node.getInstr.getCallHandler.query_string
		if str
			chs = str.split(" ")
			chs.each do |c|
				if $query_words_exact_match.include?(c)
					if $query_word_count[c] == nil
						$query_word_count[c] = 0
					end
					$query_word_count[c] += 1
					contain_query_string = true
				end
				$query_words_include.each do |i|
					if c.include?(i)
						if $query_word_count[i] == nil
							$query_word_count[i] = 0
						end
						$query_word_count[i] += 1
						contain_query_string = true
					end
				end
			end
		end
	end
	return contain_query_string
end

def check_query_function(query_node)
		addQueryFuncHash(query_node.getInstr.getFuncname)
end

def check_query_string(query_node, const_node)
	if const_node.getInstr.instance_of?Copy_instr and const_node.getInstr.const_string
		#TODO: Here we restrict that the query node is directly depend on query node
		direct_dependent = true
		#direct_dependent = false
		#query_node.getBackwardEdges.each do |e|
		#	if e.getToNode == const_node
		#		direct_dependent = true
		#	end
		#end
		if direct_dependent
			contain_query_string = false
			chs = const_node.getInstr.const_string.split(" ")
			chs.each do |c|
				if $query_words_exact_match.include?(c)
					if $query_word_count[c] == nil
						$query_word_count[c] = 0
					end
					$query_word_count[c] += 1
					contain_query_string = true
				end
				$query_words_include.each do |i|
					if c.include?(i)
						if $query_word_count[i] == nil
							$query_word_count[i] = 0
						end
						$query_word_count[i] += 1
						contain_query_string = true
					end
				end
			end
			return contain_query_string
		end
	end
	return false
end

def printQueryStringFreq
	$query_word_count.each do |w, f|
		$graph_file.puts("\t<#{w}>#{f}<\/#{w}>")
	end
end

def printQueryFunctionFreq
	$query_func_count.each do |w, f|
		$graph_file.puts("\t<#{w}>#{f}<\/#{w}>")
	end
end
