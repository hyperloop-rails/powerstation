class Temp_Qgeneral_stat
	def initialize
		@total = 0
		@read = 0
		@write = 0
		@in_closure = 0
		@read_in_closure = 0
		@in_while = 0
		@in_closure_by_db = 0
		@in_closure_by_db_scale = 0
		@in_loop_has_carrydep = 0
		@in_while_by_db = 0
		@in_view = 0
		@in_view_assoc = 0
		@use_query_string = 0
		@total_branch = 0	
		@branch_dependon_query = 0
		@branch_in_view = 0
		@issued_by_other = 0
	end
	attr_accessor :total, :read, :write, :in_closure, :read_in_closure, :in_while, :in_closure_by_db, :in_closure_by_db_scale, :in_loop_has_carrydep, :in_while_by_db, :in_view, :in_view_assoc, :total_branch, :branch_dependon_query, :branch_in_view, :use_query_string, :issued_by_other
	def get_avg(v)
		if @total > 0
			return v.to_f / @total.to_f;
		else
			return 0
		end
	end
	def get_data(v)
		return v
	end
end

class Temp_Qsink_stat < Temp_Qgeneral_stat
	def initialize
		super
		@to_read_query = 0
		@to_write_query = 0
		@to_branch = 0
		@to_view = 0
		@to_validation = 0
		@to_browser_cache = 0
		@sink_total = 0
	end
	attr_accessor :to_read_query, :to_write_query, :to_branch, :to_view, :to_validation, :to_browser_cache, :sink_total
	def get_to_read_query
		return get_data(to_read_query)
	end
	def get_to_write_query
		return get_data(@to_write_query)
	end
	def get_to_branch
		return get_data(@to_branch)
	end
	def get_to_view
		return get_data(@to_view)
	end
	def get_to_validation
		return get_data(@to_validation)
	end
	def get_to_browser_cache
		return get_data(@to_browser_cache)
	end
	def get_sink_total
		return get_data(@sink_total)
	end
end

class Temp_Qsource_stat < Temp_Qgeneral_stat
	def initialize
		super
		@source_total = 0
		@from_query = 0
		@from_const = 0
		@from_util = 0
		@from_user_input = 0
		@from_global = 0
		@from_query_string = 0
		@from_select_condition = 0
	end
	attr_accessor :from_query, :from_const, :from_user_input, :source_total, :from_util, :from_global, :from_query_string, :from_select_condition
	def get_from_query
		return get_data(@from_query)
	end
	def get_from_user_input
		return get_data(@from_user_input)
	end
	def get_from_const
		return get_data(@from_const)
	end
	def get_from_util
		return get_data(@from_util)
	end
	def get_from_global
		return get_data(@from_global)
	end
	def get_from_query_string
		return get_data(@from_query_string)
	end
	def get_from_select_condition
		return get_data(@from_select_condition)
	end
	def get_source_total
		return get_data(@source_total)
	end
end

class Temp_singleQ_stat
	def initialize
		@result_used_in_view = 0
		@only_from_user_input = 0
	end
	attr_accessor :result_used_in_view, :only_from_user_input
end

class Temp_view_stat
	def initialize
		@table_list = Array.new
		@field_list = Array.new
	end
	attr_accessor :table_list, :field_list
	def addTable(t)
		if @table_list.include?t
		else
			@table_list.push(t)
		end
	end
	def addField(f)
		if @field_list.include?f
		else
			@field_list.push(f)
		end
	end
end

class Temp_validation_stat
	def initialize
		@read = 0
		@write = 0
		@depth = 0
		@queries = Array.new
		@read_goes_to_write = Array.new # an array of read queries
		@read_goes_to_branch_on_write = Array.new #branch instrs, that are on the dataflow to the write queries
	end
	attr_accessor :read, :write, :depth, :queries, :read_goes_to_write, :read_goes_to_branch_on_write
	def addQuery(qnode)
		if @queries.include?(qnode)
		else
			@queries.push(qnode)
		end
	end
	def addReadGoesToWrite(qnode)
		if @read_goes_to_write.include?(qnode)
		else
			@read_goes_to_write.push(qnode)
		end
	end
	def addReadGoesToBranchOnWrite(qnode)
		if @read_goes_to_branch_on_write.include?(qnode)
		elsif @read_goes_to_write.include?(qnode)
		else
			@read_goes_to_branch_on_write.push(qnode)
		end
	end
	def getOtherQueries
		@r = Array.new
		@queries.each do |q|
			if @read_goes_to_write.include?(q)
			elsif @read_goes_to_branch_on_write.include?(q)
			elsif q.isReadQuery?
				@r.push(q)
			end
		end
		return @r
	end
end

class Temp_const_stat
	def initialize
		@sources = Hash.new
		@sources["receiveArg"] = 0
		@sources["attrAssign"] = 0
	end
	def add_receive_arg
		@sources["receiveArg"] += 1
	end
	def add_attr_assign
		@sources["attrAssign"] += 1
	end
	def add_copy_const(type)
		if @sources[type] == nil
			@sources[type] = 0
		end
		@sources[type] += 1
	end
	def getSources
		@sources
	end
end
