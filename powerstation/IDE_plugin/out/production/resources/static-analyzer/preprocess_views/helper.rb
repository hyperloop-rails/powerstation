require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/string'

def has_controller(c)
	$controller_names_downcase.each do |n|
		if n.downcase.singularize == c or n.downcase == c
			return n
		end
	end
	return nil
end

def get_class_name_from_class_node(node)
	if node.children[0].type.to_s == "const_path_ref" or node.children[0].type.to_s == "const_ref"
		return node.children[0].source.to_s
	else
		return get_left_most_leaf(node).source.to_s
	end
end

def class_includes_functions(astnode)
	if astnode.class.to_s == "YARD::Parser::Ruby::MethodDefinitionNode"
		return true
	elsif astnode.type.to_s == "class" or astnode.type.to_s == "module"
	else
		r = false
		astnode.children.each do |child|
			if class_includes_functions(child)
				r = true
			end
		end
		return r
	end 
end

def is_ast_node(node)
	if node != nil and node.class.to_s == "YARD::Parser::Ruby::AstNode"
		return true
	elsif node != nil
		return node.class.ancestors.include?YARD::Parser::Ruby::AstNode
	else
		return false
	end
end

def recursive_parse_hash(node, hash_result)
	if node.type.to_s == "hash"
		parse_hash(node, hash_result)
	else
		if node.type.to_s == "list"
			parse_hash(node, hash_result)
		end
		node.children.each do |c|
			recursive_parse_hash(c, hash_result)
		end
	end
end

def parse_hash(node, hash_result) #only accepts string literal...
	#puts "note a hash: #{node.source}"
	node.children.each do |c|
		if c.type.to_s == "assoc"
			hash_key = get_left_most_leaf(c.children[0]).source.to_s
			hash_value = ""
			if get_left_most_leaf(c.children[1]).type.to_s == "tstring_content"
				hash_value = get_left_most_leaf(c.children[1]).source
				#puts "!!!FINDS A HASH: {:#{hash_key} => #{hash_value}}"
				hash_result[hash_key] = hash_value
			end
		end
	end
end

def get_left_most_leaf(node)
	rv = node	
	while is_ast_node(rv) do
		if rv.children.length > 0
			rv = rv.children[0]
		else
			break
		end
	end
	return rv
end

#pre-order traverse
def recursive_parse_render(cur_node, key_words)
	if key_words.include?cur_node.type.to_s and cur_node.children.length == 0
		if cur_node.source != "render"
			$node_stack.push(cur_node)
		end
	end
	cur_node.children.each do |child|
		recursive_parse_render(child, key_words)
	end
end

# return the locals nodes
def parse_render_variables(cur_node, key)
	if cur_node.type.to_s == 'label' and cur_node[0].to_s == key
		#puts "Yes: type: #{cur_node.type}, value: #{cur_node[0]}"
		#$locals_nodes.push(cur_node.parent)
		return cur_node.parent
	elsif cur_node.type.to_s == 'ident' and cur_node[0].to_s == key
		#puts "#{cur_node.parent.parent.parent.source}"
		return cur_node.parent.parent.parent
		#puts "No: type: #{cur_node.type}, value: #{cur_node[0]}"
	end
	cur_node.children.each do |child|	
	   if parse_render_variables(child, key)
	   		return parse_render_variables(child, key)
	   end
	end
	return nil
end		
# l = parse_render_variables(ast.ast, 'locals')
# $hash_table = {}
# parse_locals_hash(l)

# collection = parse_render_variables(ast.ast, 'collection')
# var_col = collection[1][0].source

# as = parse_render_variables(ast.ast, 'as')
# var_as = as[1][0][0][0]


def parse_locals_hash(cur_node)
	if cur_node
		if cur_node.type.to_s == "hash"
			puts "HASH"
			cur_node.children.each do |child|
				if child.type.to_s == "assoc"
					k = child[0].source.gsub(':','')
					v = child[1].source
					$hash_table[k] = v

				puts "Child Source: #{k } #{child.type}"
				end
			end
		end
		cur_node.children.each do |child|	
		   if parse_locals_hash(child)
		   	 parse_locals_hash(child)
		   end
		end
	end
end	
#Input: ProjectsController
#Output: projects
#Input: My::ProjectsController
#Output: my::projects
#Input: AuthSourcesController
#Output: auth_sources 
def helper_downcase(str)
	state = 0
	char_array = []
	str.split("").each do |c|
		if c == c.capitalize and state == 1
			char_array.push('_')
			char_array.push(c.downcase)
		else
			state = 1
			char_array.push(c.downcase)
		end
	end
	return char_array.join("")
end
def get_controller_downcase(controller_name)
	return "" unless controller_name.include?"Controller"
	
	#return controller_name.downcase.gsub("controller","")
	str = controller_name.gsub("Controller", "")
	if str.include?"::"
		chs = str.split("::")
		word_array = []
		chs.each do |c|
			word_array.push(helper_downcase(c))
		end
		return word_array.join("::")
	else
		state = 0
		str = helper_downcase(str)
		return str	
	end
end
