import sys
import glob
import os

base_path = "./"
result_dir = "../applications/unknown_functions/"
if os.path.isdir(result_dir) == False:
	os.system("mkdir %s"%result_dir)

for subdir, folders, files in os.walk(base_path):
	for fn in files:
		if fn.endswith("run.log"):
			fname = os.path.join(subdir, fn)
			fp = open(fname,'r')
			unknown_list = []
			unknown_map = {}
			app = fn.replace("_run.log","") 
			for line in fp:
				if line.startswith("function ") and line.endswith(" cannot be found\n"):
					chs = line.split(" ")
					words = chs[1].split('.')
					if chs[1] not in unknown_list and len(words) > 1:
						unknown_list.append(chs[1])
						if words[0] not in unknown_map: 
							unknown_map[words[0]] = []
						unknown_map[words[0]].append(words[1])

			output_fname = "%s/%s.txt"%(result_dir, app)
			of = open(output_fname, "w")
			for k,v in unknown_map.items():
				for v1 in v:
					of.write("%s.%s\n"%(k,v1))
				of.write("\n")


