import util

def print_general_stats(roots, stats_file, args):
	data = {}
	data_std = {}
	for g in args['contents']:
		cond_list = args['prefix'][:] #prefix[:]
		cond_list.append(g)
		r = util.calculateAllActions(roots, cond_list)
		data[g] = util.getAverage(r)
		data_std[g] = util.getStd(r)

	stats_file.write("\t<queryGeneral>\n")
	stats_file.write("\t\t<readQuery>%f</readQuery>\n"%(data["readTotal"]))
	#stats_file.write("\t\t<readTotal>%d</readTotal>\n"%(data["readTotal"]*len(roots)))
	stats_file.write("\t\t<writeQuery>%f</writeQuery>\n"%(data["writeTotal"]))
	#stats_file.write("\t\t<writeTotal>%d</writeTotal>\n"%(data["writeTotal"]*len(roots)))
	stats_file.write("\t</queryGeneral>\n")

	stats_file.write("\t<queryInLoop>\n")
	stats_file.write("\t\t<queryInLoop>%f</queryInLoop>\n"%(data["queryInClosure"]))
	stats_file.write("\t\t<queryNotInLoop>%f</queryNotInLoop>\n"%(data["readTotal"]+data["writeTotal"]-data["queryInClosure"]))
	stats_file.write("\t</queryInLoop>\n")
	
	return [data['queryTotal']*len(roots), data['readTotal']*len(roots), data['queryInClosure']*len(roots), data['queryReadInClosure']*len(roots)]
