import numpy as np
import xml.etree.ElementTree as ET
import sys
import glob
import os
import matplotlib.pyplot as plt

app_string="forem lobsters linuxfr sugar kandan onebody communityengine diaspora calagator rucksack railscollab jobsworth gitlab kanban fulcrum tracks boxroom brevidy wallgig shoppe amahiPlatform sharetribe enki publify"

applications = app_string.split(" ")
result_path = "../../applications/general_stats/"

applications_on_figure = {}
i=1
for a in applications:
	temp_str = a[0:3].upper()
	applications_on_figure[a] = temp_str
	i += 1
roots = {}

if os.path.isdir(result_path) == False:
	os.system("mkdir %s"%result_path)

for app in applications:
	print "python stats.py %s %s/%s_stat.xml"%(app, result_path, app)
	os.system("python stats.py %s %s/%s_stat.xml"%(app, result_path, app))
	fname = "%s/%s_stat.xml"%(result_path, app)
	print fname
	tree = ET.parse(fname)
	roots[app] = tree.getroot()

def print_csv_func(stat_name, label, csv_file_name):
	legends = []
	legends.append("barID")
	data = {}
	for app in applications:
		data[app] = {}
		for node in roots[app]:
			if node.tag == stat_name:
				for c in node:
					if c.tag not in legends:
						legends.append(c.tag)
					data[app][c.tag] = c.text
	fp = open(csv_file_name, "w")
	fp.write("%s\n"%(','.join(legends)))
	for app in applications:
		ary = []
		ary.append(applications_on_figure[app])	
		for l in legends:
			if l in data[app]:
				ary.append(data[app][l])
			else:
				ary.append('0')
		fp.write("%s\n"%(','.join(ary)))
	fp.close()


stats=["queryGeneral","redundantField", "queryCard", "queryOnlyToQuery", "fieldOnlyConst", "fieldNoInput", "queryPartial"]
YaxisLabel = {}
YaxisLabel["queryOnlyToQuery"] = "Avg #queries in an action"
YaxisLabel["queryPartial"] = "Avg #queries in an action"
YaxisLabel["queryGeneral"] = "Avg #queries in an action"
YaxisLabel["fieldOnlyConst"] = "#fields"
YaxisLabel["fieldNoInput"] = "#fields"
YaxisLabel["redundantField"] = "field size by byte"
YaxisLabel["queryCard"] = "Avg #query in an action"

for s in stats:
	print_csv_func(s, YaxisLabel[s], "%s/%s.csv"%(result_path, s))
