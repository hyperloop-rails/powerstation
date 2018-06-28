require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/string'

def convert_tablename(name)
	_name = Array.new
	_word_list = Array.new
	name.split('').each do |c|
		if c == '_'
			_word_list.push(_name.join)
			_name = Array.new
		else
			_name.push(c)
		end
	end
	_word_list.push(_name.join)
	_word_list.each do |w|
		w[0] = w[0].capitalize
	end
	_word_list[-1] = _word_list[-1].singularize
	temp_name = _word_list.join
	return temp_name
end

def get_table_name_from_class_name(class_name)
	if isActiveRecord(class_name) == false
		return "UNKNOWN"
	end
	#mainly deal with upper class
	tmp_tbl_name = class_name
	tbl_name = class_name
	while tmp_tbl_name
		if $class_map[tbl_name].getUpperClass and isActiveRecord($class_map[tbl_name].getUpperClass)
			tbl_name = $class_map[tbl_name].getUpperClass
			tmp_tbl_name = tbl_name
		else
			tmp_tbl_name = nil
		end
	end
	return tbl_name
end

def find_class(tbl_name)
	c_name = convert_tablename(tbl_name)
	#TODO: How about inherited class?
	if $class_map[c_name]
		return $class_map[c_name]
	else
		$class_map.each do |k, v|
			chs = k.split("::")
			if chs[-1].downcase == tbl_name.singularize
				return v
			end
			#This is bad, but ruby doesn't know "data" is already plural :(
			if tbl_name.end_with?("data")
				if tbl_name.tr('_','').downcase == k.tr("::","").downcase
					return v
				end
			end
			#tbl_name = ci_comments, ci_runner_project
			#class_name = Ci::Comment, Ci::RunnerProject
			if tbl_name.tr('_','').downcase.singularize == k.tr("::","").downcase
				return v
			end
		end
	end
	return nil
end

class Table_field
	def initialize(type, field_name)
		@type = type
		@field_name = field_name
		@attrs = Hash.new
		@has_index = false
	end
	attr_accessor :type, :field_name, :attrs, :has_index
end

class Class_field < Table_field
end

def isActiveRecord(caller_name)
	_caller = $class_map[caller_name]
	if _caller == nil
		$class_map.each do |k, v|
			chs = k.split("::")
			if caller_name and chs[-1].downcase.singularize == caller_name.singularize
				_caller = v
			end
		end
	end
	if _caller != nil
		if _caller.getUpperClass == "ActiveRecord::Base"
			return true
		else
			while _caller != nil 
				if _caller.getUpperClass == "ActiveRecord::Base"
					return true
				else
					_caller = $class_map[_caller.getUpperClass]
				end
			end
		end
	end
	return false
end

def testTableField(caller_name, f_name)
	if $class_map[caller_name] != nil
		#puts "### #{caller_name} fields length = #{$class_map[caller_name].getTableFields.length}, f_name = #{f_name}"
		$class_map[caller_name].getTableFields.each do |f|
			#puts "\t #{f.field_name} #{f.type}"
			if f.field_name == f_name.delete('?')
				return f
			end
			if f.field_name.include?("_id") and f.field_name.delete("_id") == f_name.delete('?')
				return f
			end
		end
	end
	return nil
end

def addTableIndex(caller_name, f_name)
	if $class_map[caller_name] != nil
		$class_map[caller_name].getTableFields.each do |f|
			if f.field_name == f_name.delete('?')
				f.has_index = true
			end
			if f.field_name.include?("_id") and f.field_name.delete("_id") == f_name.delete('?')
				f.has_index = true
			end
		end
	end
end

def testTableIndex(caller_name, f_name)
	if f_name == "id"
		return true
	end
	if $class_map[caller_name] != nil
		$class_map[caller_name].getTableFields.each do |f|
			if f.field_name == f_name.delete('?')
				return f.has_index
			end
			if f.field_name.include?("_id") and f.field_name.delete("_id") == f_name.delete('?')
				return f.has_index
			end
		end
	end
	return false
end


def testExactTableField(caller_name, f_name)
	if $class_map[caller_name] != nil
		$class_map[caller_name].getTableFields.each do |f|
			if f.field_name == f_name.delete("?")
				return f
			end
		end
	end
	return nil
end

def read_schema(app_dir)
	$schema_file = "#{app_dir}/schema.rb"
	file = File.open($schema_file, "r")
	process_table_loop = false
	@cur_class = nil
	@cur_tbl_class_name = nil	
	file.each_line do |line|
		if line.include?("create_table")
			process_table_loop = true
			temp_attrs = line.split(" ")
			attrs = temp_attrs.reject(&:empty?)
			tbl_name = attrs[1].delete("\"").delete(",")
			@cur_class = find_class(tbl_name)
			t_field = Table_field.new("integer", "id")
			if @cur_class != nil
				@cur_class.addTableField(t_field)
				@cur_class.table_name = tbl_name
			end
			if @cur_class == nil
				@cur_class = Class_class.new(convert_tablename(tbl_name))
				@cur_class.table_name = tbl_name
				@cur_class.setUpperClass("ActiveRecord::Base")
				$class_map[tbl_name] = @cur_class 
				puts "read schema: class #{tbl_name} (#{convert_tablename(tbl_name)}) cannot be found!"
			end
			@cur_tbl_class_name = @cur_class.getName
			$table_names.push(convert_tablename(tbl_name))
		elsif line.delete(" ").delete("\n") == "end"
			process_table_loop = false
			@cur_class = nil
		elsif process_table_loop
			temp_attrs = line.split(" ")
			attrs = temp_attrs.reject(&:empty?)
			f_type = attrs[0]
			f_type = f_type.split(".")[1]
			f_name = attrs[1].delete("\"").delete(" ").delete(",")
			t_field = Table_field.new(f_type, f_name)	
			attrs.each do |attr|
				if attr.include?(": ")
					chrs = attr.split(": ")
					t_field.attrs[chs[0]] = chs[1].delete(",")
				end	
			end
			if @cur_class != nil
				@cur_class.addTableField(t_field)
			end
		elsif line.include?("add_index")
			chs = line.split(" ")
			i = 0
			while chs[i] != "add_index" do
				i += 1
			end
			table_name = chs[i+1].delete("\"").delete(",").delete(" ")
			field_name = chs[i+2].delete("\"").delete(",").delete(" ").delete("]").delete("[")
			if testTableField(@cur_tbl_class_name, field_name) 
				addTableIndex(@cur_tbl_class_name, field_name)
				puts "ADD INDEX: #{@cur_tbl_class_name}, #{field_name}"	
			else
				puts "INDEX:: TABLE #{table_name} - #{@cur_tbl_class_name} field #{field_name} cannot be found"
			end
		end	
	end
end

def compute_schema_design_stat(file)
	@table_crossrefs = Hash.new
	@crossref_type = Hash.new
	@total_field_ref = Hash.new
	$node_list.each do |n|
		if n.isClassField?
			tbl_name = type_valid(n.getInstr, n.getInstr.getCaller)
			field_name = n.getInstr.getFuncname
			if isActiveRecord(tbl_name)
				if @table_crossrefs[tbl_name] == nil
					@table_crossrefs[tbl_name] = Hash.new
					@total_field_ref[tbl_name] = 0
				end
				if n.getInstr.getDefv != nil
					@total_field_ref[tbl_name] += 1
					rtype = type_valid(n.getInstr, n.getInstr.getDefv)
					if rtype != nil and rtype != tbl_name and isActiveRecord(rtype)
						@relationship_name = $class_map[tbl_name].searchAssocForRelation(field_name)
						#puts "FIELD REF: #{tbl_name} -> #{field_name} (#{rtype}), relationship_name = #{@relationship_name}"
						if @relationship_name
							@crossref_type["#{tbl_name}->#{rtype}"] = @relationship_name
						end
						if @table_crossrefs[tbl_name][rtype] == nil
							@table_crossrefs[tbl_name][rtype] = 0
						end
						@table_crossrefs[tbl_name][rtype] += 1
					end
				end
			end
		end
	end

	@table_crossrefs.each do |tbl_name, v|
		#search for assoc relationship...
		file.puts("\t<#{tbl_name}>")
		v.each do |refname, cnt|
			cr_type = @crossref_type["#{tbl_name}->#{refname}"]
			if cr_type == nil
				cr_type = "unknown"
			end
			file.puts("\t\t<#{refname} relationship=\"#{cr_type}\">#{cnt}<\/#{refname}>")
		end
		file.puts("\t\t<totalFieldRef>#{@total_field_ref[tbl_name]}<\/totalFieldRef>")
		file.puts("\t<\/#{tbl_name}>")
	end	
end
