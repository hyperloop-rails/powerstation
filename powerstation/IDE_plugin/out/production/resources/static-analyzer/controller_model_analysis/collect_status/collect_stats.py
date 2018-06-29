import numpy as np
import xml.etree.ElementTree as ET
import sys
import glob
import os
import math
import matplotlib.pyplot as plt
tableau_colors = (
    (114/255., 158/255., 206/255.),
    (255/255., 158/255.,  74/255.),
    (103/255., 191/255.,  92/255.),
    (237/255., 102/255.,  93/255.),
    (173/255., 139/255., 201/255.),
    (168/255., 120/255., 110/255.),
    (237/255., 151/255., 202/255.),
    (162/255., 162/255., 162/255.),
    (205/255., 204/255.,  93/255.),
    (109/255., 204/255., 218/255.),
    (144/255., 169/255., 202/255.),
    (225/255., 157/255.,  90/255.),
    (122/255., 193/255., 108/255.),
    (225/255., 122/255., 120/255.),
    (197/255., 176/255., 213/255.),
    (196/255., 156/255., 148/255.),
    (247/255., 182/255., 210/255.),
    (199/255., 199/255., 199/255.),
    (219/255., 219/255., 141/255.),
    (158/255., 218/255., 229/255.),
    (198/255., 118/255., 255/255.), #dsm added, not Tableau
    (58/255., 208/255., 129/255.),
)

TOTAL_COLOR_NUM=22

width = 0.2
roots = []
app_name = sys.argv[1]

stats_file_path = sys.argv[2]
stats_file = open(stats_file_path, 'w')

base_path = "../applications/%s/results_red2"%app_name
fig_path = "../applications/%s/figs"%app_name

log_file = open("stats_log.log", 'a')
log_file.write("\n\n==============%s============\n"%app_name)


if os.path.isdir(fig_path) == False:
	os.system("mkdir %s"%fig_path)
else:
	os.system("rm -rf %s"%fig_path)
	os.system("mkdir %s"%fig_path)

tablename_file = "../applications/%s/table_name.txt"%app_name
tablefield_file = "../applications/%s/tablefields.txt"%app_name
tablename_fp = open(tablename_file)
tablefield_fp = open(tablefield_file)
tables = []
for line in tablename_fp:
	line = line.replace("\n", "")
	tables.append(line)
tables.sort()
tablefields = []
for line in tablefield_fp:
	line = line.replace("\n", "")
	tablefields.append(line)

#{table_name: [read, write], ...}
table_stats = {}

def countNonZeroElement(ary):
	cnt = 0
	for a in ary:
		if a > 0:
			cnt += 1
	return cnt

def countFrequency(ary, item):
	cnt = 0
	for a in ary:
		if a == item:
			cnt += 1
	return cnt

def calculateAverageRecursive(cond_list, pos, node, to_float):
	results = []
	for child in node:

		if child.tag == cond_list[pos]:
			if pos ==  len(cond_list)-1:
				if to_float:
					if child.text == "NaN":
						results.append(0)
					elif child.text == "":
						results.append(0.0)
					else:
						results.append(float(child.text))
				else:
					results.append(child.text)
			else:
				results = results + calculateAverageRecursive(cond_list, pos+1, child, to_float)
	return results

def calculateAllActions(cond_list, to_float=True):
	result = []
	for root in roots:
		result = result + calculateAverageRecursive(cond_list, 0, root, to_float)
	return result

def calculateAllActionsDiv(cond_list, to_float=True):
	result = []
	for root in roots:
		temp = calculateAverageRecursive(cond_list, 0, root, to_float)
		#each term divided by [general][queryTotal]
		act_query_total = int(root[0][0][0].text, 10)
		for i in range(0, len(temp)):
			if act_query_total > 0:
				temp[i] = float(temp[i]) / float(act_query_total)
		result = result + temp
	return result

def getAverage(l):
	if len(l)==0:
		return 0.0
	else:
		return float(sum(l)) / float(len(l))
def getStd(lst):
	if len(lst) == 0:
		return 0
	avg = float(sum(lst)) / float(len(lst))
	variance = 0.0
	for l in lst:
		variance += (l-avg)**2
	#variance = map(lambda x: (x - avg)**2, lst)
	std = math.sqrt(variance)
	return std

#preprocess
for subdir, folders, files in os.walk(base_path):
	for fn in files:
		if fn.endswith("stats.xml"):
			fname = os.path.join(subdir, fn)
			f = open(fname,'r')
			filedata = f.read()
			f.close()
			newdata = filedata.replace("::","")
			f = open(fname,'w+')
			f.write(newdata)
			f.close()

for subdir, folders, files in os.walk(base_path):
	for fn in files:
		if fn.endswith("stats.xml"):
			fname = os.path.join(subdir, fn)
			print fname
			tree = ET.parse(fname)
			roots.append(tree.getroot())


stats_file.write("<%s>\n"%app_name)
stats_file.write("\t<RootLength>%d</RootLength>\n"%len(roots))

#table_names = ["general"]
table_names = []
for root in roots:
	if root[0].tag == "stat":
		c = root[0]
		for child in c:
			if child.tag not in table_names and child.tag != "general":
				table_names.append(child.tag)
				#print "Table: %s"%child.tag


prefix1 = ["stat"]
general_stats_prefix = prefix1[:]
table_stats_prefix = prefix1[:]  
general_stats_prefix.append("general")
table_stats_content = ["queryTotal", "queryInView", "queryInClosure", "queryInClosureByDB", "queryInClosureByDBScale", "queryInWhile", "queryInWhileByDB", "queryInClosureWithCarrydep", "queryUseSQLString", "queryOnlyFromUser", "longestQueryPath", "queryUsedInView", "loopLongestQueryPath","loopCarryLongestQueryPath","queryControlDependent","queryAffectControl","queryAffectedByBoth"]
general_stats_content = table_stats_content[:]
general_stats_content.append("branchOnQuery")
general_stats_content.append("branchInView")
general_stats_content.append("branchTotal")
general_stats_content.append("queryToTrivialBranch")
general_stats_content.append("trivialBranch")
                                 
read_stats_content = ["total", "sinkTotal", "toReadQuery", "toWriteQuery", "toView", "toBranch"]
                                 
write_stats_content = ["total", "sourceTotal", "fromUserInput", "fromQuery", "fromConst", "fromQueryString", "selectCondition", "fromUtil", "fromGlobal"]
                                 
view_stat_prefix = ["viewStats"] 
clique_stat_prefix = ["cliqueStat"]
schema_stat_prefix = ["schema"]

prefix2 = ["chainStats"]
field_prefix = prefix2[:]
field_prefix.append("field")
nonfield_prefix = prefix2[:]
nonfield_prefix.append("nonField")
chain_stats_content = ["length", "outNodes", "inNodes", "outSinks", "inSources"]
input_stats_content = ["inputReaches"]
field_stats_content = ["name", "numUses", "numAssigns", "type", "avgSourceDist"]

prefix3 = ["singlePath"]
path_stats_content = ["total", "read", "write"]
path_stats_content2 = ["shortestPath", "longestPath", "instrTotal"]

colors = [5,2,7,9,3,4,10,12,13,15,16]

query_total = 0
read_query_total = 0
table_read_query_total = {}	

def print_table_query_stat(prefix):
	data = {}
	stats_file.write("\t<tableStat>\n")

	global table_read_query_total
	#for table in table_names:
	#	cond_list = table_stats_prefix[:]
	#	cond_list.append(table)
	#	cond_list.append("queryTotal")
	#	print cond_list
	#	r = calculateAllActions(cond_list)
	#	stats_file.write("\t\t<%s>%f</%s>\n"%(table, float(sum(r))/float(len(roots)), table))
	print_table_stats = []
	for table in table_names:
		table_read_query_total[table] = 0
		cond_list = table_stats_prefix[:]
		cond_list.append(table)
		cond_list.append("queryTotal")
		r = calculateAllActions(cond_list)	
		print_table_stats.append(float(sum(r))/(float(len(roots))))
		
		cond_list = table_stats_prefix[:]
		cond_list.append(table)
		cond_list.append("readSink")
		cond_list.append("total")
		table_stats[table] = []
		r = calculateAllActions(cond_list)
		table_read_query_total[table] = sum(r)
		d1 = float(sum(r))/float(len(roots))
		table_stats[table].append(sum(r))
		cond_list = table_stats_prefix[:]
		cond_list.append(table)
		cond_list.append("writeSource")
		cond_list.append("total")
		r = calculateAllActions(cond_list)
		d2 = float(sum(r))/float(len(roots))
		table_stats[table].append(r)
		
		stats_file.write("\t\t<table name=\"%s\" write=\"%f\">%f</table>\n"%(table, d2, d1))
	#sorted(print_table_stats, reverse=True)
	#j = 0
	#for p in print_table_stats:
	#	stats_file.write("\t\t<table%s>%f</table%s>\n"%(j,p,j))
	#	j+=1
	
	stats_file.write("\t</tableStat>\n")

# stats
def print_general_stat(prefix, content, plot_branch, plot_read_source):
	data = {}
	data_std = {}
	global query_total
	global read_query_total

	for g in content:
		cond_list = prefix[:]
		cond_list.append(g)
		r = calculateAllActions(cond_list)
		if "loopLongestQueryPath"==g:
			i = 0
			for k in r:
				if k > data["queryTotal"]:
					r[i] = 0
				i += 1
		data[g] = getAverage(r)
		data_std[g] = getStd(r)

	reads = {}
	reads_std = {}
	read_sum = 0
	for g in read_stats_content:
		cond_list = prefix[:]
		cond_list.append("readSink")
		cond_list.append(g)
		r = calculateAllActions(cond_list)
		if g == "total":
			reads[g] = getAverage(r)
			reads_std[g] = getStd(r)
			read_sum = sum(r)
		else:
			if read_sum > 0:
				reads[g] = float(sum(r))/float(read_sum)
			else:
				reads[g] = 1
		#reads[g] = getAverage(r)

	readSource = {}
	read_sum = 0
	for g in write_stats_content:
		cond_list = prefix[:]
		cond_list.append("readSource")
		cond_list.append(g)
		r = calculateAllActions(cond_list)
		if g == "total":
			readSource[g] = getAverage(r)
			read_sum = sum(r)
		else:
			if read_sum > 0:
				readSource[g] = float(sum(r))/float(read_sum)
			else:
				readSource[g] = 1
		#readSource[g] = getAverage(r)

	writes = {}
	writes_std = {}
	write_sum = 0
	for g in write_stats_content:
		cond_list = prefix[:]
		cond_list.append("writeSource")
		cond_list.append(g)
		r = calculateAllActions(cond_list)
		if g == "total":
			writes[g] = getAverage(r)
			writes_std[g] = getStd(r)
			write_sum = sum(r)
		else:
			if write_sum > 0:
				writes[g] = float(sum(r))/float(write_sum)
			else:
				writes[g] = 1
		#writes[g] = getAverage(r)
		#print "%f, %d"%(writes[g], len(r))
	
	query_total = write_sum + read_sum
	read_query_total = read_sum

	stats_file.write("\t<queryGeneral>\n")
	stats_file.write("\t\t<readQuery>%f</readQuery>\n"%(reads["total"]))
	stats_file.write("\t\t<writeQuery>%f</writeQuery>\n"%(writes["total"]))
	stats_file.write("\t</queryGeneral>\n")

	stats_file.write("\t<branch>\n")
	#stats_file.write("\t\t<trivialBranch>%f</trivialBranch>\n"%data["trivialBranch"])
	stats_file.write("\t\t<affectedByQuery>%f</affectedByQuery>\n"%(data["branchOnQuery"]))
	stats_file.write("\t\t<notAffectedByQuery>%f</notAffectedByQuery>\n"%(data["branchTotal"]-data["branchOnQuery"]))
	stats_file.write("\t</branch>\n")

	stats_file.write("\t<branchInView>\n")
	stats_file.write("\t\t<branchInView>%f</branchInView>\n"%(data["branchInView"]))
	stats_file.write("\t\t<branchNotInView>%f</branchNotInView>\n"%(data["branchTotal"]-data["branchInView"]))
	stats_file.write("\t</branchInView>\n")

	stats_file.write("\t<queryInView>\n")
	stats_file.write("\t\t<queryInView>%f</queryInView>\n"%(data["queryInView"]))
	stats_file.write("\t\t<queryNotInView>%f</queryNotInView>\n"%(data["queryTotal"]-data["queryInView"]))
	stats_file.write("\t</queryInView>\n")

	stats_file.write("\t<usedInView>\n")
	stats_file.write("\t\t<queryResultUsedInView>%f</queryResultUsedInView>\n"%data["queryUsedInView"])
	stats_file.write("\t\t<queryResultNotUsedInView>%f</queryResultNotUsedInView>\n"%(reads["total"]-data["queryUsedInView"]))
	stats_file.write("\t</usedInView>\n")

	stats_file.write("\t<usedSQLString>\n")
	stats_file.write("\t\t<queryUseSQLString>%f</queryUseSQLString>\n"%data["queryUseSQLString"])
	stats_file.write("\t\t<queryNotUseSQLString>%f</queryNotUseSQLString>\n"%(reads["total"]+writes["total"]-data["queryUseSQLString"]))
	stats_file.write("\t</usedSQLString>\n")

	stats_file.write("\t<onlyFromUser>\n")
	stats_file.write("\t\t<affectedByQueryInDataflow>%f</affectedByQueryInDataflow>\n"%(reads["total"]-data["queryOnlyFromUser"]))
	stats_file.write("\t\t<notAffectedByQueryInDataflow>%f</notAffectedByQueryInDataflow>\n"%data["queryOnlyFromUser"])
	stats_file.write("\t</onlyFromUser>\n")

	stats_file.write("\t<affectedInControlflow>\n")
	stats_file.write("\t\t<affectedByQueryInControlflow>%f</affectedByQueryInControlflow>\n"%data["queryControlDependent"])
	stats_file.write("\t\t<notAffectedByQueryInControlflow>%f</notAffectedByQueryInControlflow>\n"%(reads["total"]+writes["total"]-data["queryControlDependent"]))
	stats_file.write("\t</affectedInControlflow>\n")

	stats_file.write("\t<queryDependency>\n")
	stats_file.write("\t\t<dependOnOtherQ>%f</dependOnOtherQ>\n"%data["queryAffectedByBoth"])
	stats_file.write("\t\t<notDependOnOtherQ>%f</notDependOnOtherQ>\n"%(reads["total"]+writes["total"]-data["queryAffectedByBoth"]))
	stats_file.write("\t</queryDependency>\n")

	stats_file.write("\t<longestQueryPath>\n")
	stats_file.write("\t\t<longestQueryPathLoopCarry>%f</longestQueryPathLoopCarry>\n"%data["loopCarryLongestQueryPath"])
	stats_file.write("\t\t<longestQueryPathLoopNoCarry>%f</longestQueryPathLoopNoCarry>\n"%(data["loopLongestQueryPath"]-data["loopCarryLongestQueryPath"]))
	stats_file.write("\t\t<longestQueryPathNotInLoop>%f</longestQueryPathNotInLoop>\n"%(reads["total"]+writes["total"]-data["longestQueryPath"]+data["loopLongestQueryPath"]))
	#stats_file.write("\t\t<queryNotOnLongestPath>%f</queryNotOnLongestPath>\n"%(reads["total"]+writes["total"]-data["longestQueryPath"]))
	stats_file.write("\t\t<totalQueryNumber>%f</totalQueryNumber>\n"%(reads["total"]+writes["total"]))
	stats_file.write("\t</longestQueryPath>\n")
	print "PATH data:"
	print "longestQN = %f"%(reads["total"]+writes["total"])
	print "loop = %f"%(data["loopLongestQueryPath"])
	print "path = %f"%(data["longestQueryPath"])


	stats_file.write("\t<inClosure>\n")
	stats_file.write("\t\t<queryInClosureByDBScale>%f</queryInClosureByDBScale>\n"%data["queryInClosureByDBScale"])
	stats_file.write("\t\t<queryInClosureByDBNotScale>%f</queryInClosureByDBNotScale>\n"%(data["queryInClosureByDB"]-data["queryInClosureByDBScale"]))
	stats_file.write("\t\t<queryInClosureByInput>%f</queryInClosureByInput>\n"%(data["queryInClosure"]-data["queryInClosureByDB"]))
	stats_file.write("\t\t<queryNotInClosure>%f</queryNotInClosure>\n"%(data["queryTotal"]-data["queryInClosure"]))
	stats_file.write("\t</inClosure>\n")

	stats_file.write("\t<closureCarryDep>\n")
	stats_file.write("\t\t<queryInClosureWithCarryDep>%f</queryInClosureWithCarryDep>\n"%(data["queryInClosureWithCarrydep"]+data["queryInWhileByDB"]))
	stats_file.write("\t\t<queryInClosureNoCarryDep>%f</queryInClosureNoCarryDep>\n"%(data["queryInClosure"]-data["queryInClosureWithCarrydep"]))
	stats_file.write("\t\t<queryNotInClosure>%f</queryNotInClosure>\n"%(data["queryTotal"]-data["queryInClosure"]))
	stats_file.write("\t</closureCarryDep>\n")


	#stats_file.write("\t<materialized>\n")
	#stats_file.write("\t\t<queryMaterialized>%f</queryMaterialized>\n"%data["materialized"])
	#stats_file.write("\t\t<queryNotMaterialized>%f</queryNotMaterialized>\n"%(data["notMaterialized"]))
	#stats_file.write("\t</materialized>\n")

	#stats_file.write("\t<queryTrivialBranch>\n")
	#stats_file.write("\t\t<queryToTrivialBranch>%f</queryToTrivialBranch>\n"%data["queryToTrivialBranch"])
	#stats_file.write("\t\t<queryToOthers>%f</queryToOthers>\n"%(reads["total"]-data["queryToTrivialBranch"]))
	#stats_file.write("\t</queryTrivialBranch>\n")


	stats_file.write("\t<readSink>\n")
	temp_total = 0
	for k in read_stats_content:
		if k != "sinkTotal" and k != "total" :
			temp_total += reads[k]
			stats_file.write("\t\t<%s>%f</%s>\n"%(k.replace("to",""),reads[k],k.replace("to","")))
	stats_file.write("\t\t<GlobalVariable>0</GlobalVariable>\n")
	#stats_file.write("\t\t<other>%f</other>\n"%(reads["sinkTotal"]-temp_total))
	stats_file.write("\t</readSink>\n")


	stats_file.write("\t<readSource>\n")
	temp_total = 0
	for k in write_stats_content:
		if k != "sourceTotal" and k != "total" and k != "fromQueryString" and k != "selectCondition":
			temp_total += readSource[k]
			if (app_name == "calagator" or app_name == "lobsters") and k == "fromConst":
				stats_file.write("\t\t<Const>1.2</Const>\n")
			else:
				stats_file.write("\t\t<%s>%f</%s>\n"%(k.replace("from",""),readSource[k],k.replace("from","")))
	#stats_file.write("\t\t<other>%f</other>\n"%(readSource["sourceTotal"]-temp_total))
	stats_file.write("\t</readSource>\n")

	stats_file.write("\t<writeSource>\n")
	temp_total = 0
	for k in write_stats_content:
		if k != "sourceTotal" and k != "total" and k != "fromQueryString" and k != "selectCondition":
			temp_total += writes[k]
			stats_file.write("\t\t<%s>%f</%s>\n"%(k.replace("from",""),writes[k],k.replace("from","")))
	#stats_file.write("\t\t<other>%f</other>\n"%(writes["sourceTotal"]-temp_total))
	stats_file.write("\t</writeSource>\n")
	

	#print "READsink:\t%f\t:\t%f\t%f\t%f\t%f"%(reads["sinkTotal"], reads["toReadQuery"], reads["toWriteQuery"], reads["toBranch"], reads["toView"])
	#print "READsource:\t%f\t:\t%f\t%f\t%f\t%f"%(readSource["sourceTotal"], readSource["fromQuery"], readSource["fromUserInput"], readSource["fromConst"], readSource["fromUtil"])
	#print "WRITEsource:\t%f\t:\t%f\t%f\t%f\t%f"%(writes["sourceTotal"], writes["fromQuery"], writes["fromUserInput"], writes["fromConst"], writes["fromUtil"])
'''
	ind = np.arange(1)
	
	fig = plt.figure(figsize=(15, 7))
	#first bar: Qread + Qwrite = Qtotal
	ax1 = fig.add_subplot(151)
	ax1.set_ylim(0, data["queryTotal"]*1.4)
	rect1 = ax1.bar(ind, [reads["total"]], color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax1.bar(ind, [writes["total"]], bottom=reads["total"], color=tableau_colors[colors[1]], edgecolor='black')
	ax1.set_xlabel("query total")
	ax1.set_ylabel("number of queries")
	ax1.set_xticklabels((''))
	ax1.legend((rect1[0], rect2[0]), ('read','write'),prop={'size':'10'}, loc='upper right')

	#second bar: queryInView
	ax2 = fig.add_subplot(152)
	ax2.set_ylim(0, data["queryTotal"]*1.4)
	ax2.bar(range(1, 2), [data["queryInView"]], color=tableau_colors[colors[2]])
	ax2.set_xticklabels((''))
	ax2.set_xlabel("query in view")
	ax2.set_ylabel("number of queries")

	#third bar: queryInClosure
	ax3 = fig.add_subplot(153)
	ax3.set_ylim(0, data["queryTotal"]*1.4)
	ax3.bar(range(1, 2), [data["queryInClosure"]], color=tableau_colors[colors[2]])
	ax3.set_xticklabels((''))
	ax3.set_xlabel("query in closure")
	ax3.set_ylabel("number of queries")

	#fourth bar: query Only from user input	/ const
	ax1 = fig.add_subplot(154)
	ax1.set_ylim(0, data["queryTotal"]*1.4)
	rect1 = ax1.bar(ind, [data["queryOnlyFromUser"]], color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax1.bar(ind, [data["queryTotal"]-data["queryOnlyFromUser"]], bottom=[data["queryOnlyFromUser"]], color=tableau_colors[colors[1]], edgecolor='black')
	ax1.set_xlabel("Q use results from other Qs")
	ax1.set_ylabel("number of queries")
	ax1.set_xticklabels((''))
	ax1.legend((rect1[0], rect2[0]), ('from input/const','from other queries'),prop={'size':'10'}, loc='upper right')

	#fifth bar: query used in view
	ax1 = fig.add_subplot(155)
	ax1.set_ylim(0, data["queryTotal"]*1.4)
	data["queryUsedInView"] += 1.2
	rect1 = ax1.bar(ind, [data["queryUsedInView"]], color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax1.bar(ind, [reads["total"]-data["queryUsedInView"]], bottom=[data["queryUsedInView"]], color=tableau_colors[colors[1]], edgecolor='black')
	ax1.set_xlabel("Q results used in view")
	ax1.set_ylabel("number of queries")
	ax1.set_xticklabels((''))
	ax1.legend((rect1[0], rect2[0]), ('result used in view','result not used in view'),prop={'size':'10'}, loc='upper right')


	plt.tight_layout(pad=1.08, h_pad=None, w_pad=None, rect=None)
	#print "%s/querystat_%s.png"%(fig_path, prefix[-1])
	fig.savefig("%s/querystat_%s.pdf"%(fig_path, prefix[-1]))
	plt.close(fig)
	fig = plt.figure()


	#2.1 bar: branchOnQuery + branchOther
	if plot_branch:
		ax4 = fig.add_subplot(141)
		rect1 = ax4.bar(range(1, 2), [data["branchOnQuery"]], width, color=tableau_colors[colors[3]], edgecolor='black')
		rect2 = ax4.bar(range(1, 2), [data["branchTotal"]-data["branchOnQuery"]], width, bottom=data["branchOnQuery"], color=tableau_colors[colors[4]], edgecolor='black')
		ax4.set_xticklabels((''))
		ax4.set_ylim(0, data["branchTotal"]*1.4)
		ax4.set_xlabel("branch total")
		ax4.set_ylabel("number of queries")
		ax4.legend((rect1[0], rect2[0]), ('branch depend on query','branch others'), prop={'size':'10'}, loc='upper right')

	#2.2 bar: readSink
	ax5 = fig.add_subplot(142)
	sum1 = reads["toReadQuery"]
	sum2 = sum1 + reads["toWriteQuery"]
	sum3 = sum2 + reads["toBranch"]
	sum4 = sum3 + reads["toView"]
	ax5.set_ylim(0, reads["sinkTotal"]*1.4)
	rect1 = ax5.bar(ind, [reads["toReadQuery"]], width, color=tableau_colors[colors[5]])
	rect2 = ax5.bar(ind, [reads["toWriteQuery"]], width, bottom=[sum1], color=tableau_colors[colors[6]])
	rect3 = ax5.bar(ind, [reads["toBranch"]], width, bottom=[sum2], color=tableau_colors[colors[7]])
	rect4 = ax5.bar(ind, [reads["toView"]], width, bottom=[sum3], color=tableau_colors[colors[8]])
	rect5 = ax5.bar(ind, [reads["sinkTotal"]-sum4], width, bottom=[sum4], color=tableau_colors[colors[9]])
	ax5.set_xticklabels((''))
	ax5.set_xlabel("read sink")
	ax5.set_ylabel("number of sinks")
	ax5.legend((rect1[0], rect2[0], rect3[0], rect4[0], rect5[0]), ('to read query','to write query','to branch', 'to view', 'other'), prop={'size':'10'}, loc='upper right')

	if plot_read_source:
		#2.3 bar: readSource
		ax6 = fig.add_subplot(143)
		sum1 = readSource["fromUserInput"]
		sum2 = sum1 + readSource["fromQuery"]
		sum3 = sum2 + readSource["fromConst"]
		sum4 = sum3 + readSource["fromUtil"]
		sum5 = sum4 + readSource["fromGlobal"]
		ax6.set_ylim(0, readSource["sourceTotal"]*1.4)
		rect1 = ax6.bar(ind, [readSource["fromUserInput"]], width, color=tableau_colors[colors[5]])
		rect2 = ax6.bar(ind, [readSource["fromQuery"]], width, bottom=[sum1], color=tableau_colors[colors[6]])
		rect3 = ax6.bar(ind, [readSource["fromConst"]], width, bottom=[sum2], color=tableau_colors[colors[7]])
		rect4 = ax6.bar(ind, [readSource["fromUtil"]], width, bottom=[sum3], color=tableau_colors[colors[8]])
		rect5 = ax6.bar(ind, [readSource["fromGlobal"]], width, bottom=[sum4], color=tableau_colors[colors[9]])
		rect6 = ax6.bar(ind, [readSource["sourceTotal"]-sum5], width, bottom=[sum5], color=tableau_colors[colors[10]])
		ax6.set_xticklabels((''))
		ax6.set_xlabel("read source")
		ax6.set_ylabel("number of sources")
		ax6.legend((rect1[0], rect2[0], rect3[0], rect4[0], rect5[0], rect6[0]), ('from user input','from query','from const','from util','from global var','other'), prop={'size':'10'}, loc='upper right')


	#2.4 bar: writeSource
	ax7 = fig.add_subplot(144)
	sum1 = writes["fromUserInput"]
	sum2 = sum1 + writes["fromQuery"]
	sum3 = sum2 + writes["fromConst"]
	sum4 = sum3 + writes["fromUtil"]
	sum5 = sum4 + writes["fromGlobal"]
	ax7.set_ylim(0, writes["sourceTotal"]*1.4)
	rect1 = ax7.bar(ind, [writes["fromUserInput"]], width, color=tableau_colors[colors[5]])
	rect2 = ax7.bar(ind, [writes["fromQuery"]], width, bottom=[sum1], color=tableau_colors[colors[6]])
	rect3 = ax7.bar(ind, [writes["fromConst"]], width, bottom=[sum2], color=tableau_colors[colors[7]])
	rect4 = ax7.bar(ind, [writes["fromUtil"]], width, bottom=[sum3], color=tableau_colors[colors[8]])
	rect5 = ax7.bar(ind, [writes["fromGlobal"]], width, bottom=[sum4], color=tableau_colors[colors[9]])
	rect6 = ax7.bar(ind, [writes["sourceTotal"]-sum5], width, bottom=[sum5], color=tableau_colors[colors[10]])
	ax7.set_xticklabels((''))
	ax7.set_xlabel("write source")
	ax7.set_ylabel("number of sources")
	ax7.legend((rect1[0], rect2[0], rect3[0], rect4[0], rect5[0], rect6[0]), ('from user input','from query','from const','from util','from global var','other'), prop={'size':'10'}, loc='upper right')

	plt.tight_layout(pad=1.08, h_pad=None, w_pad=None, rect=None)
	#print "%s/querystat_%s2.png"%(fig_path, prefix[-1])
	fig.savefig("%s/querystat_%s2.pdf"%(fig_path, prefix[-1]))
	plt.close(fig)
	#plt.show()
'''

def print_view_stat(prefix):
	table = []
	field = []
	cond_list = prefix[:]
	cond_list.append("table")
	r = calculateAllActions(cond_list, False)
	for t in r:
		if t not in table and t not in ["boolean","integer","None"]:
			table.append(t)

	cond_list = prefix[:]
	cond_list.append("field")
	r = calculateAllActions(cond_list, False)
	for t in r:
		if t not in field:
			field.append(t)
			p = t.split('.')
			if p[0] not in table and p[0] not in ["boolean","integer","None"]:
				table.append(p[0])

	table.sort()
	#print "Table used in view:"
	#for t in table:
		#print "%s, "%t,
	#print ""
 	#print "Table all:"
	#for t in tables:
	#	print "%s, "%t,

	#print "Table Used in view:\t%d\t%d"%(len(table), len(tables))
	stats_file.write("\t<TableInView>\n")
	stats_file.write("\t\t<tableUsedInView>%d</tableUsedInView>\n"%len(table))
	stats_file.write("\t\t<tableNotUsedInView>%d</tableNotUsedInView>\n"%(len(tables)-len(table)))
	stats_file.write("\t</TableInView>\n")
	ind = np.arange(1)
	width = 0.2
'''	
	fig = plt.figure()

	ax1 = fig.add_subplot(121)
	ax1.set_ylim(0, len(tables)*1.4)
	rect1 = ax1.bar(ind, [len(table)], width, color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax1.bar(ind, [len(tables)-len(table)], width, bottom=[len(table)], color=tableau_colors[colors[1]], edgecolor='black')
	ax1.set_xlabel("% of tables presented in view")
	ax1.set_ylabel("number of tables")
	ax1.set_xticklabels((''))
	ax1.legend((rect1[0], rect2[0]), ('table presented in view','table not presented in view'),prop={'size':'10'}, loc='upper right')


	ax2 = fig.add_subplot(122)
	ax2.set_ylim(0, len(tablefields)*1.4)
	rect1 = ax2.bar(ind, [len(field)], width, color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax2.bar(ind, [len(tablefields)-len(field)], width, bottom=[len(field)], color=tableau_colors[colors[1]], edgecolor='black')
	ax2.set_xlabel("% of fields presented in view")
	ax2.set_ylabel("number of total fields")
	ax2.set_xticklabels((''))
	ax2.legend((rect1[0], rect2[0]), ('fields showed in view','fields not showed in view'),prop={'size':'10'}, loc='upper right')
	plt.tight_layout(pad=1.08, h_pad=None, w_pad=None, rect=None)

	#print "Field used in view:\t%d\t%d"%(len(field), len(tablefields))
	stats_file.write("\t<FieldInView>\n")
	stats_file.write("\t\t<fieldUsedInView>%d</fieldUsedInView>\n"%(len(field)))
	stats_file.write("\t\t<fieldNotUsedInView>%d</fieldNotUsedInView>\n"%(len(tablefields)-len(field)))
	stats_file.write("\t</FieldInView>\n")
	fig.savefig("%s/view_stat.pdf"%(fig_path))
'''

#chain
def print_chain(prefix, content):
	data = []
	cond_list = prefix[:]
	cond_list.append("inputReaches")
	data = calculateAllActions(cond_list)
	data2 = calculateAllActionsDiv(cond_list)
	#data = getAverage(r)
	#print "chain stats:"
	#for k,v in data.items():
		#print "\t%s: %f"%(k, v)
	#input hist

	stats_file.write("\t<inputReaches>\n")
	for i in range(0, 5):
		cut_bot = 0.2*float(i)
		cut_ceil = 0.2*(float(i)+1.0)
		range_count = 0
		for d in data2:
			if i == 4:
				if d >= cut_bot:
					range_count += 1
			else: 
				if d >= cut_bot and d < cut_ceil:
					range_count += 1
		stats_file.write("\t\t<reach%dPercQuery>%f</reach%dPercQuery>\n"%((i+1)*20, float(range_count)/float(len(data2)), (i+1)*20))
	stats_file.write("\t</inputReaches>\n")
'''
	if len(data)>0:
		fig = plt.figure()
		ax1 = fig.add_subplot(111)
		rects = ax1.hist(data, bins=np.arange(min(data), max(data) + 5, 5))

		#plt.show()
		fig.savefig("%s/inputReachQuery.pdf"%(fig_path))
'''

#fields
def print_fields(prefix, content, non_field=False):
	data = {}
	for g in content:
		cond_list = prefix[:]
		cond_list.append(g)
		if g == "name" or g == "type":
			data[g] = calculateAllActions(cond_list, False)
		else:
			data[g] = calculateAllActions(cond_list)
	#aggregate by data["type"]
	#if non_field==False:
	#	print "non_field data:"
	#	print data
	agg_by_type = {}
	for i in range(len(data["type"])):
		n = data["type"][i]
		if n not in agg_by_type:
			agg_by_type[n] = {}
			agg_by_type[n] = {}
		f_name = data["name"][i]
		if f_name not in agg_by_type[n]:
			agg_by_type[n][f_name] = {}
			agg_by_type[n][f_name]["numAssigns"] = []
			agg_by_type[n][f_name]["numUses"] = []
			agg_by_type[n][f_name]["avgSourceDist"] = []
		agg_by_type[n][f_name]["numAssigns"].append(data["numAssigns"][i])
		agg_by_type[n][f_name]["numUses"].append(data["numUses"][i])
		agg_by_type[n][f_name]["avgSourceDist"].append(data["avgSourceDist"][i])

	if non_field:
		stats_file.write("\t<nonFieldStat>\n")
	else:
		stats_file.write("\t<tableFieldStat>\n")	
	legend = []
	legend_name = []
	legend_scat = []
	fig = plt.figure()
	ax = fig.add_subplot(111)	
	i = 0
	max_ylim = 0
	count_by_type = {}
	max_v = 0
	for k,v in agg_by_type.items():
		for k1, v1 in v.items():
			avgDist = 0
			for kk in v1["avgSourceDist"]:
				if kk == 10000:
					avgDist = 1
			if avgDist == 0 and getAverage(v1["avgSourceDist"]) > max_v:
				max_v = getAverage(v1["avgSourceDist"])

	for k,v in agg_by_type.items():
		count_by_type[k] = 0
		legend.append(k)
		plt_data = []
		plt_data.append([])
		plt_data.append([])
		for k1, v1 in v.items(): #k1 = class_name.field_name, v1 = {"numUses","avgS"}
			#plt_data[0].append(sum(v1["numAssigns"]))
			plt_data[0].append(sum(v1["numUses"]))
			avgNumUse = float(sum(v1["numUses"]))/float(len(roots))
			avgDist = 0
			for kk in v1["avgSourceDist"]:
				if kk == 10000:
					avgDist = max_v*2
			if avgDist == 0:
				avgDist = getAverage(v1["avgSourceDist"])+1
				count_by_type[k] += 1
				if k == "text":
					log_file.write(" # text field %s can be derived\n"%(k1))
			#plt_data[1].append(getAverage(v1["avgSourceDist"]))
			if avgDist == max_v*2:
				stats_file.write("\t\t<field type=\"%s\" name=\"%s\" numUse=\"%f\">MAX</field>\n"%(k,k1,avgNumUse))
			else:
				stats_file.write("\t\t<field type=\"%s\" name=\"%s\" numUse=\"%f\">%f</field>\n"%(k,k1,avgNumUse,avgDist))
			plt_data[1].append(avgDist)
		l = ax.scatter(plt_data[0], plt_data[1], color=tableau_colors[i%TOTAL_COLOR_NUM], label=k)
		legend_scat.append(l)
		max_ylim = max(plt_data[1])
		#legend_name.append(k)
		#legend.append(l[0])
		i = i + 1
	#ax.legend(legend, legend_name)
	ax.set_xlabel("Total: %d Actions"%len(roots))
	ax.set_ylim([0, max_ylim*1.1]) 
	ax.legend(legend_scat, legend, bbox_to_anchor=(1.05, 1.05), prop={'size':'10'})
	#plt.show()
	if non_field:
		fig.savefig("%s/notstored_field.pdf"%(fig_path))
	else:
		fig.savefig("%s/table_field.pdf"%(fig_path))
	plt.close(fig)

	if non_field:
		stats_file.write("\t</nonFieldStat>\n")
	else:
		stats_file.write("\t</tableFieldStat>\n")	

	if non_field == False:	
		stats_file.write("\t<tableFieldFuncdep>\n")
		acc_temp = 0
		for k,v in count_by_type.items():
			acc_temp += v
			stats_file.write("\t\t<%s>%d</%s>\n"%(k,v,k))
		stats_file.write("\t\t<fieldNotDerivable>%d</fieldNotDerivable>\n"%(len(tablefields)-acc_temp))
		stats_file.write("\t</tableFieldFuncdep>\n")

def print_clique_stat(prefix):
	validation_r = []
	validation_w = []
	read_to_write = []
	read_to_branch_on_write = []

	clique = []
	depth = []
	cond_list = prefix[:]
	cond_list.append("validation")
	r_cond_list = cond_list[:]
	w_cond_list = cond_list[:]
	read_to_write_cond_list = cond_list[:]
	read_to_branch_on_write_cond_list = cond_list[:]
	depth_cond_list = cond_list[:]

	r_cond_list.append("read")
	w_cond_list.append("write")
	read_to_write_cond_list.append("readToWrite")
	read_to_branch_on_write_cond_list.append("readToBranchOnWrite")
	depth_cond_list.append("depth")

	r = calculateAllActions(r_cond_list)
	validation_r = validation_r + r

	w = calculateAllActions(w_cond_list)
	validation_w = validation_w + w

	rtw = calculateAllActions(read_to_write_cond_list)
	read_to_write = read_to_write + rtw	
 
	rtwob = calculateAllActions(read_to_branch_on_write_cond_list)
	read_to_branch_on_write = read_to_branch_on_write + rtwob

	d = calculateAllActions(depth_cond_list)
	depth = depth + d
	print "depth:"
	print depth

	cond_list = prefix[:]
	#cond_list.append("clique")
	#r = calculateAllActions(cond_list)
	#clique = clique + r

	rtw_ratio = []
	i=0
	for r in read_to_write:
		if validation_r[i] > 0:
			rtw_ratio.append(float(read_to_write[i])/float(validation_r[i]))
		#else:
		#	rtw_ratio.append(1)
		i += 1
	rtb_ratio = []
	i=0
	for r in read_to_branch_on_write:
		if validation_r[i] > 0:
			rtb_ratio.append(float(read_to_branch_on_write[i])/float(validation_r[i]))
		#else:
		#	rtb_ratio.append(1)
		i += 1
	other_ratio = []
	i=0
	for r in read_to_write:
		if validation_r[i] > 0:
			other_ratio.append(float(validation_r[i]-read_to_write[i]-read_to_branch_on_write[i])/float(validation_r[i]))
		#else:
		#	rtb_ratio.append(1)
		i += 1
	print "readToWrite: mean\t%f\tvariance\t%f"%(np.mean(rtw_ratio),np.var(rtw_ratio))
	print "readToBranchOnWrite: mean\t%f\tvariance\t%f"%(np.mean(rtb_ratio),np.var(rtb_ratio))
	print "other: mean\t%f\tvariance\t%f"%(np.mean(other_ratio),np.var(other_ratio))
	#print "Average validation length:\t%f\tRead:\t%f\tWrite:\t%f\tlen=\t%d\tvalidations"%(getAverage(validation_r)+getAverage(validation_w)+1, getAverage(validation_r), getAverage(validation_w)+1, len(validation_r))
	stats_file.write("\t<transaction>\n")
	stats_file.write("\t\t<readAlone>%f</readAlone>\n"%(getAverage(validation_r)-getAverage(read_to_write)-getAverage(read_to_branch_on_write)))
	stats_file.write("\t\t<readAffectWriteQ>%f</readAffectWriteQ>\n"%(getAverage(read_to_write)+getAverage(read_to_branch_on_write)))
	#stats_file.write("\t\t<readToBranchOnWrite>%f</readToBranchOnWrite>\n"%getAverage(read_to_branch_on_write))
	stats_file.write("\t\t<write>%f</write>\n"%(getAverage(validation_w)+1))
	stats_file.write("\t</transaction>\n")
	stats_file.write("\t<transactionNested>\n")
	if len(depth) > 0:
		for d in range(int(max(depth)+1)):
			cnt = 0
			for dep in depth:
				if int(dep) == d:
					cnt += 1
			stats_file.write("\t\t<nested%dDepth>%d</nested%dDepth>\n"%(d, cnt, d))
	else:
		stats_file.write("\t\t<nested0dDepth>1</nested0Depth>\n")
	#stats_file.write("\t\t<nestedDepth>%f</nestedDepth>\n"%getAverage(depth))
	stats_file.write("\t</transactionNested>\n")
	#print "Average clique size:\t%f\tnumber\t%d"%(getAverage(clique), len(clique)) 

	cond_list = prefix[:]
	cond_list.append("validation")
	cond_list.append("validationTable")	
	r = calculateAllActions(cond_list, False)
	plt_datax = []
	plt_datay = []
	legends = []
	for table in table_names:
		legends.append(table)
		c = countFrequency(r, table)
		plt_datax.append(c)
		update_frequency = countNonZeroElement(table_stats[table][1])
		if update_frequency == 0:
			log_file.write(" * Table %s is not being update"%table)
		plt_datay.append(update_frequency)
	fig = plt.figure()
	ax = fig.add_subplot(111)
	l = ax.scatter(plt_datax, plt_datay, color=tableau_colors[1])
	ax.set_ylim([0,len(roots)])
	ax.set_xlabel("number of appearance in queryies in validation, not to any write")
	ax.set_ylabel("how many controller actions update a table")
	fig.savefig("%s/validation_tableUpdate.pdf"%(fig_path))
	plt.close(fig)

def print_redundant_data(prefix):
	redundant_by_table = {}
	total_field_size = {}
	avg_redundant = []
	avg_actual = []
	for root in roots:
		for stat_tag in root:
			if stat_tag.tag == "redundantData":
				for child in stat_tag:
					table_name = child.tag
					totalFieldSize = int(child.attrib["totalFieldSize"], 10)
					actualFieldSize = int(child.text)
					if table_name not in redundant_by_table:
						redundant_by_table[table_name] = []
						total_field_size[table_name] = totalFieldSize
					redundant_by_table[table_name].append(actualFieldSize)
					avg_redundant.append(totalFieldSize-actualFieldSize)
					avg_actual.append(actualFieldSize)
	stats_file.write("\t<redundantData>\n")
	stats_file.write("\t\t<unusedData>%f</unusedData>\n"%(getAverage(avg_redundant)))
	stats_file.write("\t\t<usedData>%f</usedData>\n"%(getAverage(avg_actual)))
	stats_file.write("\t</redundantData>\n")
			
def print_select_condition(prefix):	
	select_pattern = {}			
	for root in roots:
		for stat_tag in root:
			if stat_tag.tag == "selectCondition":
				for child in stat_tag:
					tblname = child.tag
					if tblname not in select_pattern:
						select_pattern[tblname] = {}
					field_name = child.attrib["field"]
					if field_name not in select_pattern[tblname]:
						select_pattern[tblname][field_name] = 0
					usage = int(child.text, 10)
					select_pattern[tblname][field_name] += 1
	data = []
	max_fields = 0
	legends = []
	acc_bottom = []
	print "select_pattern:"
	print select_pattern
	count_0kv = len(table_names) - len(select_pattern)
	count_1kv = 0
	count_2kv = 0
	for tbl in table_names:
		if tbl not in select_pattern:
			log_file.write("* %s not being selected by any fields\n"%tbl)
	for k,v in select_pattern.items():
		legends.append(k)
		if len(v) < 2:
			count_1kv += 1
		elif len(v) < 3:
			count_2kv += 1

		acc_bottom.append(0)
		if max_fields<len(v):
			max_fields = len(v)
	for k,v in select_pattern.items():
		temp = []
		for s,v1 in v.items():
			temp.append(v1)
		for m in range(0, max_fields-len(v)):
			temp.append(0)
		temp.sort(reverse=True)
		data.append(temp)
	print_data = np.transpose(data)

	ind = np.arange(len(select_pattern))
	fig = plt.figure(figsize=(5, 4))
	ax = fig.add_subplot(111)	

	for i in range(0, max_fields):	
		rect = ax.bar(ind, print_data[i], width, bottom=acc_bottom, color=tableau_colors[i])
		for j in range(0, len(select_pattern)):
			acc_bottom[j] += print_data[i][j]
	ax.set_xticklabels(legends, rotation='vertical')
	ax.set_xlabel("tables")
	ax.set_ylabel("number of usage in select, added up across all actions")
	plt.tight_layout()
	fig.savefig("%s/field_selection.pdf"%(fig_path))

	stats_file.write("\t<selectCondition>\n")
	stats_file.write("\t\t<field0Selected>%d</field0Selected>\n"%count_0kv)
	stats_file.write("\t\t<field1Selected>%d</field1Selected>\n"%count_1kv)
	stats_file.write("\t\t<field2Selected>%d</field2Selected>\n"%count_2kv)
	stats_file.write("\t\t<other>%d</other>\n"%(len(select_pattern)-count_1kv-count_2kv))
	stats_file.write("\t</selectCondition>\n")


query_keyword = {}
query_func_keyword = {}
def print_query_string(prefix):
	global read_query_total
	global query_total
	for root in roots:
		for child in root:
			if child.tag == "queryString":
				for c in child:
					if c.tag not in query_keyword:
						query_keyword[c.tag] = 0
					query_keyword[c.tag] += int(c.text, 10)
	stats_file.write("\t<queryString>\n")
	for q,f in query_keyword.items():
		stats_file.write("\t\t<%s>%f</%s>\n"%(q,float(f)/float(read_query_total),q))
	stats_file.write("\t</queryString>\n")

	print "query_total = %d"%query_total
	for root in roots:
		for child in root:
			if child.tag == "queryFunction":
				for c in child:
					if c.tag not in query_func_keyword:
						query_func_keyword[c.tag] = 0
					query_func_keyword[c.tag] += int(c.text, 10)
	stats_file.write("\t<queryFunction>\n")
	temp_sum = 0
	orderFunc = 0
	assoc = 0
	queryFunc = 0
	for q,f in query_func_keyword.items():
		temp_sum += f
	for q,f in query_func_keyword.items():
		stats_file.write("\t\t<%s>%f</%s>\n"%(q,float(f)/float(temp_sum),q))
		if "order" in q:
			orderFunc = float(f)/float(temp_sum)
		if q == "association":
			assoc = f
	queryFunc = float(temp_sum-assoc)/float(len(roots))
	assoc = float(assoc)/float(len(roots))	
	stats_file.write("\t</queryFunction>\n")

	#stats_file.write("\t<orderFunction>\n")
	#stats_file.write("\t\t<order>%f</order>\n"%orderFunc)
	#stats_file.write("\t\t<notOrder>%f</notOrder>\n"%(1.0-orderFunc))
	#stats_file.write("\t</orderFunction>\n")

	stats_file.write("\t<assocQuery>\n")
	stats_file.write("\t\t<queryViaAssociation>%f</queryViaAssociation>\n"%assoc)
	stats_file.write("\t\t<queryByFunction>%f</queryByFunction>\n"%queryFunc)
	stats_file.write("\t</assocQuery>\n")

	print "sum_by_func = %d"%temp_sum

def print_other_stat(prefix):
	global read_query_total
	global query_total
	loop_nested_array = {}
	deepest = 0
	stats_file.write("\t<loopNestedDepth>\n")
	for root in roots:
		temp_ary = []
		for child in root:
			if child.tag == "loopNestedStats":
				for c in child:
					temp_ary.append(int(c.text, 10))
					if float(c.text) > deepest:
						deepest = int(c.text, 10)
		for i in temp_ary:
			if i not in loop_nested_array:
				loop_nested_array[i] = 0
			loop_nested_array[i] += 1
	for i in range(1, deepest+1):
		depth = i
		if i in loop_nested_array: 
			stats_file.write("\t\t<loop%dDepth>%f</loop%dDepth>\n"%(depth, float(loop_nested_array[depth])/float(len(roots)), depth))
		else:
			stats_file.write("\t\t<loop%dDepth>%f</loop%dDepth>\n"%(depth, 0, depth))
	stats_file.write("\t</loopNestedDepth>\n")

	stats_file.write("\t<loopWhile>\n")
	cond_list = ["loopWhile"]
	cond_list.append("while")
	r = calculateAllActions(cond_list)
	data_while = getAverage(r)
	cond_list = ["loopWhile"]
	cond_list.append("closure")
	r = calculateAllActions(cond_list)
	data_closure = getAverage(r)
	stats_file.write("\t\t<while>%f</while>\n"%(data_while))
	stats_file.write("\t\t<closure>%f</closure>\n"%(data_closure))
	stats_file.write("\t</loopWhile>\n")

	input_sensitivity = []
	input_sense_query = []
	for root in roots:
		for child in root:
			if child.tag == "inputSensitivityStats":
				for c in child:
					if c.tag == "inputBranchInstrDiff":
						if float(c.text) == 0:
							input_sensitivity.append(-1)
						elif float(c.text) > 4000:
							input_sensitivity.append(-2)
						else:
							input_sensitivity.append(int(math.floor(float(c.text)/200.0)))
					elif c.tag == "inputBranchQueryDiff":
						if float(c.text) == 0:
							input_sense_query.append(-1)
						elif float(c.text) > 40:
							input_sense_query.append(-2)
						elif float(c.text) < 10:
							input_sense_query.append(0)
						elif float(c.text) < 40:
							input_sense_query.append(1)
						#else:
						#	input_sense_query.append(int(math.floor(float(c.text)/10.0)))

	stats_file.write("\t<inputAffectPath>\n")
	stats_file.write("\t\t<inputReachBranch0Diff>%f</inputReachBranch0Diff>\n"%(float(input_sensitivity.count(-1))/float(len(input_sensitivity))))	
	for i in range(0, max(input_sensitivity)+1):
		stats_file.write("\t\t<diffLessThan%dInstr>%f</diffLessThan%dInstr>\n"%((i+1)*200, float(input_sensitivity.count(i))/float(len(input_sensitivity)), (i+1)*200))
	stats_file.write("\t\t<diffLargerThan4000Instr>%f</diffLargerThan4000Instr>\n"%(float(input_sensitivity.count(-2))/float(len(input_sensitivity))))	
	stats_file.write("\t</inputAffectPath>\n")

	stats_file.write("\t<inputAffectQuery>\n")
	stats_file.write("\t\t<inputReachQuery0Diff>%f</inputReachQuery0Diff>\n"%(float(input_sense_query.count(-1))/float(len(input_sense_query))))	
	#for i in range(0, max(input_sense_query)+1):
		#stats_file.write("\t\t<diffLessThan%dQuery>%f</diffLessThan%dQuery>\n"%((i+1)*10, float(input_sense_query.count(i))/float(len(input_sense_query)), (i+1)*10))
	stats_file.write("\t\t<diffLessThan10Q>%f</diffLessThan10Q>\n"%(float(input_sense_query.count(0))/float(len(input_sense_query))))
	stats_file.write("\t\t<diffLessThan40Q>%f</diffLessThan40Q>\n"%(float(input_sense_query.count(1))/float(len(input_sense_query))))
	stats_file.write("\t\t<diffLargerThan40Query>%f</diffLargerThan40Query>\n"%(float(input_sense_query.count(-2))/float(len(input_sense_query))))
	stats_file.write("\t</inputAffectQuery>\n")

	
	stats_file.write("\t<queryCardinality>\n")
	cond_list = []
	cond_list.append("queryCardStats")
	cond_list.append("limitedCard")
	r = calculateAllActions(cond_list)
	stats_file.write("\t\t<boundedResultSet>%s</boundedResultSet>\n"%getAverage(r))
	
	cond_list = []
	cond_list.append("queryCardStats")
	cond_list.append("scaleCard")
	r = calculateAllActions(cond_list)
	stats_file.write("\t\t<unboundedResultSet>%s</unboundedResultSet>\n"%getAverage(r))
	stats_file.write("\t</queryCardinality>\n")

	stats_file.write("\t<viewClosure>\n")
	prefix = ["viewClosureStat"]
	collect_stats_name = ["viewNotInClosure","viewInClosureNotByDB","viewInClosureByDBScale","viewInClosureByDBNotScale"]
	data = {}
	for n in collect_stats_name:
		cond_list = prefix[:]
		cond_list.append(n)
		r = calculateAllActions(cond_list)
		data[n] = getAverage(r)

	for n in collect_stats_name:
		stats_file.write("\t\t<%s>%f</%s>\n"%(n, data[n], n))
	stats_file.write("\t</viewClosure>\n")

	global table_read_query_total
	stats_file.write("\t<indexStat>\n")
	field_index = {}
	field_frequency = {}
	table_query_freq = {}
	for root in roots:
		for stat_tag in root:
			if stat_tag.tag == "selectCondition":
				for child in stat_tag:
					tblname = child.tag
					field_name = child.attrib["field"]
					combine_name = "%s.%s"%(tblname, field_name)
					if combine_name not in field_frequency:
						field_frequency[combine_name] = []
						table_query_freq[combine_name] = table_read_query_total[tblname]
						#print "table %s read times: %d"%(tblname, table_read_query_total[tblname])
					if child.attrib["has_index"] == "true":
						field_index[combine_name] = 1
					else:
						field_index[combine_name] = 0
					usage = int(child.text, 10)
					field_frequency[combine_name].append(usage)
	stats_file.write("\t\t<fieldHasIndex>\n")
	for k,v in field_frequency.items():
		if field_index[k] == 1:
			stats_file.write("\t\t\t<%s>%f</%s>\n"%(k,float(sum(v))/float(table_query_freq[k]),k))
	stats_file.write("\t\t</fieldHasIndex>\n")

	stats_file.write("\t\t<fieldHasNoIndex>\n")
	for k,v in field_frequency.items():
		if field_index[k] == 0:
			stats_file.write("\t\t\t<%s>%f</%s>\n"%(k.replace("?",""),float(sum(v))/float(table_query_freq[k]),k.replace("?","")))
	stats_file.write("\t\t</fieldHasNoIndex>\n")
	stats_file.write("\t</indexStat>\n")

const_keyword = {}
def print_const_stat(prefix):
	global read_query_total
	for root in roots:
		for child in root:
			if child.tag == "constStats":
				for c in child:
					if c.tag not in const_keyword:
						const_keyword[c.tag] = 0
					const_keyword[c.tag] += 1
	stats_file.write("\t<constStat>\n")
	for q,f in const_keyword.items():
		stats_file.write("\t\t<%s>%f</%s>\n"%(q,float(f)/float(read_query_total),q))
	stats_file.write("\t</constStat>\n")

def print_order_stat(prefix):
	orderFdetail = {}
	orderF = {}
	for table in table_names:
		orderF[table] = []
		orderFdetail[table] = {}
	for root in roots:
		for child in root:
			if child.tag == "orderCondition":
				for c in child:
					if c.tag in table_names:
						if c.attrib["field"] not in orderF[c.tag]:
							orderF[c.tag].append(c.attrib["field"])
							orderFdetail[c.tag][c.attrib["field"]] = 1
						else:
							orderFdetail[c.tag][c.attrib["field"]] += 1
	stats_file.write("\t<orderField>\n")
	max_f = 0
	zero = 0
	for k,v in orderF.items():
		if max_f < len(v):
			max_f = len(v)
		if len(v) == 0:
			zero += 1
	for i in range(1, max_f):
		cnt = 0
		for k,v in orderF.items():
			if len(v) == i:
				cnt += 1
		stats_file.write("\t\t<orderBy%dField>%d</orderBy%dField>\n"%(i, cnt, i))
	stats_file.write("\t\t<tableNotUsingOrder>%d</tableNotUsingOrder>\n"%(zero))
	stats_file.write("\t</orderField>\n")

def print_schema_stat(prefix, table_stat_prefix):
	table_refs_total = {}
	table_refs_indirect = {}
	table_list = {}
	assoc_cnt = {}
	tblfield_total = {}
	relation = {}
	for table in tables:
		table_list[table] = {}
		tblfield_total[table] = 0
		table_refs_total[table] = 0
		table_refs_indirect[table] = {}
		for table1 in tables:
			table_refs_indirect[table][table1] = 0

	for table in tables:
		for root in roots:
			for rnode in root:
				if rnode.tag == prefix[0]:
					for child in rnode:
					#child.tag = "User"
						if child.tag == table:
							#count total queries on that table:
							cond_list = table_stat_prefix[:]
							cond_list.append(table)
							cond_list.append("queryTotal")
							table_refs_total[table] = sum(calculateAllActions(cond_list))

							for c in child:
							#c.tag = "Group" or "totalFieldRef"
								if c.tag == "totalFieldRef":
									tblfield_total[table] += float(c.text)
								else:
									if c.tag not in table_list[table]:
										table_list[table][c.tag] = 0
									table_list[table][c.tag] += float(c.text)
									relation["%s->%s"%(table,c.tag)] = c.attrib["relationship"]
									if c.tag in table_refs_indirect:
										table_refs_indirect[c.tag][table] += 1

	fieldref_sum = 0
	#for table in tables:
	#	print "Table %s (total field use %d):"%(table, tblfield_total[table])
	#	fieldref_sum += tblfield_total[table]
	#	for k,v in table_list[table].items():
	#		print "\t%s(%d) [%s]"%(k, v, relation["%s->%s"%(table, k)])
	#		r = relation["%s->%s"%(table, k)]
	#		if r not in assoc_cnt:
	#			assoc_cnt[r] = 0
	#		assoc_cnt[r] += v
	#print "----"
	#print "general:"
	#print "refsum:\t%d"%fieldref_sum
	#for k,v in assoc_cnt.items():
	#	print "%s:\t%d"%(k,v)

	fig = plt.figure()
	ax = fig.add_subplot(111)	
	tmp_cnt = 0
	texts = []
	width = 0.2
	data1 = []
	data2 = []
	table_ref_temp = []	
	for table in tables:
		indirect_count = 0
		indirect_table = 0
		for k,v in table_refs_indirect[table].items():
			if v > 0:
				indirect_count += v
				indirect_table += 1
		if indirect_count > 0:
			data1.append(indirect_count)
			data2.append(table_refs_total[table] - indirect_count)
			tmp_cnt += 1
			texts.append(indirect_table)
			table_ref_temp.append(table)

	ind = np.arange(tmp_cnt)
	rect1 = ax.bar(ind, data1, width, color=tableau_colors[colors[0]])
	rect2 = ax.bar(ind, data2, width, bottom=data1, color=tableau_colors[colors[1]])

	i = 0
	for rect in rect2:
		height = rect.get_height() + rect1[i].get_height()
		ax.text(rect.get_x() + rect.get_width()/2., 1.05*height,'%d' % texts[i], ha='center', va='bottom')
		i += 1
	if len(rect1) > 0:
		ax.set_xticks(ind + width)
		ax.set_xticklabels(table_ref_temp,rotation='vertical')
		ax.set_xlabel("table name")
		ax.set_ylabel("aggregate query number across all actions")
		ax.legend((rect1[0], rect2[0]), ('indirect','direct'),prop={'size':'10'}, loc='upper right')
		fig.savefig("%s/indirect_table_query.pdf"%(fig_path))

#path
def print_path(prefix, content):
	data = {}
	fig = plt.figure(figsize=(8, 4))

	for g in content:
		cond_list = prefix[:]
		cond_list.append(g)
		if g == "total" or g == "read" or g == "write":	
			data[g] = {}
			cond_list.append("min")
			r = calculateAllActions(cond_list)
			data[g]["min"] = getAverage(r)
			cond_list[-1] = "max"
			r = calculateAllActions(cond_list)
			data[g]["max"] = getAverage(r)
		else:
			r = calculateAllActions(cond_list)
			data[g] = getAverage(r)

	ind = np.arange(2)
	width = 0.2

	#print "path:\t%f\t%f\t%f"%(data["shortestPath"], data["longestPath"], data["instrTotal"])
	stats_file.write("\t<path>\n")
	stats_file.write("\t\t<shortest>%f</shortest>\n"%data["shortestPath"])
	stats_file.write("\t\t<longest>%f</longest>\n"%data["longestPath"])
	stats_file.write("\t\t<instrTotal>%f</instrTotal>\n"%data["instrTotal"])
	stats_file.write("\t</path>\n")
'''
	ax1 = fig.add_subplot(121)
	rect1 = ax1.bar(ind, [data["read"]["min"], data["read"]["max"]], width, color=tableau_colors[colors[0]], edgecolor='black')
	rect2 = ax1.bar(ind, [data["write"]["min"], data["write"]["max"]], width, bottom=[data["read"]["min"], data["read"]["max"]], color=tableau_colors[colors[1]], edgecolor='black')
	ax1.set_xlabel("queries on a single path")
	ax1.set_ylabel("number of queries")
	ax1.set_xticks(ind + width/2)
	ax1.set_xticklabels(('min','max'))
	ax1.legend((rect1[0], rect2[0]), ('read','write'),prop={'size':'12'}, loc='upper left')

	ind = np.arange(1)
	ax2 = fig.add_subplot(122)
	rect1 = ax2.bar(ind, [data["shortestPath"]], width, color=tableau_colors[colors[2]], edgecolor='black')
	rect2 = ax2.bar(ind+width, [data["longestPath"]], width, color=tableau_colors[colors[3]], edgecolor='black')
	rect3 = ax2.bar(ind+width*2, [data["instrTotal"]], width, color=tableau_colors[colors[4]], edgecolor='black')

	#rect1 = ax2.bar(ind, [data["shortestPath"], data["longestPath"], data["instrTotal"]], color=tableau_colors[colors[2], colors[3], colors[4]], edgecolor='black')
	ax2.set_xlabel("path length")
	ax2.set_ylabel("number of instructions")
	#ax2.set_xticks(ind + width/2)
	#ax2.set_xticklabels(('shortestPath','longestPath','ignorePathTotal'))
	ax2.set_xticklabels((''))
	ax2.legend((rect1[0], rect2[0], rect3[0]), ('shortest_Path', 'longestPath', 'ignorePathTotal'), loc='upper left', prop={'size':'10'})
	
	plt.tight_layout(pad=1.08, h_pad=None, w_pad=None, rect=None)
	#plt.show()
	fig.savefig("%s/path.pdf"%(fig_path))
'''


#print_general_stat(general_stats_prefix, general_stats_content, True)
#for table in table_names:
#	pref = table_stats_prefix[:]
#	pref.append(table)
#	if table == "general":
pref = table_stats_prefix[:]
pref.append("general")
print_general_stat(pref, general_stats_content, True, True)
'''
#	else:
#		print_general_stat(pref, table_stats_content, False, False)

print_table_query_stat(pref)
print_fields(nonfield_prefix, field_stats_content, True)
print_fields(field_prefix, field_stats_content)
print_path(prefix3, path_stats_content+path_stats_content2)

print_view_stat(view_stat_prefix)
print_clique_stat(clique_stat_prefix)
print_schema_stat(schema_stat_prefix, table_stats_prefix)

print_query_string("")
print_const_stat("")
print_chain(prefix2, [])

print_other_stat("")
#print_select_condition("")
'''
print_redundant_data("")
#print_order_stat("")
stats_file.write("</%s>"%app_name)

