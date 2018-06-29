require "benchmark"
require 'yard'
require 'logger'

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

#file = File.open("../applications/railscollab/models/milestone.rb", "r")
#file = File.open("../applications/publify/merged_controllers/admin/content_controller.rb", "r")
file = File.open("../applications/redmine/models/wiki_content.rb","r")
#file = File.open("../applications/redmine/ruby_views/welcome/index.html.erb", "r")
#file = File.open("../applications/lobsters/merged_controllers/stories_controller.rb", "r")
#file = File.open("../../communityengine/app/controllers/event_sweeper.rb", "r")
contents = file.read
ast = YARD::Parser::Ruby::RubyParser.parse(contents).root

def traverse_ast(astnode, level)
	@blank = ""
	for i in (0...level)
		@blank = @blank + "   "
	end
	print "#{@blank}level #{level}, #{astnode.type} [[#{astnode.class.to_s}]]"
	if astnode.source.length < 30
		puts " -> #{astnode.source}"
	else
		puts " range #{astnode.source_range}"
	end
	astnode.children.each do |child|
		traverse_ast(child, level+1)
	end
end

traverse_ast(ast, 0)
