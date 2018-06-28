import math
import numpy as np

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

def calculateAverageRecursive(cond_list, pos, node, to_float, count_loop):
	results = []
	results_loop = []
	for child in node:
		if child.tag == cond_list[pos]:
			if pos ==  len(cond_list)-1:
				if count_loop and child.attrib["in_loop"]:
					results_loop.append(int(child.attrib["in_loop"], 10))
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
				if count_loop:
					r = calculateAverageRecursive(cond_list, pos+1, child, to_float, count_loop)
					results = results + r[0]
					results_loop = results_loop + r[1]
				else:
					results = results + calculateAverageRecursive(cond_list, pos+1, child, to_float, count_loop)
	if count_loop:
		return [results, results_loop]
	else:
		return results

def calculateAllActions(roots, cond_list, to_float=True, count_loop=False):
	result = []
	result_loop = []
	for root in roots:
		if count_loop:
			r = calculateAverageRecursive(cond_list, 0, root, to_float, count_loop)
			result += r[0]
			result_loop += r[1]
		else:
			result = result + calculateAverageRecursive(cond_list, 0, root, to_float, count_loop)
	if count_loop:
		return [result, result_loop]
	else:
		return result

#result = {{attrib_value => [value, [all_attribs]]},}
def collectByAttributeRecursive(cond_list, pos, node, results, main_attrib, other_attribs):
	for child in node:
		if child.tag == cond_list[pos]:
			if pos ==  len(cond_list)-1:
				if child.attrib[main_attrib] not in results:
					results[child.attrib[main_attrib]] = []
				others = []
				for o in other_attribs:
					others.append(child.attrib[o])
				results[child.attrib[main_attrib]].append([child.text, others])
			else:
				collectByAttributeRecursive(cond_list, pos+1, child, results, main_attrib, other_attribs) 

def collectByAttribute(roots, cond_list, main_attrib, other_attribs):
	results = {}
	for root in roots:
		collectByAttributeRecursive(cond_list, 0, root, results, main_attrib, other_attribs)
	return results

def calculateAllActionsDiv(roots, cond_list, to_float=True):
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

def collectAllTagsRecursive(cond_list, pos, node, results):
	for child in node:
		if child.tag == cond_list[pos]:
			if pos == len(cond_list)-1:
				for c in child:
					if c.tag not in results:
						results.append(c.tag)
			else:
				collectAllTagsRecursive(cond_list, pos+1, child, results)

def collectAllTags(roots, cond_list):
	results = []
	for root in roots:
		collectAllTagsRecursive(cond_list, 0, root, results)
	return results

def calculateCountRecursive(cond_list, pos, node, results):
	for child in node:
		if child.tag == cond_list[pos]:
			if pos == len(cond_list)-1:
				for c in child:
					#ignore the tag for the data to be counted
						if c.text not in results:
							results[c.text] = 0
						results[c.text] += 1
			else:
				calculateCountRecursive(cond_list, pos+1, child, results)

def calculateCount(roots, cond_list):
	results = {}
	for root in roots:
		calculateCountRecursive(cond_list, 0, root, results)
	return results

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
