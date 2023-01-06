import random

def inputGen(ifile):
	fin = open(ifile, "w")
	fin.write("DT .5" + "\n")
	x = 10
	forces_count = 0
	while (x < 700):
		anchor = "P " + str(x) + " 0 0 0 2 1 \n" 
		bouncing = "P " + str(x) + " -1 0 0 13 0 \n" 
		fin.write(anchor)
		fin.write(bouncing)
		x += 10
		forces_count += 1
	particle_index = 0
	for i in range(forces_count):
		num = float(random.randrange(60, 101))
		num /= 100
		spring = "SF " + str(particle_index) + " " + str(particle_index+1) + " .5 .1 1 0 0 " + str(num) + "\n"
		fin.write(spring)
		particle_index += 2
	fin.write("DF .001" + "\n")
	fin.write("GF 0 -0.5" + "\n")
	fin.close()

def main():
	ifile = "input.txt"
	inputGen(ifile)
	return
main()
