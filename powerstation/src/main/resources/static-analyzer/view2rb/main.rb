require 'optparse'
require 'pathname'
require 'find'
require 'yard'


def os_walk(dir)
  root = Pathname(dir)
  files, dirs = [], []
  puts "#{root}"
  Pathname(root).find do |path|
    unless path == root
      dirs << path if path.directory?
      files << path if path.file?
    end
  end
  [root, files, dirs]
end

def run_command(cmd)
	system(cmd)
end

def same_file(f1, f2)
	#TODO: replace this with ruby path_equal function
	return f1.gsub('/','') == f2.gsub('/','')
end

def read_view_files
	root, files, dirs = os_walk($view_dir)
	for filename in files
		if filename.to_s.end_with?(".haml") 	
			run_command("python3 haml2html.py #{filename}")
			filename = filename.replace('haml', 'html.erb')
		end
		if filename.to_s.end_with?("html.erb") 
			new_file_name = filename.to_s.gsub($view_folder_name, $new_view_folder_name).gsub('html.erb', 'rb')
			tmp = new_file_name + ".tmp"
			view_path = new_file_name.gsub(File.basename(new_file_name),'')
			puts "VIEWPATH #{view_path}"
			run_command("mkdir -p #{view_path}")
			run_command("#{$extract_ruby_script} #{filename} #{tmp}")
			fp = File.open(tmp, "r")
			wp = File.open(new_file_name, 'w+')
			contents = fp.read
			function = filename.to_s.split(/views/)[1].split('.')[0].gsub("/", "_")
			fc = "def #{function}\n"
			for l in contents.lines
				fc += "\t#{l}"
			end
			fc += "end\n"
			wp.write(fc)
			run_command("rm #{tmp}")
			#puts contents
			ast = YARD::Parser::Ruby::RubyParser.parse(fc).root
				
		end
	end
end

options = {}
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: ruby main.rb [OPTIONS]"

	opt.on("-a","--application APP",String,"Application name","example: -a redmine") do |app|
		options[:application] = app
		$app_name = app
	end
	
	opt.on("-m","--haml","Is Haml code","example: -m") do |haml|
		options[:haml] = true
	end
end

opt_parser.parse!
$view_folder_name = "views"
$new_view_folder_name = "rb_view"
$extract_ruby_script = "./extract_ruby"
if true
	$path_prefix = "../applications/#{options[:application]}/"
	$view_dir = "../applications/#{options[:application]}/#{$view_folder_name}/"
	$new_view_dir = "../applications/#{options[:application]}/#{$new_view_folder_name}/"
	run_command("rm -rf #{$new_view_dir}")
	run_command("mkdir #{$new_view_dir}")
	read_view_files
end