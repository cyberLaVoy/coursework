

def targetfile():
	target = input("Target filename: ")
	return target

def canidatefiles():
	canidates = input("Canidates filename: ")
	return canidates

def tstr(target):
	fin = open(target, "r")
	targetstr = "" 
	for line in fin:
		line = line.strip()
		targetstr += line
	fin.close()
	return targetstr

def clist(canidates):
	fin = open(canidates, "r")
	canidateslist = []
	for line in fin:
		line = line.strip()
		canidateslist.append(line)
	fin.close()
	return canidateslist

def sequence(targetstr, canidateslist):
	matchlist = []
	for item in canidateslist:
		matches = 0
		for i in range(len(targetstr)):
			if item[0:i+1] == targetstr[len(targetstr)-1-i:len(targetstr)+1]:
				matches = (i+1)
			if matches > 0:
				matches = 0
				#print("found a match of " + str(i+1) + " bases:")
				#print(targetstr[0:len(targetstr)-i-1] , item[0:i+1] , item[i+1: len(item)])
				match = targetstr[0:len(targetstr)-i-1] + item[0:i+1] + item[i+1: len(item)]
				matchlist.append(match)
	return matchlist

def ideal(matchlist):
	value = 1000000000
	for i in range(len(matchlist)):
		if len(matchlist[i]) < value:
			shortest = matchlist[i]
			value = len(matchlist[i])
	print(shortest)

def main():
	target = targetfile()
	canidates = canidatefiles()
	targetstr = tstr(target)
	canidateslist = clist(canidates)
	matchlist = sequence(targetstr, canidateslist)
	ideal(matchlist)
	
main()





