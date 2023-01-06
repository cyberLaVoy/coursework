import matrix

def main():
	A = matrix.Matrix([[66,244,176],
			   [66, 134, 244],
			   [49, 247,69]])
	B = matrix.Matrix([[59, 191,189],
			   [0,0,255],
			   [187,0,255]])
	C = A+B
	print(C)
	C.transpose()
	print(C)
	C.scale(.5)
	print(C)
	print(C.mean())
main()
