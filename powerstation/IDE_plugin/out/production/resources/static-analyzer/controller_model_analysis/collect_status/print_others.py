import util

def print_query_overlap(roots, stats_file, args):
	cond_list = args['prefix'][:]
	r = util.calculateCount(roots, cond_list)	
	d	= []
	for k,v in r.items():
		d.append(int(k, 10))
	d.sort(reverse=True)
	stats_file.write("\t<queryOverlap>\n")
	left = args['readTotal']
	for i in d:
		stats_file.write("\t\t<variableHas%dQs>%d</variableHas%dQs>\n"%(i+1, r[str(i)], i+1))
	#left -= (r[str(i)])
	stats_file.write("\t</queryOverlap>\n")


def print_redundant_table(roots, stats_file, args):
	cond_list = args['prefix'][:]
	tables = util.collectAllTags(roots, cond_list)	
	data = {}
	print tables
	for t in tables:
		cond_list = args['prefix'][:]
		cond_list.append(t)
		r = util.calculateAllActions(roots, cond_list, to_float=False)
		data[t] = len(r)

	stats_file.write("\t<redundantTable>\n")
	for k,v in data.items():
		stats_file.write("\t\t<%s>%d</%s>\n"%(k,v,k))
	stats_file.write("\t</redundantTable>\n")

def print_redundant_rows(roots, stats_file, args):
	cond_list = args['prefix']
	stats_file.write("\t<queryOnlyToQuery>\n")
	if args['plot_loop']:
		[r, r_loop] = util.calculateAllActions(roots, cond_list, count_loop=True)
		d1 = float(sum(r)-sum(r_loop))
		d2 = float(sum(r_loop))
		d3 = float(args['readTotal']-args['readInClosure']-d1)
		d4 = float(args['readInClosure']-d2)
		
		stats_file.write("\t\t<otherNoLoop>%f</otherNoLoop>\n"%(d3/float(len(roots))))
		stats_file.write("\t\t<queryOnlyToQueryNoLoop>%f</queryOnlyToQueryNoLoop>\n"%(d1/float(len(roots))))
		stats_file.write("\t\t<otherInLoop>%f</otherInLoop>\n"%(d4/float(len(roots))))
		stats_file.write("\t\t<queryOnlyToQueryInLoop>%f</queryOnlyToQueryInLoop>\n"%(d2/float(len(roots))))
	else:
		r = util.calculateAllActions(roots, cond_list)
		stats_file.write("\t\t<queryOnlyToQuery>%f</queryOnlyToQuery>\n"%(float(sum(r))/float(len(roots))))
		stats_file.write("\t\t<other>%f</other>\n"%(float(args['readTotal']-sum(r))/float(len(roots))))
			
	stats_file.write("\t</queryOnlyToQuery>\n")

def print_query_cards(roots, stats_file, args):
	stats_file.write("\t<queryCard>\n")
	if args['plot_loop']:
		cond_list = args['prefix_limited'][:]
		[r_limited, r_limited_loop] = util.calculateAllActions(roots, cond_list, count_loop=True)
		print r_limited
		print r_limited_loop
		cond_list = args['prefix_scale'][:]
		[r_scale, r_scale_loop] = util.calculateAllActions(roots, cond_list, count_loop=True)
		d1 = float(sum(r_scale)-sum(r_scale_loop))
		d2 = float(sum(r_scale_loop))
		d3 = float(sum(r_limited) - sum(r_limited_loop))
		d4 = float(sum(r_limited_loop))
		
		stats_file.write("\t\t<boundedNoLoop>%f</boundedNoLoop>\n"%(d3/float(len(roots))))
		stats_file.write("\t\t<unboundedNoLoop>%f</unboundedNoLoop>\n"%(d1/float(len(roots))))
		stats_file.write("\t\t<boundedInLoop>%f</boundedInLoop>\n"%(d4/float(len(roots))))
		stats_file.write("\t\t<unboundedInLoop>%f</unboundedInLoop>\n"%(d2/float(len(roots))))
	else:
		cond_list = args['prefix_limited'][:]
		r_limited = util.calculateAllActions(roots, cond_list)
		cond_list = args['prefix_scale'][:]
		r_scale = util.calculateAllActions(roots, cond_list)

		stats_file.write("\t\t<scaleCard>%f</scaleCard>\n"%(float(sum(r_scale))/float(len(roots))))
		stats_file.write("\t\t<limitedCard>%f</limitedCard>\n"%(float(sum(r_limited))/float(len(roots))))
	stats_file.write("\t</queryCard>\n")

def print_redundant_fields(roots, stats_file, args):
	totalF = 0
	usedF = 0
	for root in roots:
		for child in root:
			if child.tag == args['prefix'][0]:
				for c in child:
					totalF += int(c.attrib["totalFieldSize"], 10)
					usedF += int(c.text, 10)
	stats_file.write("\t<redundantField>\n")
	stats_file.write("\t\t<unused>%f</unused>\n"%(float(totalF-usedF)/float(args['readTotal'])))
	stats_file.write("\t\t<used>%f</used>\n"%(float(usedF)/float(args['readTotal'])))
	stats_file.write("\t</redundantField>\n")

def print_query_partial(roots, stats_file, args):
	queries = 0
	queries_in_loop = 0
	for root in roots:
		for child in root:
			if child.tag == args['prefix'][0]:
				for c in child:
					queries += (int(c.text, 10))
					if c.attrib["in_loop"]:
						queries_in_loop = int(c.attrib["in_loop"], 10)
	
	stats_file.write("\t<queryPartial>\n")
	if args['plot_loop']:
		d1 = float(queries) - float(queries_in_loop)
		d2 = float(queries_in_loop)
		d3 = float(args['readTotal'] - args['readInClosure']) - d1
		d4 = float(args['readInClosure']) - d2
		
		stats_file.write("\t\t<noOverlapNoLoop>%f</noOverlapNoLoop>\n"%(d3/float(len(roots))))
		stats_file.write("\t\t<partialOverlapNoLoop>%f</partialOverlapNoLoop>\n"%(d1/float(len(roots))))
		stats_file.write("\t\t<noOverlapInLoop>%f</noOverlapInLoop>\n"%(d4/float(len(roots)))) 
		stats_file.write("\t\t<partialOverlapInLoop>%f</partialOverlapInLoop>\n"%(d2/float(len(roots))))
	else:
		stats_file.write("\t\t<partialOverlapQ>%f</partialOverlapQ>\n"%(float(queries)/float(len(roots))))
		stats_file.write("\t\t<noOverlapQ>%f</noOverlapQ>\n"%(float(args['readTotal']-queries)/float(len(roots))))
	stats_file.write("\t</queryPartial>\n")
