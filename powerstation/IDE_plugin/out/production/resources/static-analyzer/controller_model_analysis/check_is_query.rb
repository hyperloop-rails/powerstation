def check_method_keyword(_caller, k)
	if _caller != nil and _caller.include?("Dir.glob") or _caller == "File"
		return nil
	elsif $key_words[k]
		#puts "keywords #{k} #{$key_words[k]}"
		return $key_words[k]
	elsif k.index("find_by")==0
		return "SELECT"
	elsif k.index("find_or_create_by")==0
		return "INSERT"
	elsif k.index("not_")==0 and testTableField(_caller, k.gsub("not_",""))
		return "SELECT"
	elsif k.end_with?("count")
	#for example: User.tags_count = Tag.where(user_id = :id).count
		return "SELECT"	
	else
		return nil
	end
end

