import util

def print_field_order(roots, stats_file, args):
	data = {}
	cond_list = args['prefix'][:]
	r = util.collectByAttribute(roots, cond_list, "fieldn", ["sz"])
	stats_file.write("\t<fieldOrderByName>\n")
	for k,v in r.items():
		#k: main_attrib
		#v: [text, [other_attribs]]
		#count distinct of text
		orders = []
		for v1 in v:
			if v1[0] not in orders:
				orders.append(v1[0])
		stats_file.write("\t\t<%s>%d</%s>\n"%(k, len(orders), k))
	stats_file.write("\t</fieldOrderByName>\n")

	
	#r = collectByAttribute(roots, cond_list, "sz", ["fieldn"])
	#stats_file.write("\t<fieldOrderBySize>\n")

def print_field_assignment(roots, stats_file, args):
	cond_list = args['prefix'][:]
	fields = util.collectAllTags(roots, cond_list)
	print "fields = "
	print fields
	field_const = []
	field_funcdep = []
	field_no_input = []
	data = {}
	for f in fields:
		cond_list = args['prefix'][:]
		cond_list.append(f)
		r = util.calculateAllActions(roots, cond_list, to_float=False)
		only_from_const = True
		only_from_otherq = True
		for k in r:
			if k != None and ("query" in k or "util_func" in k or "user_input" in k):
				only_from_const = False
				break
		for k in r:
			if k != None and ("user_input" in k or "util_func" in k or "const" in k):
				only_from_otherq = False
				break
		if only_from_const:
			field_const.append(f)
		if only_from_otherq:
			field_funcdep.append(f)
		uses_user_input = False
		for k in r:
			if k != None and "user_input" in k:
				uses_user_input = True
				break
		if uses_user_input == False:
			field_no_input.append(f)
	
	for f in args['tableFields']:
		if f not in fields:
			field_no_input.append(f)
			if "created_at" not in f and "updated_at" not in f and "created_on" not in f and "updated_on" not in f:
				chs = f.split(".")
				if chs[1] != "id":
					field_const.append(f)

	stats_file.write("\t<fieldOnlyConst>\n")
	stats_file.write("\t\t<onlyConst>%d</onlyConst>\n"%len(field_const))
	stats_file.write("\t\t<onlyOtherQuery>%d</onlyOtherQuery>\n"%len(field_funcdep))
	stats_file.write("\t\t<otherWithoutInput>%d</otherWithoutInput>\n"%(len(field_no_input)-len(field_const)))
	stats_file.write("\t\t<hasInput>%d</hasInput>\n"%(len(args['tableFields'])-len(field_no_input)))
	stats_file.write("\t</fieldOnlyConst>\n")

	stats_file.write("\t<fieldNoInput>\n")
	stats_file.write("\t\t<noInput>%d</noInput>\n"%len(field_no_input))
	stats_file.write("\t\t<hasInput>%d</hasInput>\n"%(len(args['tableFields'])-len(field_no_input)))
	stats_file.write("\t</fieldNoInput>\n")

	
