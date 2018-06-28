import util

def print_branch_on_query_stats(roots, stats_file, args):
	data = {}
	tags = []
	cond_list = args['prefix'][:]
	tags = util.collectAllTags(roots, cond_list)
	print tags
	for t in tags:
		cond_list = args['prefix'][:]
		cond_list.append(t)
		r = util.calculateAllActions(roots, cond_list)
		data[t] = sum(r)#util.getAverage(r)

	stats_file.write("\t<branchOnQueryType>\n")
	for k,v in data.items():
		stats_file.write("\t\t<%s>%f</%s>\n"%(k,v,k))
	stats_file.write("\t</branchOnQueryType>\n")

