require 'pathname'
require 'find'

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
	#if cmd.include?("mkdir")
	#	puts "command = #{cmd}"
	#end
	system(cmd)
end

def same_file(f1, f2)
	#TODO: replace this with ruby path_equal function
	return f1.gsub('/','') == f2.gsub('/','')
end
