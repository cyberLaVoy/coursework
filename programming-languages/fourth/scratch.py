count = 0
for i in range(2):
	for m in range(4):
		for c in range(4):
			if (m >= c and 3-m >= 3-c) or m == 0 or m == 3:
				print(str(c)+str(m)+str(i)+' , ', end="")
				count += 1
print(count)
